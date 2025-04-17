// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:the_salon/features/appointments/domain/entities/appointment.dart';

abstract class ProfileState {}

// init
class ProfileInit extends ProfileState {}

// loading
class ProfileLoading extends ProfileState {}

// loaded
class ProfileLoaded extends ProfileState {
  final bool isLoadingAppointments;
  final List<Appointment> pastAppointments;
  final List<Appointment> upcomingAppointments;
  ProfileLoaded({
    this.isLoadingAppointments = false,
    this.pastAppointments = const [],
    this.upcomingAppointments = const [],
  });
}
