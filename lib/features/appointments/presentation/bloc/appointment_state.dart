// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:the_salon/features/auth/domain/entities/user_entity.dart';

abstract class AppointmentState {}

// init
class AppointmentInit extends AppointmentState {}

// loading
class AppointmentLoading extends AppointmentState {}

// // barber selected
// class AppointmentBarberSelectedState extends AppointmentState {
//   final String barberId;
//   final List<String> availableSlots;
//   AppointmentBarberSelectedState({
//     required this.availableSlots,
//     required this.barberId,
//   });
// }

// // time selected
// class AppointmentTimeSelectedState extends AppointmentState {
//   final String barberId;
//   final String time;
//   AppointmentTimeSelectedState({required this.barberId, required this.time});
// }

// loaded
class AppointmentLoaded extends AppointmentState {
  final List<UserEntity> barbers;
  final String? barberId;
  final bool isDateLoading;
  final List<DateTime> upcomingDates;
  final DateTime? date;
  final bool isTimeSlotsLoading;
  final List<String> availableSlots;
  final String? time;
  AppointmentLoaded({
    required this.barbers,
    this.barberId,
    this.isDateLoading = false,
    this.upcomingDates = const [],
    this.date,
    this.isTimeSlotsLoading = false,
    this.availableSlots = const [],
    this.time,
  });
}

// errors
class AppointmentErrors extends AppointmentState {
  final String message;
  AppointmentErrors({required this.message});
}
