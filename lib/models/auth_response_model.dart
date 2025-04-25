class AuthResponseModel {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final bool exists;
  final String uuid;

  AuthResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.exists,
    required this.uuid,
  });
  @override
  String toString() {
    return 'AuthResponseModel{accessToken: $accessToken, refreshToken: $refreshToken, tokenType: $tokenType, exists: $exists, uuid: $uuid}';
  }

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      tokenType: json['token_type'],
      exists: json['exists'],
      uuid: json['uuid'],
    );
  }
}
