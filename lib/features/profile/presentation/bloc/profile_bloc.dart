import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_salon/features/profile/domain/repos/profile_repo.dart';
import 'package:the_salon/features/profile/presentation/bloc/profile_event.dart';
import 'package:the_salon/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepo repo;
  ProfileBloc({required this.repo}) : super(ProfileInit()) {
    on<ProfileGetAppointments>(_onGetAppointments);
  }

  Future<void> _onGetAppointments(
    ProfileGetAppointments event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoaded(isLoadingAppointments: true));

    // get appointments
    final upcomingAppointments = await repo.getUserUpcomingAppointments(
      event.userId,
    );
    final pastAppointments = await repo.getUserPastAppointments(event.userId);

    emit(
      ProfileLoaded(
        pastAppointments: pastAppointments,
        upcomingAppointments: upcomingAppointments,
      ),
    );
  }
}
