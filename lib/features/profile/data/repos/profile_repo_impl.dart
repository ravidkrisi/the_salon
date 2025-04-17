// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:the_salon/features/appointments/domain/entities/appointment.dart';
import 'package:the_salon/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:the_salon/features/profile/domain/repos/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDatasource profileRemoteDatasource;
  ProfileRepoImpl({required this.profileRemoteDatasource});

  @override
  Future<List<Appointment>> getUserPastAppointments(String userId) async {
    final appointmentsModel = await profileRemoteDatasource
        .fetchPastAppointments(userId);

    return appointmentsModel
        .map((model) => Appointment.fromModel(model))
        .toList();
  }

  @override
  Future<List<Appointment>> getUserUpcomingAppointments(String userId) async {
    final appointmentsModel = await profileRemoteDatasource
        .fetchUpcomingAppointments(userId);

    return appointmentsModel
        .map((model) => Appointment.fromModel(model))
        .toList();
  }
}
