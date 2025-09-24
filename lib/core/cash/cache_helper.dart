import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late final SharedPreferences sharedPreferences;
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    }
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }

    return await sharedPreferences.setDouble(key, value);
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  static Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }

  static Future<bool> containsKey({required String key}) async {
    return sharedPreferences.containsKey(key);
  }

  static Future<bool> setStringList({
    required String key,
    required List<String> value,
  }) async {
    return await sharedPreferences.setStringList(key, value);
  }
}
