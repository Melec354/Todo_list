import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/feature/presentation/bloc/settings_cubit/settings_cubit.dart';
import 'package:todo_list/feature/presentation/bloc/task_bloc/task_bloc.dart';
import 'common/app_theme.dart';
import 'feature/presentation/bloc/view_cubit/view_cubit.dart';
import 'feature/presentation/pages/HomePage.dart';
import 'locator_servies.dart' as di;
import 'locator_servies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>(create: (context) => sl<TaskBloc>()),
        BlocProvider<ViewCubit>(
            create: (context) => sl<ViewCubit>()..changeView(false)),
        BlocProvider<SettingsCubit>(
            create: (context) => sl<SettingsCubit>()..loadTheme()),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          bool isDarkTheme = false;
          if (state is ThemeChanged) {
            isDarkTheme = state.isDarkTheme;
          } else if (state is ThemeRetrieved) {
            isDarkTheme = state.isDarkTheme;
          }
          return MaterialApp(
            title: 'Flutter test task',
            theme: isDarkTheme ? AppTheme.dark() : AppTheme.light(),
            home: const MyHomePage(title: 'Task list'),
          );
        },
      ),
    );
  }
}
