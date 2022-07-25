import 'package:dartz/dartz.dart';
import 'package:todo_list/core/error/failure.dart';
import 'package:todo_list/feature/domain/entities/task_entities.dart';
import 'package:todo_list/feature/domain/repositories/task_repositories.dart';

class GetAllTasks {
  final TaskRepository taskRepository;

  GetAllTasks(this.taskRepository);
  Future<Either<Failure, List<TaskEntity>>> call() async {
    return await taskRepository.getAllTasks();
  }
}

class SaveTasks {
  final TaskRepository taskRepository;

  SaveTasks(this.taskRepository);
  Future<Either<Failure, TaskEntity>> call(TaskEntity taskEntity) async {
    return await taskRepository.saveTask(taskEntity);
  }
}

class RemoveTasks {
  final TaskRepository taskRepository;

  RemoveTasks(this.taskRepository);
  Future<Either<Failure, TaskEntity>> call(TaskEntity taskEntity) async {
    return await taskRepository.removeTask(taskEntity);
  }
}
