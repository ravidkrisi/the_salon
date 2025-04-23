import 'package:the_salon/features/auth/domain/entities/barber.dart';

abstract class BarbersRepo {
  // get barbers list
  Future<List<Barber>> getAllBarbers();
}
