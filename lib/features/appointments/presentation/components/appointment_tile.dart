import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:the_salon/core/extensions/buildcontext.dart';
import 'package:the_salon/core/extensions/date_time.dart';
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
          // return Container(
          //   height: 60,
          //   decoration: BoxDecoration(
          //     color: Colors.grey.shade300,
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       children: [
          //         // barber name
          //         Text(
          //           'Barber: ',
          //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          //         ),
          //         Text(barber.name, style: TextStyle(fontSize: 16)),

          //         Spacer(),

          //         // date
          //         Text(
          //           DateFormat('dd/MM/yyyy').format(appointment.date),
          //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //         ),
          //       ],
          //     ),
          //   ),
          // );
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // date section
                      Column(
                        children: [
                          // month
                          Text(
                            appointment.date.monthShort,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                          // day
                          Text(
                            appointment.date.day.toString(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(width: 12),

                      // divider
                      VerticalDivider(width: 5, color: Colors.grey),

                      SizedBox(width: 12),

                      // description section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // service type
                          Text(
                            'Service Type',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          SizedBox(height: 8),
                          // barber name
                          Text(barber.name, style: TextStyle(fontSize: 14)),
                        ],
                      ),

                      Spacer(),

                      // time section
                      Text(
                        appointment.time,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
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
