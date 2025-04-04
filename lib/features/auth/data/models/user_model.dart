import 'package:the_salon/features/auth/data/models/barber_model.dart';
import 'package:the_salon/features/auth/data/models/customer_model.dart';
import 'package:the_salon/features/auth/domain/entities/user_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String id;
  final String name;
  final String email;
  final String profileImageUrl;
  final UserType type;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImageUrl,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'profile_image_url': profileImageUrl,
      'type': type.toString(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    final UserType type =
        (map['type'] == UserType.barber.toString())
            ? UserType.barber
            : UserType.customer;

    // factory barber
    if (type == UserType.barber) {
      return BarberModel(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        profileImageUrl: map['profileimage_url'],
        testType: 'hey',
      );
    }
    // factory customer
    else {
      return CustomerModel(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        profileImageUrl: map['profile_image_url'],
      );
    }
  }
}
