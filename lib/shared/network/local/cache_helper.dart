import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    String key,
    bool value,
  }) async {
    return await sharedPreferences.setBool(key, value);
  }

  static bool getData({
    String key,
  })  {
    return sharedPreferences.getBool(key);
  }

  static Future<bool> saveData ({
    String key,
    dynamic value,
  }) async {
    if(value is String){
      return await sharedPreferences.setString(key, value);
    } else if(value is int){
      return await sharedPreferences.setInt(key, value);
    } else if(value is bool){
      return await sharedPreferences.setBool(key, value);
    } else {
      return await sharedPreferences.setDouble(key, value);
    }
  }
}
