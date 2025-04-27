import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _keyName = 'user_name';
  static String userName = 'Unknown';
  Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, name);
    userName = name;
  }

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyName);
  }

  Future<void> clearUserName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyName);
    userName = 'Unknown';
  }

  //! Today PnL Functions
  static Future<void> saveTodayPnLData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('today_pnl', jsonEncode(data));
  }

  static Future<Map<String, dynamic>?> getTodayPnLData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('today_pnl');
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }

  static Future<void> clearTodayPnLData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('today_pnl');
  }
}
