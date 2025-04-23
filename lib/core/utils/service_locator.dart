import 'package:get_it/get_it.dart';
import 'package:the_salon/core/services/firebase_auth_service.dart';
import 'package:the_salon/core/services/firebase_storage_service.dart';
import 'package:the_salon/core/services/firestore_appointments_service.dart';
import 'package:the_salon/core/services/firestore_barbers_service.dart';
import 'package:the_salon/core/services/firestore_users_service.dart';
import 'package:the_salon/core/services/image_picker_service.dart';
import 'package:the_salon/features/appointments/data/datasources/appointment_remote_datasource.dart';
import 'package:the_salon/features/appointments/data/repos/appointment_repo_impl.dart';
import 'package:the_salon/features/appointments/domain/repos/appointment_repo.dart';
import 'package:the_salon/features/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:the_salon/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:the_salon/features/auth/data/repos/auth_repo_impl.dart';
import 'package:the_salon/features/auth/domain/repos/auth_repo.dart';
import 'package:the_salon/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:the_salon/features/barbers/data/datasources/barbers_remote_datasource.dart';
import 'package:the_salon/features/barbers/data/repos/barbers_repo_impl.dart';
import 'package:the_salon/features/barbers/domain/repos/barbers_repo.dart';
import 'package:the_salon/features/barbers/presentation/bloc/barbers_bloc.dart';
import 'package:the_salon/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:the_salon/features/profile/data/repos/profile_repo_impl.dart';
import 'package:the_salon/features/profile/domain/repos/profile_repo.dart';
import 'package:the_salon/features/profile/presentation/bloc/profile_bloc.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // services
  getIt.registerLazySingleton<FirestoreUsersService>(
    () => FirestoreUsersService(),
  );
  getIt.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
  getIt.registerLazySingleton<FirestoreBarbersService>(
    () => FirestoreBarbersService(),
  );
  getIt.registerLazySingleton<ImagePickerService>(() => ImagePickerService());
  getIt.registerLazySingleton<FirebaseStorageService>(
    () => FirebaseStorageService(),
  );
  getIt.registerLazySingleton<FirestoreAppointmentsService>(
    () => FirestoreAppointmentsService(),
  );

  // datasources
  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(
      authService: getIt(),
      usersService: getIt(),
      barbersService: getIt(),
      storageService: getIt(),
    ),
  );
  getIt.registerLazySingleton<AppointmentRemoteDatasource>(
    () => AppointmentRemoteDatasourceImpl(),
  );
  getIt.registerLazySingleton<ProfileRemoteDatasource>(
    () => ProfileRemoteDatasourceImpl(appointmentsService: getIt()),
  );
  getIt.registerLazySingleton<BarbersRemoteDatasource>(
    () => BarbersRemoteDatasourceImpl(barbersService: getIt()),
  );

  // repos
  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(authRemoteDatasource: getIt()),
  );
  getIt.registerLazySingleton<AppointmentRepo>(
    () => AppointmentRepoImpl(appointmentRemoteDatasource: getIt()),
  );
  getIt.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(profileRemoteDatasource: getIt()),
  );
  getIt.registerLazySingleton<BarbersRepo>(
    () => BarbersRepoImpl(barbersRemoteDatasource: getIt()),
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
  getIt.registerFactory<ProfileBloc>(() => ProfileBloc(repo: getIt()));
  getIt.registerFactory<BarbersBloc>(() => BarbersBloc(repo: getIt()));
}
