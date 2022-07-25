part of 'task_bloc.dart';

abstract class TaskBlocEvent extends Equatable {}

class TaskSaveEvent extends TaskBlocEvent {
  final TaskEntity taskEntity;

  TaskSaveEvent(this.taskEntity);

  @override
  // TODO: implement props
  List<Object?> get props => [taskEntity];
}

class TaskUpdateEvent extends TaskBlocEvent {
  final TaskEntity taskEntity;

  TaskUpdateEvent(this.taskEntity);

  @override
  // TODO: implement props
  List<Object?> get props => [taskEntity];
}

class TaskRemoveEvent extends TaskBlocEvent {
  final TaskEntity taskEntity;

  TaskRemoveEvent(this.taskEntity);

  @override
  // TODO: implement props
  List<Object?> get props => [taskEntity];
}

class GetAllTasksEvent extends TaskBlocEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
