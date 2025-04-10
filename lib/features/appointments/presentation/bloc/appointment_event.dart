// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:the_salon/features/appointments/domain/entities/appointment.dart';

abstract class AppointmentEvent {}

// get all barbers
class AppointmentGetAllBarbers extends AppointmentEvent {}

// barber selected
class AppointmentBarberSelected extends AppointmentEvent {
  final String barberId;
  AppointmentBarberSelected({required this.barberId});
}

// time selected
class AppointmentTimeSelected extends AppointmentEvent {
  final String time;
  AppointmentTimeSelected({required this.time});
}

// book appointment
class AppointmentBookAppointment extends AppointmentEvent {
  final Appointment appointment;
  AppointmentBookAppointment({required this.appointment});
}

// get all available slots by barber id
class AppointmentGetAvailableSlots extends AppointmentEvent {
  final String barberId;
  AppointmentGetAvailableSlots({required this.barberId});
}
