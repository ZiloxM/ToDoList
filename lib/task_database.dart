import 'package:hive/hive.dart';
import 'task_model.dart';

class TaskDatabase {
  static const String boxName = 'tasksBox';

  late Box<TaskModel> _taskBox;

  TaskDatabase._privateConstructor();

  static final TaskDatabase instance = TaskDatabase._privateConstructor();

  Future<void> init() async {
    _taskBox = Hive.box<TaskModel>(boxName);
  }

  List<TaskModel> getTasks() {
    return _taskBox.values.toList();
  }

  Future<void> addTask(TaskModel task) async {
    await _taskBox.add(task);
  }

  Future<void> updateTask(int key, TaskModel task) async {
    await _taskBox.put(key, task);
  }

  Future<void> deleteTask(int key) async {
    await _taskBox.delete(key);
  }

  Future<void> clearAll() async {
    await _taskBox.clear();
  }
}
