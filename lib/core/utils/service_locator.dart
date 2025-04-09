import 'package:get_it/get_it.dart';
import 'package:the_salon/core/services/firebase_auth_service.dart';
import 'package:the_salon/core/services/firestore_users_service.dart';
import 'package:the_salon/features/appointments/data/datasources/appointment_remote_datasource.dart';
import 'package:the_salon/features/appointments/data/repos/appointment_repo_impl.dart';
import 'package:the_salon/features/appointments/domain/repos/appointment_repo.dart';
import 'package:the_salon/features/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:the_salon/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:the_salon/features/auth/data/repos/auth_repo_impl.dart';
import 'package:the_salon/features/auth/domain/repos/auth_repo.dart';
import 'package:the_salon/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_bloc.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // services
  getIt.registerLazySingleton<FirestoreUsersService>(
    () => FirestoreUsersService(),
  );
  getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());

  // datasources
  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(authService: getIt(), usersService: getIt()),
  );
  getIt.registerLazySingleton<AppointmentRemoteDatasource>(
    () => AppointmentRemoteDatasourceImpl(),
  );

  // repos
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(authRemoteDatasource: getIt()),
  );
  getIt.registerLazySingleton<AppointmentRepo>(
    () => AppointmentRepoImpl(appointmentRemoteDatasource: getIt()),
  );

  // usecases
  getIt.registerLazySingleton<SignUpUsecase>(
    () => SignUpUsecase(authRepo: getIt()),
  );

  // blocs
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(repo: getIt(), signUpUsecase: getIt()),
  );
  getIt.registerFactory<AppointmentBloc>(() => AppointmentBloc(repo: getIt()));
}
