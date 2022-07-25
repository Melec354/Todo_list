import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/const.dart';

abstract class SettingLocalDataSources {
  Future<bool> takeTheme();
  Future<bool> saveTheme(bool isDarkTheme);
}

const List<String> cachedList = [themeCached, counterCached];

class SettingLocalDataSourcesImpl implements SettingLocalDataSources {
  final SharedPreferences sharedPreferences;

  SettingLocalDataSourcesImpl({required this.sharedPreferences});

  @override
  Future<bool> saveTheme(bool isDarkTheme) {
    sharedPreferences.setBool(themeCached, isDarkTheme);
    return Future.value(isDarkTheme);
  }

  @override
  Future<bool> takeTheme() {
    var isDarkTheme = sharedPreferences.getBool(themeCached);
    if (isDarkTheme == null) {
      sharedPreferences.setBool(themeCached, false);
      isDarkTheme = false;
    }
    return Future.value(isDarkTheme);
  }
}
