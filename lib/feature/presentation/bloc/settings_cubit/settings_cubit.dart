import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list/feature/domain/usecases/settings_usecase.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SaveTheme saveTheme;
  final GetTheme getTheme;
  SettingsCubit({required this.saveTheme, required this.getTheme})
      : super(SettingsEmpty());

  void changeTheme(bool isDarkTheme) async {
    final failureOrTheme = await saveTheme(isDarkTheme);
    failureOrTheme.fold((error) => ThemeChangedFailure(), (isDarkTheme) {
      emit(ThemeChanged(isDarkTheme: isDarkTheme));
    });
  }

  void loadTheme() async {
    final failureOrTheme = await getTheme();
    failureOrTheme.fold((error) => ThemeChangedFailure(), (isDarkTheme) {
      emit(ThemeRetrieved(isDarkTheme: isDarkTheme));
    });
  }
}
