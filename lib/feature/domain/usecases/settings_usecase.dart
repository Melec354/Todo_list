import 'package:dartz/dartz.dart';
import 'package:todo_list/feature/domain/repositories/settings_repositories.dart';

import '../../../core/error/failure.dart';

class GetTheme {
  final SettingsRepository settingsRepository;

  GetTheme(this.settingsRepository);
  Future<Either<Failure, bool>> call() async {
    return await settingsRepository.getTheme();
  }
}

class SaveTheme {
  final SettingsRepository settingsRepository;

  SaveTheme(this.settingsRepository);
  Future<Either<Failure, bool>> call(bool isDarkTheme) async {
    return await settingsRepository.saveTheme(isDarkTheme);
  }
}
