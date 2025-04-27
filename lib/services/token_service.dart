import 'package:fleet_wise/services/secure_storage_service.dart';
import 'package:fleet_wise/services/auth_service.dart';

class TokenService {
  static final TokenService _instance = TokenService._internal();
  //! Private named constructor
  TokenService._internal();

  // ! Singleton accessor
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

  //! checking  Refreshing Access Token
  Future<bool> refreshAccessToken() async {
    final refreshToken = await secureStorageService.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      return false;
    }

    final newAccessToken = await authService.refreshAccessToken(refreshToken);

    if (newAccessToken != null) {
      await secureStorageService.saveTokens(newAccessToken, refreshToken);
      return true;
    } else {
      await secureStorageService.clearTokens();
      return false;
    }
  }
}
