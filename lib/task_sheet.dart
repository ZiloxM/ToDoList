import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/components/calendar.dart';
import 'package:todo_list/components/time.dart';

///Task Sheet
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
        top: Radius.circular(16),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          top: 40,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Add new task",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: taskController,
              decoration: const InputDecoration(
                hintText: "Enter your task",
                filled: true,
                fillColor: Color(0xffeeeeee),
                enabledBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading:
                  const Icon(Icons.calendar_today, color: Colors.deepOrange),
              title: Text(selectedDate != null
                  ? DateFormat('yyyy/MM/dd').format(selectedDate!)
                  : "Set date"),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor: const Color(0xffeeeeee),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(
                Icons.access_time,
                color: Colors.deepOrange,
              ),
              title: Text(selectedTime != null
                  ? selectedTime!.format(context)
                  : "Set time"),
              onTap: _pickTime,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor: const Color(0xffeeeeee),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
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
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    /*
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const TextField(
            decoration: InputDecoration(labelText: 'Task Title'),
          ),
          const TextField(
            decoration: InputDecoration(labelText: 'Date'),
          ),
          const TextField(
            decoration: InputDecoration(labelText: 'Time'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, {
                'title': 'New Task',
                'date': DateTime.now(),
                'time': TimeOfDay.now(),
              });
            },
            child: const Text('Add Task'),
          ),
        ],
      ),
    );
  */
  }
}
