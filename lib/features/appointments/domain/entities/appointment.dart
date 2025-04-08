// ignore_for_file: public_member_api_docs, sort_constructors_first
class Appointment {
  final String id;
  final String customerId;
  final String barberId;
  final DateTime date;
  final String time;
  final AppointmentStatus status;
  Appointment({
    required this.id,
    required this.customerId,
    required this.barberId,
    required this.date,
    required this.time,
    required this.status,
  });
}

enum AppointmentStatus { booked, cancelled }
