import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:the_salon/core/extensions/buildcontext.dart';
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
          return Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // barber name
                  Text(
                    'Barber: ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(barber.name, style: TextStyle(fontSize: 16)),

                  Spacer(),

                  // date
                  Text(
                    DateFormat('dd/MM/yyyy').format(appointment.date),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
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
