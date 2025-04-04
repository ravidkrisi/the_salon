import 'package:the_salon/features/auth/domain/entities/user_entity.dart';

class Customer extends UserEntity {
  Customer({
    required super.id,
    required super.name,
    required super.email,
    required super.profileImageUrl,
  }) : super(type: UserType.customer);
}
