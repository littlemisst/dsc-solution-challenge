import 'package:get_it/get_it.dart';
import 'package:me_daily/services/firebase_authentication_service.dart';
import 'package:me_daily/services/shared_preferences_service.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerSingleton(FirebaseAuthentication());
  locator.registerSingleton(SharedPreferencesService());
}
