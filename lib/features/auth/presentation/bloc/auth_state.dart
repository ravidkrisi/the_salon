// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

// init
class AuthInit extends AuthState {}

// loading
class AuthLoading extends AuthState {}

// Authenticated
class AuthAuthenticated extends AuthState {
  final User user;
  AuthAuthenticated({required this.user});
}

// unauthenticated
class AuthUnauthenticated extends AuthState {}

// errors
class AuthErrors extends AuthState {
  final String message;
  AuthErrors({required this.message});
}
