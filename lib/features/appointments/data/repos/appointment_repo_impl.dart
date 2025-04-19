// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_salon/features/appointments/data/datasources/appointment_remote_datasource.dart';
import 'package:the_salon/features/appointments/data/models/appointment_model.dart';
import 'package:the_salon/features/appointments/domain/entities/appointment.dart';
import 'package:the_salon/features/appointments/domain/repos/appointment_repo.dart';
import 'package:the_salon/features/auth/domain/entities/user_entity.dart';

class AppointmentRepoImpl implements AppointmentRepo {
  final AppointmentRemoteDatasource appointmentRemoteDatasource;
  AppointmentRepoImpl({required this.appointmentRemoteDatasource});
  @override
  Future<void> bookAppointment(Appointment appointment) async {
    // entity -> model
    final appointmentModel = AppointmentModel.fromEntity(appointment);

    // add appointment to firestore if available
    await appointmentRemoteDatasource.addApointmentToFirestore(
      appointmentModel,
    );
  }

  // @override
  // Future<List<String>> getAvailableSlotsByBarberId(
  //   String barberId,
  //   DateTime date,
  // ) async {
  //   // set dates range

  //   final normalizeStartDate = _normalizeDate(date);
  //   final normalizeEndDate = _normalizeDate(date.add(Duration(days: 1)));

  //   final startDate = Timestamp.fromDate(normalizeStartDate);
  //   final endDate = Timestamp.fromDate(normalizeEndDate);

  //   // get booked appointments
  //   final bookedAppointments = await appointmentRemoteDatasource
  //       .fetchBookedAppointments(barberId, startDate, endDate);

  //   // return available slots
  //   final bookedSlots =
  //       bookedAppointments.map((appointment) => appointment.time).toList();

  //   final allSlots = _generateAllSlots();
  //   print('booked slots: ${bookedSlots.toString()}');
  //   print('allslots slots: ${allSlots.toString()}');
  //   final availableSlots =
  //       allSlots.where((slot) => !bookedSlots.contains(slot)).toList();

  //   print('available slots: ${availableSlots.toString()}');

  //   return availableSlots;
  // }

  @override
  Future<List<String>> getAvailableSlotsByBarberId(
    String barberId,
    DateTime date,
  ) async {
    // Normalize date range
    final normalizeStartDate = _normalizeDate(date);
    final normalizeEndDate = _normalizeDate(date.add(Duration(days: 1)));

    final startDate = Timestamp.fromDate(normalizeStartDate);
    final endDate = Timestamp.fromDate(normalizeEndDate);

    // Fetch booked appointments
    final bookedAppointments = await appointmentRemoteDatasource
        .fetchBookedAppointments(barberId, startDate, endDate);

    final bookedSlots =
        bookedAppointments.map((appointment) => appointment.time).toList();

    // Generate all possible time slots
    final allSlots = _generateAllSlots();

    // ✅ Filter out past time slots if selected date is today
    List<String> filteredSlots = allSlots;

    final now = DateTime.now();
    final isToday = _isSameDate(now, date);

    if (isToday) {
      final currentTime = TimeOfDay.fromDateTime(now);

      filteredSlots =
          allSlots.where((slot) {
            final slotTime = _parseTimeOfDay(slot);
            return slotTime.hour > currentTime.hour ||
                (slotTime.hour == currentTime.hour &&
                    slotTime.minute > currentTime.minute);
          }).toList();
    }

    // Filter out booked slots
    final availableSlots =
        filteredSlots.where((slot) => !bookedSlots.contains(slot)).toList();

    print('booked slots: $bookedSlots');
    print('all slots: $allSlots');
    print('available slots: $availableSlots');

    return availableSlots;
  }

  List<String> _generateAllSlots() {
    final start = 9;
    final end = 17;
    return List.generate(
      end - start + 1,
      (i) => '${(start + i).toString().padLeft(2, '0')}:00',
    );
  }

  // Helper method to normalize DateTime to start of the day (00:00:00)
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day); // sets time to 00:00:00
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  TimeOfDay _parseTimeOfDay(String time) {
    final parts = time.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  @override
  Future<List<UserEntity>> getAllBarbers() async {
    final barbersModel = await appointmentRemoteDatasource.getAllBarbers();
    return barbersModel.map((model) => UserEntity.fromModel(model)).toList();
  }

  @override
  List<DateTime> getUpcomingDates() {
    List<DateTime> dates = [];
    DateTime today = DateTime.now();
    for (int i = 0; i < 5; i++) {
      DateTime date = today.add(Duration(days: i));
      dates.add(date); // Store DateTime object
    }
    return dates;
  }
}
