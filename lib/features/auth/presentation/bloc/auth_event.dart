// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:the_salon/features/auth/domain/entities/user_entity.dart';

abstract class AuthEvent {}

// sign in with google
class AuthSignInWithGoogle extends AuthEvent {}

// get current user
class AuthCheckAuth extends AuthEvent {}

// create first time user
class AuthSignUpUser extends AuthEvent {
  final String userId;
  final String email;
  final String name;
  final String phoneNumber;
  final String profileImageUrl;
  final UserType type;
  AuthSignUpUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.type,
  });
}

// logout
class AuthLogout extends AuthEvent {}
