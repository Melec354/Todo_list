import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/feature/data/models/task_model.dart';
import 'dart:convert';

import '../../../const.dart';

abstract class TaskLocalDataSources {
  Future<List<TaskModel>> getAllTasks();
  Future<void> addTask(TaskModel taskModel);
  Future<void> saveTask(TaskModel taskModel);
  Future<int> getCountTask();
  Future<void> saveCountTask(int count);
  Future<void> removeTask(int count);
}

class TaskLocalDataSourcesImpl implements TaskLocalDataSources {
  final SharedPreferences sharedPreferences;

  TaskLocalDataSourcesImpl({required this.sharedPreferences});

  @override
  Future<List<TaskModel>> getAllTasks() {
    List<TaskModel> taskList = [];
    final allKeys = sharedPreferences.getKeys().where((String key) =>
        !cachedList.any((listElement) => listElement.contains(key)));
    if (allKeys.isNotEmpty) {
      for (String key in allKeys) {
        final jsonTask = sharedPreferences.getString(key);

        if (jsonTask!.isNotEmpty) {
          try {
            taskList.add(TaskModel.fromJson(json.decode(jsonTask)));
            // ignore: empty_catches
          } catch (e) {}
        } else {
          //throw Exception();
        }
      }
    }
    return Future.value(taskList);
  }

  @override
  Future<void> addTask(TaskModel taskModel) {
    final String jsonTaskModel = json.encode(taskModel.toJson());

    sharedPreferences.setString(taskModel.id.toString(), jsonTaskModel);
    //print();
    // ignore: void_checks
    return Future.value(jsonTaskModel);
  }

  @override
  Future<void> saveTask(TaskModel taskModel) {
    final String jsonTaskModel = json.encode(taskModel.toJson());
    sharedPreferences.setString(taskModel.id.toString(), jsonTaskModel);
    //print();
    // ignore: void_checks
    return Future.value(jsonTaskModel);
  }

  @override
  Future<int> getCountTask() {
    final taskCounter = sharedPreferences.getInt(counterCached) ?? 0;
    if (taskCounter == 0) {
      return Future.value(1);
    }
    return Future.value(taskCounter);
  }

  @override
  Future<void> saveCountTask(int count) {
    sharedPreferences.setInt(counterCached, count);
    return Future.value();
  }

  @override
  Future<void> removeTask(int count) {
    sharedPreferences.remove(count.toString());
    return Future.value();
  }
}
