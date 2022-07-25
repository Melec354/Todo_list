import 'package:todo_list/feature/domain/entities/task_entities.dart';

class TaskModel extends TaskEntity {
  TaskModel({required int id, required String name, required bool isDone})
      : super(name: name, isDone: isDone, id: id);

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        id: json['id'], name: json['name'], isDone: json['isDone']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isDone': isDone,
    };
  }
}
