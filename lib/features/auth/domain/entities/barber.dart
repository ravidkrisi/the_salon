import 'package:the_salon/features/auth/domain/entities/user_entity.dart';

class Barber extends UserEntity {
  final String testType;

  Barber({
    required super.id,
    required super.name,
    required super.email,
    required super.profileImageUrl,
    required this.testType,
  }) : super(type: UserType.barber);
}
