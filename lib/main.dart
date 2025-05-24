import 'package:flutter/material.dart';
import 'package:todo_list/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/task_database.dart';
import 'package:todo_list/task_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(
    TaskModelAdapter(),
  );

  await Hive.openBox<TaskModel>('tasksBox');

  await TaskDatabase.instance.init();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
