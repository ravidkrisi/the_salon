import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_salon/core/errors/appointment_errors.dart';
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
}

class AppointmentRemoteDatasourceImpl implements AppointmentRemoteDatasource {
  final _firestore = FirebaseFirestore.instance;
  final _collection = 'appointments';

  final barbersService = FirestoreBarbersService();
  @override
  Future<void> addApointmentToFirestore(AppointmentModel appointment) async {
    final query = _firestore
        .collection(_collection)
        .where('barber_id', isEqualTo: appointment.barberId)
        .where('date', isEqualTo: appointment.date)
        .where('time', isEqualTo: appointment.time);

    return _firestore.runTransaction((transaction) async {
      final snapshot = await query.get();

      // time slot is already booked
      if (snapshot.docs.isNotEmpty) {
        throw SlotAlreadyBookedException();
      }

      // write appointment to firestore
      final newDoc = _firestore.collection(_collection).doc(appointment.id);
      transaction.set(newDoc, appointment.toJson());
    });
  }

  @override
  Future<List<AppointmentModel>> fetchBookedAppointments(
    String barberId,
    Timestamp startDate,
    Timestamp endDate,
  ) async {
    try {
      final snapshot =
          await _firestore
              .collection(_collection)
              .where('barber_id', isEqualTo: barberId)
              .where('date', isGreaterThanOrEqualTo: startDate)
              .where('date', isLessThan: endDate)
              .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return AppointmentModel.fromJson(data);
      }).toList();
    } catch (e) {
      throw FetchAppointmentsException(error: e.toString());
    }
  }

  @override
  Future<List<UserModel>> getAllBarbers() async {
    return await barbersService.fetchAllBarbers();
  }
}
