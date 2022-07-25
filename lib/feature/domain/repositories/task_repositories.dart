import 'package:dartz/dartz.dart';
import 'package:todo_list/core/error/failure.dart';
import 'package:todo_list/feature/domain/entities/task_entities.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<TaskEntity>>> getAllTasks();
  Future<Either<Failure, TaskEntity>> saveTask(TaskEntity taskEntity);
  Future<Either<Failure, TaskEntity>> removeTask(TaskEntity taskEntity);
}
