import 'package:allallam/models/login_response_model.dart';
import 'package:allallam/models/otp_response_model.dart';
import 'package:dio/dio.dart';


class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://realestate.alallamtech.com/demo/api-agent/"));

  Future<LoginResponse> login(String username, String password) async {
    final response = await _dio.post("login", data: {
      "username": username,
      "password": password,
    });

    return LoginResponse.fromJson(response.data);
  }

  Future<OtpResponse> verifyOtp(int userId, String otp) async {
    final response = await _dio.post("otp-verify", data: {
      "in_userid": userId,
      "otp_data": otp,
    });

    return OtpResponse.fromJson(response.data);
  }
}
