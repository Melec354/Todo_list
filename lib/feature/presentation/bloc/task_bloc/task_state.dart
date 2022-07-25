part of 'task_bloc.dart';

abstract class TaskBlocState {}

class TaskEmpty extends TaskBlocState {}

class TaskSaved extends TaskBlocState {
  final TaskEntity taskEntity;

  TaskSaved(this.taskEntity);
  @override
  // TODO: implement props
  List<Object?> get props => [taskEntity];
}

class TaskSavedError extends TaskBlocState {
  final String message;

  TaskSavedError(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class TaskUpdate extends TaskBlocState {
  final TaskEntity taskEntity;

  TaskUpdate(this.taskEntity);
  @override
  // TODO: implement props
  List<Object?> get props => [taskEntity];
}

class TaskUpdateError extends TaskBlocState {
  final String message;

  TaskUpdateError(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class TaskRemove extends TaskBlocState {
  final TaskEntity taskEntity;

  TaskRemove(this.taskEntity);
  @override
  // TODO: implement props
  List<Object?> get props => [taskEntity];
}

class TaskRemoveError extends TaskBlocState {
  final String message;

  TaskRemoveError(this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class TaskListEmpty extends TaskBlocState {}

class TaskLoaded extends TaskBlocState {
  final List<TaskEntity> taskList;

  TaskLoaded({required this.taskList});
}

class TaskError extends TaskBlocState {
  final String message;

  TaskError({required this.message});
}
