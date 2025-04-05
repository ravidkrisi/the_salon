// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_salon/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:the_salon/features/auth/data/models/user_model.dart';
import 'package:the_salon/features/auth/domain/entities/user_entity.dart';
import 'package:the_salon/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDatasource authRemoteDatasource;
  AuthRepoImpl({required this.authRemoteDatasource});

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      final userModel = await authRemoteDatasource.getCurrentUser();

      // user not auth -> null
      if (userModel == null) return null;

      // create user entity
      return UserEntity(
        id: userModel.id,
        name: userModel.name,
        email: userModel.email,
        profileImageUrl: userModel.profileImageUrl,
        type: userModel.type,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await authRemoteDatasource.logout();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User?> signInWithGoogle() async {
    try {
      final user = await authRemoteDatasource.signInWithGoogle();
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signUpCustomer(UserEntity user) async {
    try {
      // create user model
      final userModel = UserModel.fromEntity(user);

      await authRemoteDatasource.signUpUser(userModel);
    } catch (e) {
      rethrow;
    }
  }
}
