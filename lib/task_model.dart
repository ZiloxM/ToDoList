import 'package:flutter/material.dart';

class TaskModel {
  final String title;
  final DateTime? date;
  final TimeOfDay? time;

  TaskModel({
    required this.title,
    this.date,
    this.time,
  });

  // Getter for formattedTime
  String formattedTime(BuildContext context) {
    if (time == null) return '';
    return time!.format(context); // Use BuildContext here to get formatted time
  }

  // Getter for formattedDate
  String get formattedDate {
    if (date == null) return '';
    return '${date!.year}/${date!.month.toString().padLeft(2, '0')}/${date!.day.toString().padLeft(2, '0')}';
  }
}
