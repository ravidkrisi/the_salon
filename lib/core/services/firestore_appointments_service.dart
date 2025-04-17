import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_salon/core/errors/appointment_errors.dart';
import 'package:the_salon/features/appointments/data/models/appointment_model.dart';

class FirestoreAppointmentsService {
  final firestore = FirebaseFirestore.instance;
  final collection = 'appointments';

  // add appointment to firestore
  Future<void> addAppointmentToFirestore(AppointmentModel appointment) async {
    final query = firestore
        .collection(collection)
        .where('barber_id', isEqualTo: appointment.barberId)
        .where('date', isEqualTo: appointment.date)
        .where('time', isEqualTo: appointment.time);

    return firestore.runTransaction((transaction) async {
      final snapshot = await query.get();

      // time slot is already booked
      if (snapshot.docs.isNotEmpty) {
        throw SlotAlreadyBookedException();
      }

      // write appointment to firestore
      final newDoc = firestore.collection(collection).doc(appointment.id);
      transaction.set(newDoc, appointment.toJson());
    });
  }

  // fetch appointments by query
  Future<List<AppointmentModel>> fetchAppointmentsByQuery(Query query) async {
    try {
      final snapshot = await query.get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return AppointmentModel.fromJson(data);
      }).toList();
    } catch (e) {
      throw FetchAppointmentsException(error: e.toString());
    }
  }
}
