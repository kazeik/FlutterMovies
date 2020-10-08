import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static SharedPreferences preferences;

  static Future<bool> getInstance() async {
    preferences = await SharedPreferences.getInstance();
    return true;
  }

  static Future<void> setString(key, value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }

  static Future<String> getString(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  static String getstaticString(key){
    return preferences.getString(key);
  }

  static Future<void> setBool(key, value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool(key, value);
  }

  static bool getBool(key, {bool defValue = false}) {
    if (preferences == null) return defValue;
    return preferences.getBool(key) ?? defValue;
  }

  static Future<String> remove(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(key);
  }

  static Future<String> clear(key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  /// get obj.
  static T getObj<T>(String key, T f(Map v), {T defValue}) {
    Map map = getObject(key);
    return map == null ? defValue : f(map);
  }
  /// get object.
  static Map getObject(String key) {
    if (preferences == null) return null;
    String _data = preferences.getString(key);
    return (_data == null || _data.isEmpty) ? null : json.decode(_data);
  }

  /// put object.
  static Future<bool> putObject(String key, Object value) {
    if (preferences == null) return null;
    return preferences.setString(key, value == null ? "" : json.encode(value));
  }
}
