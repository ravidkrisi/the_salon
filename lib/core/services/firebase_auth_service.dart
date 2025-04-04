import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      // start sign in interactive
      final googleUser = await googleSignIn.signIn();

      // sign in process aborted
      if (googleUser == null) return null;

      // sign in succeed
      final googleAuth = await googleUser.authentication;

      // create credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      // sign in with credential
      final userCredential = await _auth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      throw Exception('failed to sign in with google: $e');
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      return _auth.currentUser;
    } catch (e) {
      throw Exception('failed to get current user');
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('failed to log out');
    }
  }
}
