import 'package:the_salon/features/auth/data/models/barber_model.dart';
import 'package:the_salon/features/auth/data/models/user_model.dart';
import 'package:the_salon/features/auth/domain/entities/barber.dart';
import 'package:the_salon/features/auth/domain/entities/customer.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserEntity {
  final String id;
  final String name;
  final String email;
  final String profileImageUrl;
  final UserType type;
  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImageUrl,
    required this.type,
  });

  // json function
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'profile_image_url': profileImageUrl,
      'type': type.toString(),
    };
  }

  factory UserEntity.fromJson(Map<String, dynamic> map) {
    final UserType type =
        (map['type'] == UserType.barber.toString())
            ? UserType.barber
            : UserType.customer;

    // factory barber
    if (type == UserType.barber) {
      return Barber(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        profileImageUrl: map['profileimage_url'],
        testType: 'hey',
      );
    }
    // factory customer
    else {
      return Customer(
        id: map['id'],
        name: map['name'],
        email: map['email'],
        profileImageUrl: map['profile_image_url'],
      );
    }
  }

  // factory of barber / customer
  factory UserEntity.create(
    String id,
    String name,
    String email,
    String profileImageUrl,
    UserType type,
  ) {
    // barber
    if (type == UserType.barber) {
      return Barber(
        id: id,
        name: name,
        email: email,
        profileImageUrl: profileImageUrl,
        testType: 'test',
      );
    }

    // customer
    return Customer(
      id: id,
      name: name,
      email: email,
      profileImageUrl: profileImageUrl,
    );
  }

  // factory of model
  factory UserEntity.fromModel(UserModel model) {
    // barber
    if (model is BarberModel) {
      return Barber(
        id: model.id,
        name: model.name,
        email: model.email,
        profileImageUrl: model.profileImageUrl,
        testType: model.testType,
      );
    }

    // customer
    return Customer(
      id: model.id,
      name: model.name,
      email: model.email,
      profileImageUrl: model.profileImageUrl,
    );
  }
}

enum UserType { customer, barber }
