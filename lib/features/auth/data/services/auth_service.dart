import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'session_service.dart';

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
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Save session
      final token = await credential.user?.getIdToken();
      if (token != null && credential.user != null) {
        await ref.read(sessionServiceProvider.notifier).saveSession(
          token: token,
          userId: credential.user!.uid,
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
  }) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Save session
      final token = await credential.user?.getIdToken();
      if (token != null && credential.user != null) {
        await ref.read(sessionServiceProvider.notifier).saveSession(
          token: token,
          userId: credential.user!.uid,
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
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'Email is already registered.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'weak-password':
        return 'Password is too weak.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
} 