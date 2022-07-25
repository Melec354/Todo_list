import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/feature/presentation/bloc/settings_cubit/settings_cubit.dart';
import 'package:todo_list/feature/presentation/widgets/task_create_container.dart';

import '../bloc/view_cubit/view_cubit.dart';
import '../widgets/task_field_widget.dart';
import '../widgets/task_list_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        bool isDarkTheme = false;
        if (state is ThemeChanged) {
          isDarkTheme = state.isDarkTheme;
        } else if (state is ThemeRetrieved) {
          isDarkTheme = state.isDarkTheme;
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            actions: [
              IconButton(
                  onPressed: () {
                    context.read<SettingsCubit>().changeTheme(!isDarkTheme);
                  },
                  icon: isDarkTheme
                      ? const Icon(Icons.dark_mode, color: Colors.white)
                      : const Icon(
                          Icons.light_mode,
                          color: Colors.black,
                        ))
            ],
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const TaskCreateContainer(),
                const Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 15),
                  child: SizedBox(
                    height: 1,
                    width: double.infinity,
                    child: ColoredBox(color: Colors.black12),
                  ),
                ),
                context.watch<ViewCubit>().state
                    ? const TaskField()
                    : const SizedBox(
                        height: 35,
                        width: double.infinity,
                      ),
                const Expanded(child: TaskList()),
              ],
            ),
          ),
        );
      },
    );
  }
}
