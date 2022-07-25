import 'package:flutter/material.dart';
import 'package:todo_list/feature/presentation/widgets/neumorphism_button.dart';

class TaskCreateContainer extends StatefulWidget {
  const TaskCreateContainer({Key? key}) : super(key: key);

  @override
  State<TaskCreateContainer> createState() => _TaskCreateContainerState();
}

class _TaskCreateContainerState extends State<TaskCreateContainer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'My Tasks',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        ),
        NeumorphismButton()
      ],
    );
  }
}
