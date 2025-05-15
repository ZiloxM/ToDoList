import 'package:flutter/material.dart';
import 'package:todo_list/category/category_view.dart';
import 'package:todo_list/components/Divider.dart';
import 'package:todo_list/components/cab.dart';
import 'package:todo_list/components/fab.dart';
import 'package:todo_list/list_view.dart';
import 'package:todo_list/task_model.dart';
import 'package:todo_list/task_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TaskModel> _taskList = [];

  void _addTask(TaskModel task) {
    setState(() {
      _taskList.add(task);
    });
  }

  Future<void> _showTaskSheet() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const TaskSheet(),
    );

    if (result != null && result['title'] != null && result['title'] != '') {
      final newTask = TaskModel(
        title: result['title'],
        date: result['date'],
        time: result['time'],
      );
      _addTask(newTask);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CAB(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CategoryView(),
          const CD(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TaskList(
                    tasks: _taskList,
                    onDismissed: (index) {
                      setState(() {
                        _taskList.removeAt(index);
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Task deleted'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FAB(
        onPressed: () async {
          final result = await showModalBottomSheet<Map<String, dynamic>>(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            builder: (context) => const TaskSheet(),
          );

          if (result != null &&
              result['title'] != null &&
              result['title'] != '') {
            final newTask = TaskModel(
              title: result['title'],
              date: result['date'],
              time: result['time'],
            );
            setState(() {
              _taskList.add(newTask);
            });
          }
        },
      ),
    );
  }
}
