import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'session_service.dart';

part 'google_auth_service.g.dart';

@riverpod
class GoogleAuthService extends _$GoogleAuthService {
  final _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  @override
  FutureOr<void> build() {}

  Future<UserCredential> signInWithGoogle({required String role}) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw 'Google Sign In was cancelled';
      }

      // Validate RVCE email
      if (!googleUser.email.endsWith('@rvce.edu.in')) {
        throw 'Only RVCE email addresses (@rvce.edu.in) are allowed';
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      
      // Save user data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'role': role,
        'email': userCredential.user!.email,
        'lastLogin': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      
      // Save session with role
      final token = await userCredential.user?.getIdToken();
      if (token != null && userCredential.user != null) {
        await ref.read(sessionServiceProvider.notifier).saveSession(
          token: token,
          userId: userCredential.user!.uid,
          role: role,
        );
      }

      return userCredential;
    } catch (e) {
      throw _handleGoogleSignInError(e);
    }
  }

  Future<void> signOut() async {
    await Future.wait([
      _googleSignIn.signOut(),
      _auth.signOut(),
    ]);
  }

  String _handleGoogleSignInError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'account-exists-with-different-credential':
          return 'An account already exists with the same email address.';
        case 'invalid-credential':
          return 'Invalid credentials. Please try again.';
        default:
          return 'An error occurred during sign in. Please try again.';
      }
    }
    return error.toString();
  }
} 