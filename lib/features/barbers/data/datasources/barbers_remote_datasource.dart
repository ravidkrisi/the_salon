// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:the_salon/core/services/firestore_barbers_service.dart';
import 'package:the_salon/features/auth/data/models/user_model.dart';

abstract class BarbersRemoteDatasource {
  // fetch all barbers
  Future<List<UserModel>> fetchAllBarbers();
}

class BarbersRemoteDatasourceImpl implements BarbersRemoteDatasource {
  final FirestoreBarbersService barbersService;
  BarbersRemoteDatasourceImpl({required this.barbersService});
  @override
  Future<List<UserModel>> fetchAllBarbers() async {
    return await barbersService.fetchAllBarbers();
  }
}
