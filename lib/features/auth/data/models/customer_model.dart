import 'package:the_salon/features/auth/data/models/user_model.dart';
import 'package:the_salon/features/auth/domain/entities/user_entity.dart';

class CustomerModel extends UserModel {
  CustomerModel({
    required super.id,
    required super.name,
    required super.email,
    required super.profileImageUrl,
  }) : super(type: UserType.customer);
}
