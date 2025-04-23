// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:the_salon/features/auth/domain/entities/barber.dart';

abstract class BarbersState {}

// init
class BarbersInit extends BarbersState {}

// loading
class BarbersLoading extends BarbersState {}

// loaded
class BarbersLoaded extends BarbersState {
  final List<Barber> barbers;
  BarbersLoaded({required this.barbers});
}

// errors
class BarbersErrors extends BarbersState {
  final String message;
  BarbersErrors({required this.message});
}
