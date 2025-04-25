import 'package:fleet_wise/models/auth_response_model.dart';
import 'package:fleet_wise/providers/auth/auth_event.dart';
import 'package:fleet_wise/providers/auth/auth_state.dart';
import 'package:fleet_wise/services/auth_service.dart';
import 'package:fleet_wise/services/secure_storage_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService = AuthService();
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
      if (response == null) {
        emit(AuthFailure('Failed to send OTP'));
        return;
      }
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
      if (authResponse == null) {
        emit(AuthFailure('Failed to verify OTP'));
        return;
      }
      //! Save tokens to secure storage
      await storageService.saveTokens(
        authResponse.accessToken,
        authResponse.refreshToken,
      );

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
      if (refreshToken != null) {
        final accessToken = await authService.refreshAccessToken(refreshToken);
        if (accessToken == null) {
          emit(AuthFailure('Failed to refresh access token'));
          return;
        }
        await storageService.saveTokens(accessToken, refreshToken);
        // You can emit a state like AccessTokenRefreshed(accessToken) if needed
      } else {
        emit(AuthFailure('No refresh token found'));
      }
    } catch (e) {
      emit(AuthFailure('Failed to refresh token: $e'));
    }
  }

  Future<void> _onAutoLogin(
    AutoLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    final accessToken = await storageService.getAccessToken();
    final refreshToken = await storageService.getRefreshToken();

    if (accessToken != null && refreshToken != null) {
      // Assume tokens are valid and go to home screen (or refresh if expired)
      emit(
        AuthVerified(
          AuthResponseModel(
            accessToken: accessToken,
            refreshToken: refreshToken,
            tokenType: 'bearer',
            exists: true,
            uuid: 'auto-login',
          ),
        ),
      );
    } else {
      emit(AuthInitial());
    }
  }
}
