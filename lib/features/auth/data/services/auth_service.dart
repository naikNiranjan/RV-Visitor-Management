import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'session_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'auth_service.g.dart';

@Riverpod(keepAlive: true)
class Auth extends _$Auth {
  @override
  Stream<User?> build() {
    return FirebaseAuth.instance.authStateChanges();
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
      
      // Save user role in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'role': role,
        'email': email,
        'lastLogin': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      
      // Save session with role
      final token = await credential.user?.getIdToken();
      if (token != null && credential.user != null) {
        await ref.read(sessionServiceProvider.notifier).saveSession(
          token: token,
          userId: credential.user!.uid,
          role: role,
        );
      }
      
      return credential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String role,
    required String username,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Save user data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user!.uid)
          .set({
        'role': role,
        'email': email,
        'username': username,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
      });
      
      // Save session with role
      final token = await credential.user?.getIdToken();
      if (token != null && credential.user != null) {
        await ref.read(sessionServiceProvider.notifier).saveSession(
          token: token,
          userId: credential.user!.uid,
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
    await ref.read(sessionServiceProvider.notifier).clearSession();
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
      default:
        return 'Authentication failed: ${e.message}';
    }
  }
} 