import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CachHelper {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
// save data
  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is int) {
      await sharedPreferences.setInt(key, value);
      return true;
    }
    if (value is String) {
      await sharedPreferences.setString(key, value);
      return true;
    }
    if (value is bool) {
      await sharedPreferences.setBool(key, value);
      return true;
    }
    if (value is double) {
      await sharedPreferences.setDouble(key, value);
      return true;
    }
    return false;
  }

// get data with ("key")
  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

// delete item
  static Future<bool> deleteItem({required String key})async {
    return await  sharedPreferences.remove(key);
  }

  static void clearData() {
    sharedPreferences.clear();
  }
}
