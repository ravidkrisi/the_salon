// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:the_salon/features/appointments/data/models/appointment_model.dart';

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

  // model -> entity
  factory Appointment.fromModel(AppointmentModel appointment) {
    return Appointment(
      id: appointment.id,
      customerId: appointment.customerId,
      barberId: appointment.barberId,
      date: appointment.date.toDate(),
      time: appointment.time,
      status: AppointmentStatus.fromString(appointment.status),
    );
  }
}

enum AppointmentStatus {
  booked,
  cancelled;

  static AppointmentStatus fromString(String status) {
    return AppointmentStatus.values.firstWhere(
      (value) => value.name == status,
      orElse: () => AppointmentStatus.booked,
    );
  }
}
