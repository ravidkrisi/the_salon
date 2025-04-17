import 'package:flutter/material.dart';
import 'package:the_salon/features/appointments/domain/entities/appointment.dart';

class AppointmentTile extends StatelessWidget {
  final Appointment appointment;
  const AppointmentTile({required this.appointment, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: double.infinity,

      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),

      child: Row(children: [

        ],
      ),
    );
  }
}
