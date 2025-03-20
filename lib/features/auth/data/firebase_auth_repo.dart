import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_salon/features/auth/domain/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final googleSignIn = GoogleSignIn();

  @override
  Future<User?> getCurrentUser() async {
    try {
      // get current user
      return auth.currentUser;
    } catch (e) {
      throw Exception('failed to get current user: $e');
    }
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }

  @override
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
      final userCredential = await auth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      throw Exception('failed to sign in with google: $e');
    }
  }
}
