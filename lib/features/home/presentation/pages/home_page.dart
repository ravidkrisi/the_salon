import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_salon/features/appointments/domain/entities/appointment.dart';
import 'package:the_salon/features/appointments/presentation/appointment_bloc.dart';
import 'package:the_salon/features/appointments/presentation/bloc/appointment_event.dart';
import 'package:the_salon/features/appointments/presentation/bloc/appointment_state.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:the_salon/features/auth/presentation/bloc/auth_event.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => context.read<AuthBloc>().add(AuthLogout()),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text('home'),
            ElevatedButton(
              onPressed: () {
                context.read<AppointmentBloc>().add(
                  AppointmentBookAppointment(
                    appointment: Appointment(
                      id: '1111',
                      customerId: '9999',
                      barberId: '00000',
                      date: DateTime.now(),
                      time: '09:00',
                      status: AppointmentStatus.booked,
                    ),
                  ),
                );
              },
              child: Text('Add Appointment'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<AppointmentBloc>().add(
                  AppointmentGetAvailableSlots(barberId: '00000'),
                );
              },
              child: Text('Add Appointment'),
            ),
            BlocConsumer<AppointmentBloc, AppointmentState>(
              builder: (context, state) {
                // loading
                if (state is AppointmentLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                // loaded
                if (state is AppointmentLoaded) {
                  return Text(state.availableSlots.toString());
                }
                // default
                return Container();
              },
              listener: (context, state) {
                if (state is AppointmentErrors) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
