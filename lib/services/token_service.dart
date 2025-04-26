import 'dart:developer';

import 'package:fleet_wise/services/secure_storage_service.dart';
import 'package:fleet_wise/services/auth_service.dart';

class TokenService {
  static final TokenService _instance = TokenService._internal();
  // Private named constructor
  TokenService._internal();

  // Singleton accessor
  static TokenService get instance => _instance;
  late SecureStorageService secureStorageService;
  late AuthService authService;
  void init({
    required SecureStorageService storage,
    required AuthService auth,
  }) {
    secureStorageService = storage;
    authService = auth;
  }

  //! Checks if token is expired (401), and tries to refresh.
  //! Returns true if token was refreshed successfully, false otherwise.
  Future<bool> handleTokenRefreshIfNeeded(int statusCode) async {
    if (statusCode == 401) {
      final refreshToken = await secureStorageService.getRefreshToken();

      if (refreshToken == null || refreshToken.isEmpty) {
        // Optionally log this
        log(' Refresh token not found. User should log in again.');
        return false;
      }

      final newToken = await authService.refreshAccessToken(refreshToken);

      if (newToken != null) {
        await secureStorageService.saveTokens(newToken, refreshToken);
        return true;
      } else {
        await secureStorageService.clearTokens();
        log(' Session expired. Tokens cleared.');
        return false;
      }
    }

    return false;
  }
}
