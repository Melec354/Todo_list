import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/feature/domain/entities/task_entities.dart';
import 'package:todo_list/feature/presentation/bloc/task_bloc/task_bloc.dart';

import '../bloc/task_bloc/task_bloc.dart';
import '../bloc/view_cubit/view_cubit.dart';

class TaskField extends StatefulWidget {
  const TaskField({Key? key}) : super(key: key);

  @override
  State<TaskField> createState() => _TaskFieldState();
}

class _TaskFieldState extends State<TaskField> {
  final _controller = TextEditingController();
  bool _validate = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkValidate() {
    setState(() {
      _controller.text.trim().isEmpty ? _validate = false : _validate = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: _controller,
      decoration: InputDecoration(
        errorText: _validate ? null : 'Can\'t be Empty',
      ),
      onChanged: (value) {
        _checkValidate();
      },
      onSubmitted: (value) {
        _checkValidate();
        if (_validate) {
          BlocProvider.of<TaskBloc>(context).add(TaskSaveEvent(
              TaskEntity(id: 0, isDone: false, name: _controller.text.trim())));
          context.read<ViewCubit>().changeView(false);
        }
      },
    );
  }
}
