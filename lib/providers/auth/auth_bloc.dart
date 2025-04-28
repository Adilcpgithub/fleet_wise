import 'dart:developer';
import 'package:fleet_wise/providers/auth/auth_event.dart';
import 'package:fleet_wise/providers/auth/auth_state.dart';
import 'package:fleet_wise/services/auth_service.dart';
import 'package:fleet_wise/services/secure_storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final authService = AuthService.instance;
  final SecureStorageService storageService = SecureStorageService();

  AuthBloc() : super(AuthInitial()) {
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<RefreshTokenEvent>(_onRefreshToken);
    on<AutoLoginEvent>(_onAutoLogin);
  }

  Future<void> _onSendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await authService.sendOtp(event.phoneNumber);
      emit(OtpSent(response.requestId));
    } catch (e) {
      emit(AuthFailure('Failed to send OTP: $e'));
    }
  }

  Future<void> _onVerifyOtp(
    VerifyOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final authResponse = await authService.verifyOtp(
        phoneNumber: event.phoneNumber,
        otp: event.otp,
        requestId: event.requestId,
      );
      if (!authResponse.exists) {
        emit(AuthFailure('Failed to verify OTP'));
        return;
      }
      log('verifiying the token');
      //! Save tokens to secure storage
      await storageService.saveTokens(
        authResponse.accessToken,
        authResponse.refreshToken,
      );
      log('tokens saved');

      emit(AuthVerified(authResponse));
    } catch (e) {
      emit(AuthFailure('OTP verification failed: $e'));
    }
  }

  Future<void> _onRefreshToken(
    RefreshTokenEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final refreshToken = await storageService.getRefreshToken();

      if (refreshToken == null || refreshToken.isEmpty) {
        log('No refresh token found.');
        emit(AuthFailure('No refresh token found'));
        return;
      }

      log('Trying to refresh access token...');

      final newAccessToken = await authService.refreshAccessToken(refreshToken);

      if (newAccessToken == null) {
        log('Refresh token failed (422). Clearing tokens.');
        await storageService.clearTokens(); // 🔥 Remove bad refresh token
        emit(AuthFailure('Session expired. Please log in again.'));
        return;
      }

      await storageService.saveTokens(newAccessToken, refreshToken);
      log('Access token refreshed successfully');
      //emit(AuthVerified());
    } catch (e) {
      log('Failed to refresh token: $e');
      emit(AuthFailure('Failed to refresh token.'));
    }
  }

  Future<void> _onAutoLogin(
    AutoLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    log('Auto login calling...');

    final accessToken = await storageService.getAccessToken();
    final refreshToken = await storageService.getRefreshToken();

    if (accessToken != null && refreshToken != null) {
      // ✅ First, try using the existing access token (avoid unnecessary refresh)
      final isTokenValid = await authService.verifyAccessToken(accessToken);

      if (isTokenValid) {
        log('Access token is still valid');
        emit(AuthAutoLoginSuccess());
        return;
      }

      // ❌ If token is expired, THEN refresh
      log('Access token expired. Trying to refresh...');

      final newToken = await authService.refreshAccessToken(refreshToken);

      if (newToken != null) {
        await storageService.saveTokens(newToken, refreshToken);
        log('Access token refreshed successfully');
        emit(AuthAutoLoginSuccess());
      } else {
        log('Refresh token failed');
        await storageService.clearTokens(); // 🔥 Remove expired tokens
        emit(AuthAutoLoginFailed());
      }
    } else {
      log('No valid tokens found. Auto-login failed.');
      emit(AuthAutoLoginFailed());
    }
  }
}
