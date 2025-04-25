import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:fleet_wise/services/secure_storage_service.dart';
import 'package:fleet_wise/services/auth_service.dart';

class TokenService {
  final SecureStorageService secureStorageService = SecureStorageService();
  final AuthService authService = AuthService();

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
