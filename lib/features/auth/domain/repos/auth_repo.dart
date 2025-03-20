import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  // sign in with google
  Future<User?> signInWithGoogle();

  // logout
  Future<void> logout();

  // get current user
  Future<User?> getCurrentUser();
}
