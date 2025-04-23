// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:the_salon/features/auth/domain/entities/barber.dart';
import 'package:the_salon/features/auth/domain/entities/user_entity.dart';
import 'package:the_salon/features/barbers/data/datasources/barbers_remote_datasource.dart';
import 'package:the_salon/features/barbers/domain/repos/barbers_repo.dart';

class BarbersRepoImpl implements BarbersRepo {
  final BarbersRemoteDatasource barbersRemoteDatasource;
  BarbersRepoImpl({required this.barbersRemoteDatasource});
  @override
  Future<List<Barber>> getAllBarbers() async {
    final userModels = await barbersRemoteDatasource.fetchAllBarbers();

    final userEntites =
        userModels.map((model) => UserEntity.fromModel(model)).toList();

    return userEntites.cast<Barber>();
  }
}
