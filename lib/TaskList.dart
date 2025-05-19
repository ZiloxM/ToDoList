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
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.task_alt_outlined, size: 40, color: Colors.grey),
            SizedBox(height: 10),
            Text(
              'No tasks yet. Add some!',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Task(
          key: ValueKey(
            task.title + task.formattedDate + task.formattedTime(context),
          ),
          title: task.title,
          time: task.formattedTime(context),
          date: task.formattedDate,
          isChecked: task.isChecked,
          onDismissed: (dir) {
            onDismissed(index);
          },
        );
      },
    );
  }
}
