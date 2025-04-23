import 'package:flutter/material.dart';
import 'package:the_salon/features/appointments/domain/entities/appointment.dart';
import 'package:the_salon/features/appointments/presentation/components/appointment_tile.dart';

class AppointmentsList extends StatelessWidget {
  final List<Appointment> appointments;
  const AppointmentsList({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AppointmentTile(appointment: appointments[index]),
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 5),
        itemCount: appointments.length,
      ),
    );
  }
}
