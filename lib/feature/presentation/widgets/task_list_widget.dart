import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/feature/domain/entities/task_entities.dart';

import '../bloc/task_bloc/task_bloc.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<AnimatedListState> animatedListKey =
        GlobalKey<AnimatedListState>();

    List<TaskEntity> tasks = [];

    BlocProvider.of<TaskBloc>(context).add(GetAllTasksEvent());

    return BlocBuilder<TaskBloc, TaskBlocState>(
      builder: (context, state) {
        if (state is TaskLoaded) {
          tasks = state.taskList;
          tasks.forEach((item) {
            animatedListKey.currentState?.insertItem(0);
          });
        }
        if (state is TaskSaved) {
          tasks.add(state.taskEntity);
          animatedListKey.currentState
              ?.insertItem(0, duration: const Duration(milliseconds: 500));
        }

        if (state is TaskRemove) {
          tasks.remove(state.taskEntity);
        }

        if (tasks.isNotEmpty) {
          tasks.sort((l, r) => (r.id.compareTo(l.id)));
        }

        return AnimatedList(
          key: animatedListKey,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          initialItemCount: tasks.isNotEmpty ? tasks.length - 1 : 0,
          itemBuilder: ((context, index, animation) {
            return SizeTransition(
              sizeFactor: animation,
              child: Dismissible(
                direction: DismissDirection.endToStart,
                key: UniqueKey(),
                onDismissed: (direction) {
                  BlocProvider.of<TaskBloc>(context)
                      .add(TaskRemoveEvent(tasks[index]));
                  animatedListKey.currentState?.removeItem(index,
                      (context, animation) {
                    return const SizedBox(width: 0, height: 0);
                  });
                },
                movementDuration: const Duration(seconds: 1),
                background: ColoredBox(
                  color: Colors.red,
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 15.0),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: GestureDetector(
                      onTap: () {
                        tasks[index].isDone = !tasks[index].isDone;
                        BlocProvider.of<TaskBloc>(context)
                            .add(TaskUpdateEvent(tasks[index]));
                      },
                      child: Row(
                        children: [
                          tasks[index].isDone
                              ? const Icon(
                                  Icons.check_box,
                                  color: Colors.grey,
                                  size: 24,
                                )
                              : const Icon(
                                  Icons.check_box_outline_blank,
                                  color: Colors.grey,
                                  size: 24,
                                ),
                          const SizedBox(width: 6),
                          Text(
                            tasks[index].name,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
