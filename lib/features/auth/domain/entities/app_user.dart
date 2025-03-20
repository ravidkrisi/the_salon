import 'package:firebase_auth/firebase_auth.dart';

class AppUser {
  final String uid;
  final String email;
  final String name;
  AppUser({required this.uid, required this.email, required this.name});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'uid': uid, 'email': email, 'name': name};
  }

  factory AppUser.fromJson(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
    );
  }

  factory AppUser.fromUser(User user) {
    return AppUser(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
    );
  }
}
