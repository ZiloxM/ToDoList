import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  DateTime? date;

  @HiveField(2)
  String? time;

  @HiveField(3)
  String category;

  @HiveField(4)
  bool isChecked;

  TaskModel({
    required this.title,
    this.date,
    this.time,
    this.category = "General",
    this.isChecked = false,
  });

  String get formattedDate {
    if (date == null) return '';
    return '${date!.year}/${date!.month.toString().padLeft(2, '0')}/${date!.day.toString().padLeft(2, '0')}';
  }

  String formattedTime(BuildContext context) {
    return time ?? '';
  }
}
