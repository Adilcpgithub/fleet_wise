import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {}

class SendOtpEvent extends AuthEvent {
  final String phoneNumber;

  SendOtpEvent({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

class VerifyOtpEvent extends AuthEvent {
  final String phoneNumber;
  final String requestId;
  final String otp;

  VerifyOtpEvent({
    required this.phoneNumber,
    required this.otp,
    required this.requestId,
  });

  @override
  List<Object> get props => [phoneNumber, otp, requestId];
}

class RefreshTokenEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class AutoLoginEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}
