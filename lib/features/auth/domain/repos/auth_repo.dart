import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_salon/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  // sign in with google
  Future<User?> signInWithGoogle();

  // sign up new user
  Future<void> signUpCustomer(UserEntity user);

  // logout
  Future<void> logout();

  // get current user
  Future<UserEntity?> getCurrentUser();
}
