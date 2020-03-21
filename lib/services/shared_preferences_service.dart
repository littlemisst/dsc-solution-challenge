import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {

  static Future<bool> getIsNewlyInstalled() async {
    final _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.getBool('isNewlyInstalled') ?? true;
  }

  static Future<bool> setIsNewlyInstalled(bool isNewlyInstalled) async {
    
    final _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences.setBool('isNewlyInstalled', isNewlyInstalled);
  }
}
