import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_salon/features/auth/domain/entities/user_entity.dart';
import 'package:the_salon/features/auth/domain/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final googleSignIn = GoogleSignIn();

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      // get current user
      final user = auth.currentUser;

      // if user not exist return null
      if (user == null) {
        return null;
      }

      // check if user exists in firestore
      final docSnapshot =
          await firestore.collection('users').doc(user.uid).get();

      // return null if user is not exist in firestore
      if (!docSnapshot.exists) {
        return null;
      }

      // fetch user from users db
      final data = docSnapshot.data();

      if (data == null) {
        return null;
      }

      return UserEntity.fromJson(data);
    } catch (e) {
      throw Exception('failed to get current user: $e');
    }
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }

  @override
  Future<User?> signInWithGoogle() async {
    try {
      // start sign in interactive
      final googleUser = await googleSignIn.signIn();

      // sign in process aborted
      if (googleUser == null) return null;

      // sign in succeed
      final googleAuth = await googleUser.authentication;

      // create credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      // sign in with credential
      final userCredential = await auth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      throw Exception('failed to sign in with google: $e');
    }
  }

  @override
  Future<UserEntity> signUpCustomer(
    String userId,
    String email,
    String name,
    String phoneNumber,
    String profileImageUrl,
  ) async {
    try {
      final user = UserEntity(
        id: userId,
        name: name,
        email: email,
        profileImageUrl: profileImageUrl,
        type: UserType.customer,
      );

      await firestore.collection('users').doc(userId).set(user.toMap());
      return user;
    } catch (e) {
      throw Exception('failed to add user to users collection');
    }
  }
}
