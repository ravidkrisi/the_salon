import 'package:the_salon/features/appointments/domain/entities/appointment.dart';

abstract class ProfileRepo {
  // get user's past appointments
  Future<List<Appointment>> getUserPastAppointments(String userId);
  // get user's upcoming appointments
  Future<List<Appointment>> getUserUpcomingAppointments(String userId);
}
