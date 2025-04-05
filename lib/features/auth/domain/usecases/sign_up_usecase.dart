// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:the_salon/features/auth/domain/entities/user_entity.dart';
import 'package:the_salon/features/auth/domain/repos/auth_repo.dart';

class SignUpUsecase {
  final AuthRepo authRepo;
  SignUpUsecase({required this.authRepo});

  Future<UserEntity?> call(UserEntity user) async {
    await authRepo.signUpCustomer(user);
    final result = authRepo.getCurrentUser();
    return result;
  }
}
