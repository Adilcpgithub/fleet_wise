import 'dart:convert';
import 'dart:developer';
import 'package:fleet_wise/services/local_storage_service.dart';
import 'package:http/http.dart' as http;
import '../models/auth_response_model.dart';
import '../models/send_otp_response.dart';

class AuthService {
  final String rootUrl =
      'https://avaronn-backend-development-server.pemy8f8ay9m4p.ap-south-1.cs.amazonlightsail.com/test';

  Future<SendOtpResponse> sendOtp(String phoneNumber) async {
    final response = await http.post(
      Uri.parse('$rootUrl/sendOtp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'country_code': "91", 'phone_number': phoneNumber}),
    );

    if (response.statusCode == 200) {
      return SendOtpResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to send OTP');
    }
  }

  // ! VerifyOtp
  Future<AuthResponseModel> verifyOtp({
    required String phoneNumber,
    required String otp,
    required String requestId,
  }) async {
    final response = await http.post(
      Uri.parse('$rootUrl/verifyOtp'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'country_code': "91",
        'phone_number': phoneNumber,
        'otp': otp,
        'request_id': requestId,
        'user': 'mfo',
        'fcm_token': "testingfcmtoken",
      }),
    );
    try {
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
    } catch (e) {
      log('Error parsing response: $e');
    }
    if (response.statusCode == 201) {
      return AuthResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('OTP verification failed');
    }
  }

  //! Refresh Token
  Future<String> refreshAccessToken(String refreshToken) async {
    final response = await http.get(
      Uri.parse('$rootUrl/refreshAccessToken'),
      headers: {'refresh_token': refreshToken},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['access_token'];
    } else {
      throw Exception('Failed to refresh token');
    }
  }

  // ! Update User Name
  Future<bool> updateName(String name, String accessToken) async {
    try {
      final response = await http.put(
        Uri.parse('$rootUrl/updateName'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({'name': name}),
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        await LocalStorageService().saveUserName(name); // Save locally
        return true;
      } else {
        log('Failed to update name: ${response.statusCode}');
        throw Exception('Failed to update name: ${response.statusCode}');
      }
    } catch (e) {
      log('Error during updateName: $e');
      throw Exception('Error during updateName: $e');
    }
  }
}
