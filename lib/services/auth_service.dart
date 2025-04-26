import 'dart:convert';
import 'dart:developer';
import 'package:fleet_wise/services/local_storage_service.dart';
import 'package:fleet_wise/services/secure_storage_service.dart';
import 'package:fleet_wise/services/token_service.dart';
import 'package:http/http.dart' as http;
import '../models/auth_response_model.dart';
import '../models/send_otp_response.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  // Private named constructor
  AuthService._internal();

  // Singleton accessor
  static AuthService get instance => _instance;
  final String rootUrl =
      'https://avaronn-backend-development-server.pemy8f8ay9m4p.ap-south-1.cs.amazonlightsail.com/test';
  late SecureStorageService secureStorageService;
  late TokenService tokenService;
  void init({
    required SecureStorageService storage,
    required TokenService token,
  }) {
    secureStorageService = storage;
    tokenService = token;
  }

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

  //! Access Token via refresh token
  Future<String?> refreshAccessToken(String refreshToken) async {
    try {
      final response = await http.get(
        Uri.parse('$rootUrl/refreshAccessToken'),
        headers: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body)['access_token'];
      } else {
        log('refresh token failed1');
      }
    } catch (e) {
      log('Error while RefreshtToken $e');
    }
    return null;
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
      // ! Check for token expiration
      if (response.statusCode == 401) {}
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        await LocalStorageService().saveUserName(name); // Save locally
        log('----name updated successfully----');
        log('Response body: ${response.body}');
        log('Response status: ${response.statusCode}');
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
