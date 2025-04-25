import 'package:equatable/equatable.dart';
import 'package:fleet_wise/models/auth_response_model.dart';

abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class OtpSent extends AuthState {
  final String requestId;

  OtpSent(this.requestId);

  @override
  List<Object> get props => [requestId];
}

class AuthVerified extends AuthState {
  final AuthResponseModel authData;

  AuthVerified(this.authData);

  @override
  List<Object> get props => [authData];
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
  @override
  List<Object> get props => throw [message];
}
