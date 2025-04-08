// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class AppointmentState {}

// init
class AppointmentInit extends AppointmentState {}

// loading
class AppointmentLoading extends AppointmentState {}

// loaded
class AppointmentLoaded extends AppointmentState {
  final List<String> availableSlots;
  AppointmentLoaded({required this.availableSlots});
}

// errors
class AppointmentErrors extends AppointmentState {
  final String message;
  AppointmentErrors({required this.message});
}
