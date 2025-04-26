import 'dart:convert';
import 'dart:developer';
import 'package:fleet_wise/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:fleet_wise/services/secure_storage_service.dart'; // Assuming you have this

class ProfiLossService {
  final String rootUrl =
      'https://avaronn-backend-development-server.pemy8f8ay9m4p.ap-south-1.cs.amazonlightsail.com/test'; // 🔥 Replace with your real root_url
  final SecureStorageService secureStorageService = SecureStorageService();
  final authService = AuthService.instance;

  Future<Map<String, dynamic>> getTodayPnL() async {
    final accessToken = await secureStorageService.getAccessToken();
    final refreshToken = await secureStorageService.getRefreshToken();

    if (accessToken == null || accessToken.isEmpty) {
      log('Access token not found.');
    } else {
      if (refreshToken != null) {
        await authService.refreshAccessToken(refreshToken);
        await secureStorageService.saveTokens(accessToken, refreshToken);
      }
    }

    final response = await http.get(
      Uri.parse('$rootUrl/getTodayPorterPnL'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      log('p and l fetching success ');
      if (decoded['data'] != null) {
        log(decoded['data'].toString());
        return decoded['data']
            as Map<
              String,
              dynamic
            >; // Returning 'vehicles' and 'header' directly
      } else {
        log('Invalid response format: data missing.');
        return {};
        // throw Exception('Invalid response format: data missing.');
      }
    } else {
      log('Failed to fetch Today PnL. Status Code: ${response.statusCode}');
      return {};
      // throw Exception(
      //   'Failed to fetch Today PnL. Status Code: ${response.statusCode}',
      // );
    }
  }
}
