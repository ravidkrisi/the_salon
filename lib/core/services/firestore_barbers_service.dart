import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_salon/features/auth/data/models/user_model.dart';

class FirestoreBarbersService {
  final _firestore = FirebaseFirestore.instance;
  final _collection = 'barbers';

  // add barber to firestore
  Future<void> addBarberToFirestore(
    Map<String, dynamic> data,
    String docId,
  ) async {
    try {
      await _firestore.collection(_collection).doc(docId).set(data);
    } catch (e) {
      throw Exception('failed to add barber to barbers: $e');
    }
  }

  // fetch all barbers from barbers collection
  Future<List<UserModel>> fetchAllBarbers() async {
    try {
      final snapshot = await _firestore.collection(_collection).get();

      final barbers =
          snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList();

      return barbers;
    } catch (e) {
      throw Exception('failed to fetch all barbers: $e');
    }
  }
}
