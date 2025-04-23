import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_salon/features/appointments/domain/entities/appointment.dart';
import 'package:the_salon/features/barbers/presentation/bloc/barbers_bloc.dart';
import 'package:the_salon/features/barbers/presentation/bloc/barbers_state.dart';

class AppointmentTile extends StatelessWidget {
  final Appointment appointment;
  const AppointmentTile({required this.appointment, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BarbersBloc, BarbersState>(
      builder: (context, state) {
        // loading
        if (state is BarbersLoading) {
          return Center(child: CircularProgressIndicator());
        }

        // loaded
        if (state is BarbersLoaded) {
          final barber = state.barbers.firstWhere(
            (barber) => barber.id == appointment.barberId,
          );
          return Container(child: Row(children: [Text(barber.name)]));
        }

        // default
        return Container();
      },
      listener: (context, state) {
        if (state is BarbersErrors) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
    );
  }
}
