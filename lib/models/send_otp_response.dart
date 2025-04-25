class SendOtpResponse {
  final String requestId;

  SendOtpResponse({required this.requestId});

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendOtpResponse(requestId: json['request_id']);
  }
}
