import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<bool> getIsNewlyInstalled() async {
    final _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getBool('isNewlyInstalled') ?? true;
  }

  Future<bool> setIsNewlyInstalled(bool isNewlyInstalled) async {
    final _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.setBool('isNewlyInstalled', isNewlyInstalled);
  }
}
