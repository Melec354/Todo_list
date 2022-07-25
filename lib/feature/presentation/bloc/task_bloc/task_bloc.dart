import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/feature/domain/entities/task_entities.dart';
import 'package:todo_list/feature/domain/usecases/task_usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskBlocEvent, TaskBlocState> {
  final SaveTasks saveTasks;
  final RemoveTasks removeTasks;
  final GetAllTasks getAllTasks;

  List<TaskEntity> tasks = [];

  TaskBloc(
      {required this.getAllTasks,
      required this.saveTasks,
      required this.removeTasks})
      : super(TaskEmpty()) {
    on<TaskSaveEvent>(_onSaveEvent);
    on<TaskUpdateEvent>(_onUpdateEvent);
    on<TaskRemoveEvent>(_onRemoveEvent);
    on<GetAllTasksEvent>(_loadTasks);
  }

  FutureOr<void> _onSaveEvent(
      TaskSaveEvent event, Emitter<TaskBlocState> emit) async {
    final failorOrTask = await saveTasks(event.taskEntity);
    emit(failorOrTask.fold((failure) => TaskSavedError('Unexpected Error'),
        (task) {
      return TaskSaved(task);
    }));
  }

  FutureOr<void> _onUpdateEvent(
      TaskUpdateEvent event, Emitter<TaskBlocState> emit) async {
    final failorOrTask = await saveTasks(event.taskEntity);
    emit(failorOrTask.fold((failure) => TaskUpdateError('Unexpected Error'),
        (task) {
      return TaskUpdate(task);
    }));
  }

  FutureOr<void> _onRemoveEvent(
      TaskRemoveEvent event, Emitter<TaskBlocState> emit) async {
    final failorOrTask = await removeTasks(event.taskEntity);
    emit(failorOrTask.fold((failure) => TaskSavedError('Unexpected Error'),
        (task) {
      return TaskRemove(task);
    }));
  }

  FutureOr<void> _loadTasks(
      GetAllTasksEvent event, Emitter<TaskBlocState> emit) async {
    final failureOrTasks = await getAllTasks();
    failureOrTasks.fold((error) => TaskError(message: 'Unexpected Error'),
        (tasksList) {
      emit(TaskLoaded(taskList: tasksList));
    });
  }
}
