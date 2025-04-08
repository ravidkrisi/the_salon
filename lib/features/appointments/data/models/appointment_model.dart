// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_salon/features/appointments/domain/entities/appointment.dart';

class AppointmentModel {
  final String id;
  final String customerId;
  final String barberId;
  final Timestamp date;
  final String time;
  final String status;
  AppointmentModel({
    required this.id,
    required this.customerId,
    required this.barberId,
    required this.date,
    required this.time,
    required this.status,
  });

  // entity factory
  factory AppointmentModel.fromEntity(Appointment appointment) {
    return AppointmentModel(
      id: appointment.id,
      customerId: appointment.customerId,
      barberId: appointment.barberId,
      date: Timestamp.fromDate(appointment.date),
      time: appointment.time,
      status: appointment.status.name,
    );
  }

  // json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'barber_id': barberId,
      'date': date,
      'time': time,
      'status': status,
    };
  }

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      customerId: json['customer_id'],
      barberId: json['barber_id'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
    );
  }
}
