import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_salon/features/auth/data/models/user_model.dart';

class FirestoreUsersService {
  final _usersCollection = FirebaseFirestore.instance.collection('users');

  Future<void> addUserToFirestore(UserModel user) async {
    try {
      await _usersCollection.doc(user.id).set(user.toMap());
    } catch (e) {
      throw Exception('failed to add user to firestore');
    }
  }

  Future<UserModel?> fetchUserFromFirestore(String userId) async {
    try {
      // check if user exists in firestore
      final docSnapshot = await _usersCollection.doc(userId).get();

      // return null if user is not exist in firestore
      if (!docSnapshot.exists) {
        return null;
      }

      // fetch user from users db
      final data = docSnapshot.data();

      if (data == null) {
        return null;
      }

      return UserModel.fromJson(data);
    } catch (e) {
      throw Exception('failed to fetch user from firestore');
    }
  }
}
