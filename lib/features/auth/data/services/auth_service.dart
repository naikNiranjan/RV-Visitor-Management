import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../host_management/data/services/host_service.dart';
import '../../../security_management/data/services/security_service.dart';
import 'session_service.dart';

part 'auth_service.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  Stream<User?> build() {
    return FirebaseAuth.instance.authStateChanges();
  }

  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
    required String role,
    String? username,
  }) async {
    try {
      // First authenticate with Firebase Auth
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Then check user role in Firestore
      final userDoc =
          await FirebaseFirestore.instance.collection('users').doc(email).get();

      if (!userDoc.exists) {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No user found with this email',
        );
      }

      final userData = userDoc.data()!;
      final userRole = userData['role'] as String?;

      // Case-insensitive role comparison
      if (role.toLowerCase() != userRole?.toLowerCase()) {
        // Sign out if role doesn't match
        await FirebaseAuth.instance.signOut();
        throw FirebaseAuthException(
          code: 'invalid-role',
          message: role.toLowerCase() == 'security'
              ? 'This account is not authorized for security login'
              : 'Security personnel must use security login',
        );
      }

      // If security role, verify in security collection
      if (role.toLowerCase() == 'security') {
        final securityDoc = await FirebaseFirestore.instance
            .collection('security')
            .doc(email)
            .get();

        if (!securityDoc.exists) {
          // Sign out if security record doesn't exist
          await FirebaseAuth.instance.signOut();
          throw FirebaseAuthException(
            code: 'invalid-role',
            message: 'Security account not properly configured',
          );
        }
      }

      // Update last login in users collection
      await FirebaseFirestore.instance.collection('users').doc(email).update({
        'lastLogin': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // If security role, also update security collection
      if (role.toLowerCase() == 'security') {
        await FirebaseFirestore.instance
            .collection('security')
            .doc(email)
            .update({
          'lastLogin': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }

      // Save session
      final token = await credential.user?.getIdToken();
      if (token != null && credential.user != null) {
        await ref.read(sessionServiceProvider.notifier).saveSession(
              token: token,
              userId: email,
              role: role,
            );
      }

      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-role') {
        // Make sure to sign out if there's a role mismatch
        await FirebaseAuth.instance.signOut();
      }
      throw _handleAuthException(e);
    } catch (e) {
      // Sign out on any other error
      await FirebaseAuth.instance.signOut();
      throw FirebaseAuthException(
        code: 'unknown',
        message: 'An unexpected error occurred',
      );
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String role,
    required String username,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user data in Firestore using email as document ID
      final userData = {
        'email': email,
        'role': role,
        'username': username,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
      };

      // Use email as document ID instead of UID
      await FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .set(userData);

      // If role is host, register in hosts collection
      if (role.toLowerCase() == 'host') {
        final hostService = HostService();
        await hostService.registerHost(
          email: email,
          name: username,
          department: email.split('@')[0].split('.').first,
          contactNumber: '',
        );
      }

      // If role is security, register in security collection
      if (role.toLowerCase() == 'security') {
        final securityService = SecurityService();
        await securityService.registerSecurity(
          email: email,
          name: username,
          contactNumber: '',
        );
      }

      // Save session with role
      final token = await credential.user?.getIdToken();
      if (token != null && credential.user != null) {
        await ref.read(sessionServiceProvider.notifier).saveSession(
              token: token,
              userId: email, // Use email as userId
              role: role,
            );
      }

      return credential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    // Optionally clear session if needed
    // await ref.read(sessionServiceProvider.notifier).clearSession();
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'invalid-email':
        return 'Please enter a valid RVCE email address';
      case 'email-already-in-use':
        return 'This email is already registered';
      case 'weak-password':
        return '''Password is too weak. Password must:
• Be at least 8 characters
• Include uppercase and lowercase letters
• Include numbers
• Include special characters''';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later';
      case 'operation-not-allowed':
        return 'Email/password sign in is not enabled';
      case 'invalid-role':
        return 'This account is not authorized for the selected login type';
      case 'auth/invalid-credential':
        return 'Invalid email or password';
      default:
        return 'Authentication failed: ${e.message}';
    }
  }

  Future<Map<String, dynamic>?> fetchUserData(String uid) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return userDoc.data();
  }
}
