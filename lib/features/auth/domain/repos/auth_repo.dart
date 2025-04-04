import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_salon/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  // sign in with google
  Future<User?> signInWithGoogle();

  // sign up new user
  Future<UserEntity> signUpCustomer(
    String userId,
    String email,
    String name,
    String phoneNumber,
    String profileImageUrl,
  );

  // logout
  Future<void> logout();

  // get current user
  Future<UserEntity?> getCurrentUser();
}
