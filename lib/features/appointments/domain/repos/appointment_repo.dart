import 'package:the_salon/features/appointments/domain/entities/appointment.dart';
import 'package:the_salon/features/auth/domain/entities/user_entity.dart';

abstract class AppointmentRepo {
  // create new appointment
  Future<void> bookAppointment(Appointment appointment);
  // get all apointments by barber id
  Future<List<String>> getAvailableSlotsByBarberId(String barberId);
  // get all barbers
  Future<List<UserEntity>> getAllBarbers();
}
