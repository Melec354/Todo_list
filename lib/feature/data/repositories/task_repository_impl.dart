import 'package:todo_list/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_list/feature/data/datasources/task_local_datasource.dart';
import 'package:todo_list/feature/data/models/task_model.dart';
import 'package:todo_list/feature/domain/entities/task_entities.dart';
import 'package:todo_list/feature/domain/repositories/task_repositories.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSources taskLocalDataSources;

  TaskRepositoryImpl({required this.taskLocalDataSources});

  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTasks() async {
    try {
      final listTasks = await taskLocalDataSources.getAllTasks();
      return Right(listTasks);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> removeTask(TaskEntity taskEntity) async {
    try {
      await taskLocalDataSources.removeTask(taskEntity.id);
      return Right(TaskModel(
          id: taskEntity.id, name: taskEntity.name, isDone: taskEntity.isDone));
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> saveTask(TaskEntity taskEntity) async {
    bool newTask = false;
    try {
      if (taskEntity.id == 0) {
        newTask = true;
        try {
          taskEntity.id = await taskLocalDataSources.getCountTask() + 1;
        } on Exception {
          return Left(ServerFailure());
        }
      }
      TaskModel taskModel = TaskModel(
          id: taskEntity.id, name: taskEntity.name, isDone: taskEntity.isDone);

      await taskLocalDataSources.saveTask(taskModel);
      if (newTask) {
        await taskLocalDataSources.saveCountTask(taskEntity.id);
      }

      return Right(taskModel);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
