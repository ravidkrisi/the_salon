// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_salon/core/services/firestore_appointments_service.dart';
import 'package:the_salon/features/appointments/data/models/appointment_model.dart';

abstract class ProfileRemoteDatasource {
  // fetch past user's appointments by date
  Future<List<AppointmentModel>> fetchPastAppointments(String userId);
  // fetch upcoming user's appointments by date
  Future<List<AppointmentModel>> fetchUpcomingAppointments(String userId);
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  // services
  final FirestoreAppointmentsService appointmentsService;
  ProfileRemoteDatasourceImpl({required this.appointmentsService});
  @override
  Future<List<AppointmentModel>> fetchPastAppointments(String userId) {
    final query = appointmentsService.firestore
        .collection(appointmentsService.collection)
        .where('customer_id', isEqualTo: userId)
        .where('date', isLessThan: Timestamp.now());

    return appointmentsService.fetchAppointmentsByQuery(query);
  }

  @override
  Future<List<AppointmentModel>> fetchUpcomingAppointments(String userId) {
    final query = appointmentsService.firestore
        .collection(appointmentsService.collection)
        .where('customer_id', isEqualTo: userId)
        .where('date', isGreaterThanOrEqualTo: Timestamp.now());

    return appointmentsService.fetchAppointmentsByQuery(query);
  }
}
