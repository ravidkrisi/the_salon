import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_salon/features/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:the_salon/features/appointments/presentation/bloc/appointment_event.dart';
import 'package:the_salon/features/appointments/presentation/bloc/appointment_state.dart';
import 'package:the_salon/features/appointments/presentation/components/options_list.dart';
import 'package:the_salon/features/auth/domain/entities/user_entity.dart';

class BookAppointmentPage extends StatelessWidget {
  final UserEntity currUser;
  const BookAppointmentPage({super.key, required this.currUser});

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
    final barbers = ['00000'];

    return Scaffold(
      appBar: AppBar(title: Text('Book Appointment')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // select barber
            Text('Select Barber', style: titleStyle),
            SizedBox(height: 10),
            OptionsList(
              options: barbers,
              onTap: (selected) {
                context.read<AppointmentBloc>().add(
                  AppointmentBarberSelected(barberId: selected),
                );
              },
            ),

            SizedBox(height: 25),

            // time slots
            BlocConsumer<AppointmentBloc, AppointmentState>(
              builder: (context, state) {
                // loading
                if (state is AppointmentLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                // loaded
                if (state is AppointmentLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Select Time', style: titleStyle),
                      SizedBox(height: 10),
                      OptionsList(
                        options: state.availableSlots,
                        onTap: (selected) {
                          context.read<AppointmentBloc>().add(
                            AppointmentTimeSelected(time: selected),
                          );
                        },
                      ),

                      // book btn
                      if (state.time != null)
                        Column(
                          children: [
                            SizedBox(height: 25, width: double.infinity),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Book'),
                            ),
                          ],
                        ),
                    ],
                  );
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
