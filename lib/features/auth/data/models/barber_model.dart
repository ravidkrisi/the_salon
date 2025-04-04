import 'package:the_salon/features/auth/data/models/user_model.dart';
import 'package:the_salon/features/auth/domain/entities/user_entity.dart';

class BarberModel extends UserModel {
  final String testType;

  BarberModel({
    required super.id,
    required super.name,
    required super.email,
    required super.profileImageUrl,
    required this.testType,
  }) : super(type: UserType.barber);
}
