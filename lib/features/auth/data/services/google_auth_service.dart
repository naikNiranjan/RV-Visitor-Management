import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'google_auth_service.g.dart';

@riverpod
class GoogleAuthService extends _$GoogleAuthService {
  final _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  @override
  FutureOr<void> build() {}

  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw 'Google Sign In was cancelled';
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      return await _auth.signInWithCredential(credential);
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