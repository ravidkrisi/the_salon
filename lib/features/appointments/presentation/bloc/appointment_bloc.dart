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
    on<AppointmentDateSelected>(_onDateSelected);

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

  Future<void> _onDateSelected(
    AppointmentDateSelected event,
    Emitter<AppointmentState> emit,
  ) async {
    try {
      // show loading for time slots
      final currState = state;
      if (currState is AppointmentLoaded) {
        emit(
          AppointmentLoaded(
            barbers: currState.barbers,
            barberId: currState.barberId,
            date: event.date,
            upcomingDates: currState.upcomingDates,
            isTimeSlotsLoading: true,
          ),
        );

        // get available time slots
        final availableSlots = await repo.getAvailableSlotsByBarberId(
          currState.barberId!,
          event.date,
        );

        emit(
          AppointmentLoaded(
            barbers: currState.barbers,
            barberId: currState.barberId,
            date: event.date,
            upcomingDates: currState.upcomingDates,
            availableSlots: availableSlots,
          ),
        );
      }
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
            isDateLoading: true,
          ),
        );

        // get available time slots
        final upcomingDates = await repo.getUpcomingDates();

        emit(
          AppointmentLoaded(
            barbers: currState.barbers,
            barberId: event.barberId,
            upcomingDates: upcomingDates,
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
          upcomingDates: currState.upcomingDates,
          date: currState.date,
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
