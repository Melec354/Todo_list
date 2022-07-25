import 'package:todo_list/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_list/feature/data/datasources/settings_local_datasource.dart';
import 'package:todo_list/feature/domain/repositories/settings_repositories.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingLocalDataSources settingLocalDataSources;

  SettingsRepositoryImpl({required this.settingLocalDataSources});

  @override
  Future<Either<Failure, bool>> getTheme() async {
    try {
      final isDarkTheme = await settingLocalDataSources.takeTheme();
      return Right(isDarkTheme);
    } on Exception {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveTheme(bool isDarkTheme) async {
    try {
      final isDarkThemeRight =
          await settingLocalDataSources.saveTheme(isDarkTheme);
      return Right(isDarkThemeRight);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
