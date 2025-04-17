import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:the_salon/features/appointments/domain/entities/appointment.dart';
import 'package:the_salon/features/appointments/presentation/bloc/appointment_bloc.dart';
import 'package:the_salon/features/appointments/presentation/bloc/appointment_event.dart';
import 'package:the_salon/features/appointments/presentation/bloc/appointment_state.dart';
import 'package:the_salon/features/appointments/presentation/components/options_list.dart';
import 'package:the_salon/features/auth/domain/entities/user_entity.dart';
import 'package:uuid/uuid.dart';

class BookAppointmentPage extends StatelessWidget {
  final UserEntity currUser;
  const BookAppointmentPage({super.key, required this.currUser});

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);

    return Scaffold(
      appBar: AppBar(title: Text('Book Appointment')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      // select barber
                      barberSection(titleStyle, state, context),

                      // barber selected -> show dates
                      if (state.barberId != null)
                        if (state.isDateLoading)
                          Center(child: CircularProgressIndicator())
                        else
                          // date slots
                          dateSection(titleStyle, state, context),

                      if (state.date != null)
                        if (state.isTimeSlotsLoading)
                          Center(child: CircularProgressIndicator())
                        else
                          timeSection(titleStyle, state, context),

                      // book btn
                      if (state.time != null) bookButton(state, context),
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

  Column bookButton(AppointmentLoaded state, BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 25, width: double.infinity),
        ElevatedButton(
          onPressed: () {
            final date = state.date!; // DateTime: 2025-04-12 00:00:00.000
            final timeParts = state.time!.split(':'); // e.g. ["13", "00"]

            final combinedDateTime = DateTime(
              date.year,
              date.month,
              date.day,
              int.parse(timeParts[0]), // hour
              int.parse(timeParts[1]), // minute
            );
            final appointment = Appointment(
              id: Uuid().v4(),
              customerId: currUser.id,
              barberId: state.barberId!,
              date: combinedDateTime,
              time: state.time!,
              status: AppointmentStatus.booked,
            );
            context.read<AppointmentBloc>().add(
              AppointmentBookAppointment(appointment: appointment),
            );
          },
          child: Text('Book'),
        ),
      ],
    );
  }

  Column timeSection(
    TextStyle titleStyle,
    AppointmentLoaded state,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 25),
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
      ],
    );
  }

  Column dateSection(
    TextStyle titleStyle,
    AppointmentLoaded state,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 25),
        Text('Select Date', style: titleStyle),
        SizedBox(height: 10),
        OptionsList(
          options:
              state.upcomingDates
                  .map((date) => DateFormat('dd/MM').format(date))
                  .toList() +
              ['Other'],
          onTap: (selected) {
            if (selected == 'Other') {
              // Open calendar for custom date selection
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
              ).then((pickedDate) {
                if (pickedDate != null) {
                  context.read<AppointmentBloc>().add(
                    AppointmentDateSelected(date: pickedDate),
                  );
                }
              });
            } else {
              // Get the DateTime object for the selected date
              final selectedDate = state.upcomingDates.firstWhere(
                (date) => DateFormat('dd/MM').format(date) == selected,
              );
              context.read<AppointmentBloc>().add(
                AppointmentDateSelected(date: selectedDate),
              );
            }
          },
        ),
      ],
    );
  }

  Column barberSection(
    TextStyle titleStyle,
    AppointmentLoaded state,
    BuildContext context,
  ) {
    return Column(
      children: [
        Text('Select Barber', style: titleStyle),
        SizedBox(height: 10),
        OptionsList(
          options: state.barbers.map((barber) => barber.name).toList(),
          onTap: (selected) {
            final barber = state.barbers.firstWhere(
              (barber) => barber.name == selected,
            );
            context.read<AppointmentBloc>().add(
              AppointmentBarberSelected(barberId: barber.id),
            );
          },
        ),
      ],
    );
  }
}
