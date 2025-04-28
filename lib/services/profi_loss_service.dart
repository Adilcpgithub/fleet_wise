import 'dart:convert';
import 'dart:developer';
import 'package:fleet_wise/services/auth_service.dart';
import 'package:fleet_wise/services/token_service.dart';
import 'package:http/http.dart' as http;
import 'package:fleet_wise/services/secure_storage_service.dart'; // Assuming you have this

class ProfitLossService {
  final String rootUrl =
      'https://avaronn-backend-development-server.pemy8f8ay9m4p.ap-south-1.cs.amazonlightsail.com/test'; // 🔥 Replace with your real root_url
  final SecureStorageService secureStorageService = SecureStorageService();
  final authService = AuthService.instance;
  final tokenService = TokenService.instance;
  // ! Today Pnl ---------------------
  Future<Map<String, dynamic>> getTodayPnL() async {
    final accessToken = await secureStorageService.getAccessToken();
    try {
      var response = await http.get(
        Uri.parse('$rootUrl/getTodayPorterPnL'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      // ! Handle Token Expiry (401)
      if (response.statusCode == 401) {
        final success = await tokenService.refreshAccessToken();

        if (success) {
          final newAccessToken = await secureStorageService.getAccessToken();
          response = await http.get(
            Uri.parse('$rootUrl/getTodayPorterPnL'),
            headers: {
              'Authorization': 'Bearer $newAccessToken',
              'Content-Type': 'application/json',
            },
          );
        } else {
          throw Exception('Session expired. Please log in again.');
        }
      }

      // ! Handle Success Response (200)
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        log('p and l fetching success ');
        if (decoded['data'] != null) {
          log(decoded['data'].toString());
          return decoded['data'] as Map<String, dynamic>;
        } else {
          log('Invalid response format: data missing.');
          return {};
        }
      } else {
        // ! Handle Other Error Responses
        log('Failed to fetch Today PnL. Status Code: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      log('Error while fetching Today PnL: $e');
      return {}; // ! Always return safe empty map on any crash
    }
  }

  //  !----------------------------------------
  // ! Yesterday Pnl --------------------------
  Future<Map<String, dynamic>> getYesterdayPnL() async {
    final accessToken = await secureStorageService.getAccessToken();
    try {
      var response = await http.get(
        Uri.parse('$rootUrl/getYesterdayPorterPnL'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      // ! Handle Token Expiry (401)
      if (response.statusCode == 401) {
        final success = await tokenService.refreshAccessToken();

        if (success) {
          final newAccessToken = await secureStorageService.getAccessToken();
          response = await http.get(
            Uri.parse('$rootUrl/getYesterdayPorterPnL'),
            headers: {
              'Authorization': 'Bearer $newAccessToken',
              'Content-Type': 'application/json',
            },
          );
        } else {
          throw Exception('Session expired. Please log in again.');
        }
      }

      // ! Handle Success Response (200)
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        log('Yesterday Pnl fetching success ');
        if (decoded['data'] != null) {
          log(decoded['data'].toString());
          return decoded['data'] as Map<String, dynamic>;
        } else {
          log('Invalid response format: data missing.');
          return {};
        }
      } else {
        // ! Handle Other Error Responses
        log(
          'Failed to fetch Yesterday PnL. Status Code: ${response.statusCode}',
        );
        return {};
      }
    } catch (e) {
      log('Error while fetching Yesterday PnL: $e');
      return {}; // ! Always return safe empty map on any crash
    }
  }

  //! ---------------------------------------------------
  // ! Monthly Pnl Service -----------------------------
  Future<Map<String, dynamic>> getMonthlyPnL() async {
    final accessToken = await secureStorageService.getAccessToken();
    try {
      var response = await http.get(
        Uri.parse('$rootUrl/getMonthlyPorterPnL'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      // ! Handle Token Expiry (401)
      if (response.statusCode == 401) {
        final success = await tokenService.refreshAccessToken();

        if (success) {
          final newAccessToken = await secureStorageService.getAccessToken();
          response = await http.get(
            Uri.parse('$rootUrl/getMonthlyPorterPnL'),
            headers: {
              'Authorization': 'Bearer $newAccessToken',
              'Content-Type': 'application/json',
            },
          );
        } else {
          throw Exception('Session expired. Please log in again.');
        }
      }

      // ! Handle Success Response (200)
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        log('Monthly pnl fetching success ');
        if (decoded['data'] != null) {
          log(decoded['data'].toString());
          return decoded['data'] as Map<String, dynamic>;
        } else {
          log('Invalid response format: data missing.');
          return {};
        }
      } else {
        // ! Handle Other Error Responses
        log('Failed to fetch Monthly PnL. Status Code: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      log('Error while fetching Monthly PnL: $e');
      return {}; // ! Always return safe empty map on any crash
    }
  }

  //! ---------------------------------------------------
}
