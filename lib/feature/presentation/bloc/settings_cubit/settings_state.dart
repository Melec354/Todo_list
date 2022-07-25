part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsEmpty extends SettingsState {}

class ThemeChanged extends SettingsState {
  final bool isDarkTheme;
  const ThemeChanged({required this.isDarkTheme});
  @override
  List<Object> get props => [isDarkTheme];
}

class ThemeRetrieved extends SettingsState {
  final bool isDarkTheme;
  const ThemeRetrieved({required this.isDarkTheme});
  @override
  List<Object> get props => [isDarkTheme];
}

class ThemeChangedFailure extends SettingsState {}
