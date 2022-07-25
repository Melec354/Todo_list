import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  int id;
  String name;
  bool isDone;

  TaskEntity({required this.name, required this.isDone, required this.id});

  @override
  List<Object?> get props => [id];
}
