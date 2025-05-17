import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/components/calendar.dart';
import 'package:todo_list/components/time.dart';
import 'package:todo_list/task_model.dart';

class TaskSheet extends StatefulWidget {
  const TaskSheet({super.key});

  @override
  State<TaskSheet> createState() => _TaskSheetState();
}

class _TaskSheetState extends State<TaskSheet> {
  final taskController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

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
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final pickedDate = await showDialog<DateTime>(
                        context: context,
                        builder: (context) => const Calendar(),
                      );
                      if (pickedDate != null) {
                        setState(
                          () {
                            selectedDate = pickedDate;
                          },
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xfff5f5f5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.deepOrange,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            selectedDate != null
                                ? DateFormat('yyyy/MM/dd').format(selectedDate!)
                                : "Pick date",
                            style: const TextStyle(
                              color: Color(0xff555555),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: _pickTime,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xfff5f5f5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: Colors.deepOrange,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            selectedTime != null
                                ? selectedTime!.format(context)
                                : "Pick time",
                            style: const TextStyle(
                              color: Color(0xff555555),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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

                if (selectedDate == null && selectedTime == null) {
                  errors.add("Please select both date and time.");
                } else if (selectedDate == null) {
                  errors.add("Please select a date.");
                } else if (selectedTime == null) {
                  errors.add("Please select a time.");
                }

                if (errors.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(errors.join('\n')),
                      backgroundColor: Colors.deepOrange,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                  return;
                }

                Navigator.pop(
                  context,
                  {
                    'title': taskController.text,
                    'date': selectedDate,
                    'time': selectedTime,
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
