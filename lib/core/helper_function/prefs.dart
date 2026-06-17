import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
const String isFirstTimeKey = 'isFirstTime';
Future startSharedPref() async {
  // ignore: invalid_use_of_visible_for_testing_member
  SharedPreferences.resetStatic();
  sharedPreferences = await SharedPreferences.getInstance();
}

bool getIsFirstTime() {
  return sharedPreferences.getBool(isFirstTimeKey) ?? true;
}

Future<void> setIsFirstTime(bool value) async {
  await sharedPreferences.setBool(isFirstTimeKey, value);
}
