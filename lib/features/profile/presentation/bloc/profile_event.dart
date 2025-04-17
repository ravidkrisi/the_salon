abstract class ProfileEvent {}

class ProfileGetAppointments extends ProfileEvent {
  final String userId;
  ProfileGetAppointments({required this.userId});
}
