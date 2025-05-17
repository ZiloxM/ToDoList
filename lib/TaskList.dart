import 'package:flutter/material.dart';
import 'package:todo_list/components/task.dart';
import 'package:todo_list/task_model.dart';

class TaskList extends StatelessWidget {
  final List<TaskModel> tasks;
  final Function(int) onDismissed;

  const TaskList({
    super.key,
    required this.tasks,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Text(
        'No tasks yet. Add some!',
        style: TextStyle(color: Colors.grey, fontSize: 16),
      );
    }

    return Column(
      children: tasks.asMap().entries.map((entry) {
        final index = entry.key;
        final task = entry.value;

        return Task(
          title: task.title,
          time: task.formattedTime(context),
          date: task.formattedDate,
          onDismissed: (dir) {
            onDismissed(index);
          },
        );
      }).toList(),
    );
  }
}
