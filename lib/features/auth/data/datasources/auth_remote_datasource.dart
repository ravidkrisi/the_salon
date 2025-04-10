// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_salon/core/services/firebase_auth_service.dart';
import 'package:the_salon/core/services/firestore_barbers_service.dart';
import 'package:the_salon/core/services/firestore_users_service.dart';
import 'package:the_salon/features/auth/data/models/barber_model.dart';
import 'package:the_salon/features/auth/data/models/user_model.dart';
import 'package:the_salon/features/auth/domain/entities/user_entity.dart';

abstract class AuthRemoteDatasource {
  // sign in with google
  Future<User?> signInWithGoogle();
  // get current user
  Future<UserModel?> getCurrentUser();
  // logout
  Future<void> logout();
  // create user first time
  Future<void> signUpUser(UserModel user);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuthService authService;
  final FirestoreUsersService usersService;
  final FirestoreBarbersService barbersService;
  AuthRemoteDatasourceImpl({
    required this.authService,
    required this.usersService,
    required this.barbersService,
  });
  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      // get user from auth
      final user = await authService.getCurrentUser();

      // user not authenticated -> null
      if (user == null) return null;

      // fetch user from firestore
      final userModel = await usersService.fetchUserFromFirestore(user.uid);

      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await authService.logout();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User?> signInWithGoogle() async {
    try {
      final user = await authService.signInWithGoogle();
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signUpUser(UserModel user) async {
    try {
      if (user is BarberModel) {
        await usersService.addUserToFirestore(user.toBaseMap(), user.id);
        await barbersService.addBarberToFirestore(user.toMap(), user.id);
        return;
      }

      await usersService.addUserToFirestore(user.toMap(), user.id);
    } catch (e) {
      rethrow;
    }
  }
}
