import 'package:dartz/dartz.dart';
import 'package:todo_list/core/error/failure.dart';

abstract class SettingsRepository {
  Future<Either<Failure, bool>> saveTheme(bool isDarkTheme);
  Future<Either<Failure, bool>> getTheme();
}
