// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_salon/features/auth/domain/entities/user_entity.dart';

import 'package:the_salon/features/auth/domain/repos/auth_repo.dart';
import 'package:the_salon/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_event.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo repo;
  final SignUpUsecase signUpUsecase;

  AuthBloc({required this.repo, required this.signUpUsecase})
    : super(AuthInit()) {
    // register handlers
    on<AuthSignInWithGoogle>(_onSignInWithGoogle);
    on<AuthCheckAuth>(_onCheckAuth);
    on<AuthLogout>(_onLogout);
    on<AuthSignUpUser>(_onSignUpUser);

    // check auth when initial
    add(AuthCheckAuth());
  }

  // handlers
  void _onSignInWithGoogle(
    AuthSignInWithGoogle event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final user = await repo.signInWithGoogle();

      // sign in falied
      if (user == null) emit(AuthUnauthenticated());

      // sign in succeed

      // check if user exists in firestore
      final userEntity = await repo.getCurrentUser();

      // user first time
      if (userEntity == null) {
        emit(
          AuthFirstTimeUser(
            userId: user?.uid ?? '',
            name: user?.displayName ?? '',
            email: user?.email ?? '',
            phoneNumber: user?.phoneNumber ?? '',
            profileImageUrl: user?.photoURL ?? '',
          ),
        );
      }
      // user exists
      else {
        emit(AuthAuthenticated(user: userEntity));
      }
    } catch (e) {
      emit(AuthErrors(message: e.toString()));
    }
  }

  void _onCheckAuth(AuthCheckAuth event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final user = await repo.getCurrentUser();

      // user is not authenticated
      if (user == null) {
        emit(AuthUnauthenticated());
        return;
      }

      // user is authenticated
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthErrors(message: e.toString()));
    }
  }

  void _onSignUpUser(AuthSignUpUser event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());

      //
      if (event.type == UserType.barber) {}

      final userEntity = UserEntity.create(
        event.userId,
        event.name,
        event.email,
        event.profileImageUrl,
        event.type,
      );
      final user = await signUpUsecase(userEntity);

      if (user == null) {
        emit(AuthUnauthenticated());
        return;
      }

      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthErrors(message: e.toString()));
    }
  }

  void _onLogout(AuthLogout event, Emitter<AuthState> emit) async {
    try {
      repo.logout;
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthErrors(message: e.toString()));
    }
  }
}
