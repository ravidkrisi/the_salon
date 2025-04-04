// import 'package:the_salon/features/auth/domain/entities/user_entity.dart';

// class UserModel extends UserEntity {
//   UserModel({required super.id, required super.name, required super.email, required super.profileImageUrl, required super.type});

//   factory UserEntity.fromMap(Map<String, dynamic> map) {
//     final UserType type =
//         (map['type'] == 'barber') ? UserType.barber : UserType.customer;

//     // factory barber
//     if (type == UserType.barber) {
//       return Barber(
//         id: map['id'],
//         name: map['name'],
//         email: map['email'],
//         profileImageUrl: map['profile_image_url'],
//         testType: 'hey',
//       );
//     }
//     // factory customer
//     else {
//       return Customer(
//         id: map['id'],
//         name: map['name'],
//         email: map['email'],
//         profileImageUrl: map['profile_image_url'],
//       );
//     }
//   }

//   String toJson() => json.encode(toMap());

//   factory UserEntity.fromJson(String source) =>
//       UserEntity.fromMap(json.decode(source) as Map<String, dynamic>);
// }
