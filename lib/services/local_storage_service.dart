import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _keyName = 'user_name';
  static String userName = 'Unknown';
  Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, name);
    log('name saved at local storage');
    userName = name;
  }

  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyName) ?? userName;
  }

  Future<void> clearUserName() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyName);
    userName = 'Unknown';
  }

  //! Today PnL data from Local storage
  static Future<void> saveTodayPnLData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    log('sssssssssssss');
    await prefs.setString('today_pnl', jsonEncode(data));
    final confirm = prefs.getString('today_pnl');
    log('🧪 Confirm saved value: ${prefs.getKeys()}');
    // log('ddddddddddddddd');
    log('Saving today PnL data: ${jsonEncode(data)}');
  }

  static Future<Map<String, dynamic>?> getTodayPnLData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('today_pnl'); // No need for `await` here

    if (jsonString != null) {
      log('✅ Today PnL data found in local storage.');
      try {
        return jsonDecode(jsonString) as Map<String, dynamic>;
      } catch (e) {
        log('❌ Failed to decode today_pnl JSON: $e');
        return null;
      }
    }

    log('⚠️ No today_pnl data found in local storage.');
    return null;
  }

  static Future<void> clearTodayPnLData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('today_pnl');
  }

  //!----------------------
  //! Yeserday PnL data from Local storage
  static Future<void> saveYesterdayPnLData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('yesterday_pnl', jsonEncode(data));
  }

  static Future<Map<String, dynamic>?> getYesterdayPnLData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('yesterday_pnl');
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }

  static Future<void> clearYesterdayPnLData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('yesterday_pnl');
  }

  //!----------------------
  //! Monthly PnL data from Local storage
  static Future<void> saveMonthlyPnLData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('monthly_pnl', jsonEncode(data));
  }

  static Future<Map<String, dynamic>?> getMonthlyPnLData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('monthly_pnl');
    if (jsonString != null) {
      return jsonDecode(jsonString);
    }
    return null;
  }

  static Future<void> clearMonthlyPnLData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('monthly_pnl');
  }

  //!----------------------
}
