import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  static SharedPreferences? sharedPreferences;

  static Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean(
      {required String key, required bool val}) async {
    return await sharedPreferences!.setBool(key, val);
  }

  static bool? getBoolean({required key}) {
    return sharedPreferences!.getBool(key);
  }
}