import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final SharedPreferences _preferences;

  LocalStorageService({required SharedPreferences preferences}) : _preferences = preferences;

  Future<bool> saveData(String key, dynamic value) async {
    if (value is int) return await _preferences.setInt(key, value);
    if (value is double) return await _preferences.setDouble(key, value);
    if (value is bool) return await _preferences.setBool(key, value);
    if (value is String) return await _preferences.setString(key, value);
    if (value is List<String>) {
      return await _preferences.setStringList(key, value);
    }
    return await _preferences.setString(key, jsonEncode(value));
  }

  dynamic getData(String key) {
    var value = _preferences.get(key);
    if (value is String) {
      try {
        return jsonDecode(value);
      } catch (e) {
        return value;
      }
    }
    return value;
  }

  Future<bool> removeData(String key) async {
    return await _preferences.remove(key);
  }

  Future<bool> clearAll() async {
    return await _preferences.clear();
  }
}
