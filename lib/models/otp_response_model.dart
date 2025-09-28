class OtpResponse {
  final int statuscode;
  final String message;
  final String? token;

  OtpResponse({required this.statuscode, required this.message, this.token});

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      statuscode: json['statuscode'],
      message: json['message'],
      token: json['token'],
    );
  }
}
