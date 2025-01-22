import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../host_management/data/services/host_service.dart';
import '../../../security_management/data/services/security_service.dart';
import 'session_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_service.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  Stream<User?> build() {
    return FirebaseAuth.instance.authStateChanges();
  }

  Stream<User?> get stream => FirebaseAuth.instance.authStateChanges();

  Future<void> _initializeSession() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        final prefs = await SharedPreferences.getInstance();
        final token = await currentUser.getIdToken() ?? '';
        final email = currentUser.email ?? '';

        // Try to get role from Firestore first
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(email)
            .get();

        final role =
            userDoc.data()?['role'] ?? prefs.getString('role') ?? 'Host';

        await ref.read(sessionServiceProvider.notifier).saveSession(
              token: token,
              userId: email,
              role: role,
            );
      } catch (e) {
        print('Failed to initialize session: $e');
      }
    }
  }

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      try {
        // Save role in both Firestore and SharedPreferences
        await FirebaseFirestore.instance.collection('users').doc(email).set({
          'lastLogin': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
          'email': email,
          'role': role,
        }, SetOptions(merge: true));

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('role', role);

        // Save session
        final token = await credential.user?.getIdToken() ?? '';
        await ref.read(sessionServiceProvider.notifier).saveSession(
              token: token,
              userId: email,
              role: role,
            );
      } catch (e) {
        print('Failed to update user data: $e');
      }

      return credential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
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

      try {
        // Save user data in Firestore using email as document ID
        final userData = {
          'email': email,
          'role': 'Host', // Always set as Host
          'username': username,
          'createdAt': FieldValue.serverTimestamp(),
          'lastLogin': FieldValue.serverTimestamp(),
        };

        await FirebaseFirestore.instance
            .collection('users')
            .doc(email)
            .set(userData);

        // Register in hosts collection
        final hostService = HostService();
        await hostService.registerHost(
          email: email,
          name: username,
          department: email.split('@')[0].split('.').first,
          contactNumber: '',
        );
      } catch (e) {
        // Log the error but don't fail the signup
        print('Failed to create user data: $e');
      }

      // Save session
      final token = await credential.user?.getIdToken();
      if (token != null && credential.user != null) {
        await ref.read(sessionServiceProvider.notifier).saveSession(
              token: token,
              userId: email,
              role: 'Host',
            );
      }

      return credential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw FirebaseAuthException(
        code: 'unknown',
        message: 'An unexpected error occurred',
      );
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await ref.read(sessionServiceProvider.notifier).clearSession();
    } catch (e) {
      print('Error signing out: $e');
      throw Exception('Failed to sign out');
    }
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
