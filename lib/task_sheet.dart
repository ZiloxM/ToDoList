import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/category/category_sheet.dart';
import 'package:todo_list/components/calendar.dart';
import 'package:todo_list/components/time.dart';
import 'package:another_flushbar/flushbar.dart';

class TaskSheet extends StatefulWidget {
  const TaskSheet({super.key});

  @override
  State<TaskSheet> createState() => _TaskSheetState();
}

class _TaskSheetState extends State<TaskSheet> {
  final taskController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final List<String> categories = [
    'Work',
    'Study',
    'Personal',
    'Shopping',
    'Other'
  ];
  String? selectedCategory;

  Future<void> _pickTime() async {
    final picked = await showCustomCupertinoTimePicker(
      context,
      selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(
        () {
          selectedTime = picked;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(24),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          20,
          30,
          20,
          MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Add New Task",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff333333),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                hintText: "What do you need to do?",
                filled: true,
                fillColor: const Color(0xfff5f5f5),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(
                  Icons.edit,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// Date & Time pickers
            Row(
              children: [
                // Date
                Expanded(
                  child: TextField(
                    readOnly: true,
                    onTap: () async {
                      final pickedDate = await showDialog<DateTime>(
                        context: context,
                        builder: (context) => const Calendar(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    enabled: true,
                    decoration: InputDecoration(
                      hintText: "Pick date",
                      filled: true,
                      fillColor: const Color(0xfff5f5f5),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(
                        Icons.calendar_today,
                        color: Colors.deepOrange,
                      ),
                    ),
                    controller: TextEditingController(
                      text: selectedDate != null
                          ? DateFormat('yyyy/MM/dd').format(selectedDate!)
                          : '',
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // Time
                Expanded(
                  child: TextField(
                    readOnly: true,
                    onTap: _pickTime,
                    enabled: true,
                    decoration: InputDecoration(
                      hintText: "Pick time",
                      filled: true,
                      fillColor: const Color(0xfff5f5f5),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(
                        Icons.access_time,
                        color: Colors.deepOrange,
                      ),
                    ),
                    controller: TextEditingController(
                      text: selectedTime != null
                          ? selectedTime!.format(context)
                          : '',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            /// Category
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Select category',
                      filled: true,
                      fillColor: const Color(0xfff5f5f5),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(
                        Icons.category,
                        color: Colors.deepOrange,
                      ),
                    ),
                    onTap: () async {
                      final selected = await showDialog<String>(
                        context: context,
                        builder: (_) => const CategorySheet(),
                      );

                      if (selected != null) {
                        setState(
                          () {
                            selectedCategory = selected;
                          },
                        );
                      }
                    },
                  ),
                ),

                const SizedBox(width: 12),

                /// Alarm
                Expanded(
                  flex: 3,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Alarm",
                      filled: true,
                      fillColor: const Color(0xfff5f5f5),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(
                        Icons.alarm_add_outlined,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),

            /// Confirm button
            ElevatedButton(
              onPressed: () {
                List<String> errors = [];

                if (taskController.text.isEmpty) {
                  errors.add("Please enter a task title.");
                }
                if (selectedDate == null &&
                    selectedTime == null &&
                    selectedCategory == null) {
                  errors.add("Please complete all fields.");
                } else if (selectedDate == null && selectedTime == null) {
                  errors.add("Please select both date and time.");
                } else if (selectedDate == null && selectedCategory == null) {
                  errors.add("Please select both date and category.");
                } else if (selectedTime == null && selectedCategory == null) {
                  errors.add("Please select both time and category.");
                } else if (selectedDate == null) {
                  errors.add("Please select a date.");
                } else if (selectedTime == null) {
                  errors.add("Please select a time.");
                } else if (selectedCategory == null) {
                  errors.add("Please select a category.");
                }

                if (errors.isNotEmpty) {
                  Flushbar(
                    message: errors.join('\n'),
                    backgroundColor: Colors.deepOrange,
                    messageColor: Colors.white,
                    icon: const Icon(
                      Icons.error_outline,
                      color: Colors.white,
                    ),
                    duration: const Duration(seconds: 4),
                    flushbarPosition: FlushbarPosition.TOP,
                    borderRadius: BorderRadius.circular(12),
                    margin: const EdgeInsets.all(10),
                    animationDuration: const Duration(milliseconds: 500),
                  ).show(context);
                  return;
                }

                Navigator.pop(
                  context,
                  {
                    'title': taskController.text,
                    'date': selectedDate,
                    'time': selectedTime,
                    'category': selectedCategory,
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xfff7892b),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                "Add Task",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
