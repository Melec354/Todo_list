import 'package:get_it/get_it.dart';
import 'package:todo_list/feature/data/datasources/settings_local_datasource.dart';
import 'package:todo_list/feature/data/repositories/settings_repositories_impl.dart';
import 'package:todo_list/feature/domain/repositories/settings_repositories.dart';
import 'package:todo_list/feature/domain/repositories/task_repositories.dart';
import 'package:todo_list/feature/domain/usecases/task_usecase.dart';
import 'package:todo_list/feature/presentation/bloc/settings_cubit/settings_cubit.dart';

import 'feature/data/datasources/task_local_datasource.dart';
import 'feature/data/repositories/task_repository_impl.dart';
import 'feature/domain/usecases/settings_usecase.dart';
import 'feature/presentation/bloc/task_bloc/task_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'feature/presentation/bloc/view_cubit/view_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC / Cubit
  sl.registerFactory(
      () => TaskBloc(saveTasks: sl(), removeTasks: sl(), getAllTasks: sl()));
  sl.registerFactory(() => ViewCubit());
  sl.registerFactory(() => SettingsCubit(saveTheme: sl(), getTheme: sl()));
  // UseCases
  sl.registerLazySingleton(() => GetAllTasks(sl()));
  sl.registerLazySingleton(() => SaveTasks(sl()));
  sl.registerLazySingleton(() => RemoveTasks(sl()));

  sl.registerLazySingleton(() => GetTheme(sl()));
  sl.registerLazySingleton(() => SaveTheme(sl()));

  // Repository
  sl.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(
      taskLocalDataSources: sl(),
    ),
  );

  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(
      settingLocalDataSources: sl(),
    ),
  );

  sl.registerLazySingleton<TaskLocalDataSources>(
    () => TaskLocalDataSourcesImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<SettingLocalDataSources>(
    () => SettingLocalDataSourcesImpl(sharedPreferences: sl()),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
