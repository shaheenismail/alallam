class LoginResponse {
  final int statuscode;
  final String message;
  final int inUserId;

  LoginResponse({required this.statuscode, required this.message, required this.inUserId});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      statuscode: json['statuscode'],
      message: json['message'],
      inUserId: json['in_userid'],
    );
  }
}
