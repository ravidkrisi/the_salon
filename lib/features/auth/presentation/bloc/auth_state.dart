import 'package:the_salon/features/auth/domain/entities/user_entity.dart';

abstract class AuthState {}

// init
class AuthInit extends AuthState {}

// loading
class AuthLoading extends AuthState {}

// Authenticated
class AuthAuthenticated extends AuthState {
  final UserEntity user;
  AuthAuthenticated({required this.user});
}

// first time user
class AuthFirstTimeUser extends AuthState {
  final String userId;
  final String name;
  final String email;
  final String phoneNumber;
  final String profileImageUrl;
  AuthFirstTimeUser({
    required this.userId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profileImageUrl,
  });
}

// unauthenticated
class AuthUnauthenticated extends AuthState {}

// errors
class AuthErrors extends AuthState {
  final String message;
  AuthErrors({required this.message});
}
