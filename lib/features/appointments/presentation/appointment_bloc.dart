import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_salon/features/appointments/domain/repos/appointment_repo.dart';
import 'package:the_salon/features/appointments/presentation/bloc/appointment_event.dart';
import 'package:the_salon/features/appointments/presentation/bloc/appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepo repo;

  AppointmentBloc({required this.repo}) : super(AppointmentInit()) {
    on<AppointmentBookAppointment>(_onBookAppointment);
    on<AppointmentGetAvailableSlots>(_onGetAvailableSlots);
  }

  Future<void> _onBookAppointment(
    AppointmentBookAppointment event,
    Emitter<AppointmentState> emit,
  ) async {
    try {
      await repo.bookAppointment(event.appointment);
    } catch (e) {
      emit(AppointmentErrors(message: e.toString()));
    }
  }

  Future<void> _onGetAvailableSlots(
    AppointmentGetAvailableSlots event,
    Emitter<AppointmentState> emit,
  ) async {
    try {
      emit(AppointmentLoading());

      final availableSlots = await repo.getAvailableSlotsByBarberId(
        event.barberId,
      );

      emit(AppointmentLoaded(availableSlots: availableSlots));
    } catch (e) {
      emit(AppointmentErrors(message: e.toString()));
    }
  }
}
