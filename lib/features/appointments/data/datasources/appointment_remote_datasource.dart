import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_salon/core/services/firestore_appointments_service.dart';
import 'package:the_salon/core/services/firestore_barbers_service.dart';
import 'package:the_salon/features/appointments/data/models/appointment_model.dart';
import 'package:the_salon/features/auth/data/models/user_model.dart';

abstract class AppointmentRemoteDatasource {
  // add appointment to firestore
  Future<void> addApointmentToFirestore(AppointmentModel appointment);

  // get all barbers
  Future<List<UserModel>> getAllBarbers();

  // fetch booked appointments
  Future<List<AppointmentModel>> fetchBookedAppointments(
    String barberId,
    Timestamp startDate,
    Timestamp endDate,
  );

  // get
}

class AppointmentRemoteDatasourceImpl implements AppointmentRemoteDatasource {
  final _firestore = FirebaseFirestore.instance;
  final _collection = 'appointments';

  // services
  final appointmentService = FirestoreAppointmentsService();
  final barbersService = FirestoreBarbersService();

  @override
  Future<void> addApointmentToFirestore(AppointmentModel appointment) async {
    appointmentService.addAppointmentToFirestore(appointment);
  }

  @override
  Future<List<AppointmentModel>> fetchBookedAppointments(
    String barberId,
    Timestamp startDate,
    Timestamp endDate,
  ) async {
    final query = _firestore
        .collection(_collection)
        .where('barber_id', isEqualTo: barberId)
        .where('date', isGreaterThanOrEqualTo: startDate)
        .where('date', isLessThan: endDate);

    return appointmentService.fetchAppointmentsByQuery(query);
  }

  @override
  Future<List<UserModel>> getAllBarbers() async {
    return await barbersService.fetchAllBarbers();
  }
}
