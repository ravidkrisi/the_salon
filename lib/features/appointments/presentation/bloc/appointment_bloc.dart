import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_salon/features/appointments/domain/repos/appointment_repo.dart';
import 'package:the_salon/features/appointments/presentation/bloc/appointment_event.dart';
import 'package:the_salon/features/appointments/presentation/bloc/appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentRepo repo;

  AppointmentBloc({required this.repo}) : super(AppointmentInit()) {
    // register handlers
    on<AppointmentBookAppointment>(_onBookAppointment);
    on<AppointmentBarberSelected>(_onBarberSelected);
    on<AppointmentTimeSelected>(_onTimeSelected);
    on<AppointmentGetAllBarbers>(_onGetAllBarbers);

    // get all barbers when init
    add(AppointmentGetAllBarbers());
  }

  Future<void> _onGetAllBarbers(
    AppointmentGetAllBarbers event,
    Emitter<AppointmentState> emit,
  ) async {
    try {
      emit(AppointmentLoading());

      final barbers = await repo.getAllBarbers();
      emit(AppointmentLoaded(barbers: barbers));
    } catch (e) {
      emit(AppointmentErrors(message: e.toString()));
    }
  }

  Future<void> _onBarberSelected(
    AppointmentBarberSelected event,
    Emitter<AppointmentState> emit,
  ) async {
    try {
      // show loading for time slots
      final currState = state;
      if (currState is AppointmentLoaded) {
        emit(
          AppointmentLoaded(
            barbers: currState.barbers,
            barberId: event.barberId,
            isTimeSlotsLoading: true,
          ),
        );

        // get available time slots
        final availableSlots = await repo.getAvailableSlotsByBarberId(
          event.barberId,
        );

        emit(
          AppointmentLoaded(
            barbers: currState.barbers,
            barberId: event.barberId,
            availableSlots: availableSlots,
          ),
        );
      }
    } catch (e) {
      emit(AppointmentErrors(message: e.toString()));
    }
  }

  Future<void> _onTimeSelected(
    AppointmentTimeSelected event,
    Emitter<AppointmentState> emit,
  ) async {
    final currState = state;
    if (currState is AppointmentLoaded) {
      emit(
        AppointmentLoaded(
          barbers: currState.barbers,
          availableSlots: currState.availableSlots,
          barberId: currState.barberId,
          time: event.time,
        ),
      );
    }
  }

  Future<void> _onBookAppointment(
    AppointmentBookAppointment event,
    Emitter<AppointmentState> emit,
  ) async {
    try {
      emit(AppointmentLoading());
      await repo.bookAppointment(event.appointment);
      emit(AppointmentInit());
      add(AppointmentGetAllBarbers());
    } catch (e) {
      emit(AppointmentErrors(message: e.toString()));
    }
  }
}
