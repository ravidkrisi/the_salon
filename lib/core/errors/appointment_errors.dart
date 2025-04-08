// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppointmentErrors implements Exception {
  final String message;
  AppointmentErrors({required this.message});

  @override
  String toString() => message;
}

class SlotAlreadyBookedException extends AppointmentErrors {
  SlotAlreadyBookedException() : super(message: 'slot is unavaible');
}

class FetchAppointmentsException extends AppointmentErrors {
  final String error;
  FetchAppointmentsException({required this.error})
    : super(message: 'failed to fetch appointments: $error');
}
