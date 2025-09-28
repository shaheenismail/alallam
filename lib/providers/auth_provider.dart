import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/prefs.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool isLoading = false;
  int? userId;

  Future<String?> login(String username, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _authService.login(username, password);

      if (response.statuscode == 200) {
        userId = response.inUserId;
        return null; // success
      } else {
        return response.message;
      }
    } catch (e) {
      return "Login failed. Try again.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> verifyOtp(String otp) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await _authService.verifyOtp(userId!, otp);

      if (response.statuscode == 200 && response.token != null) {
        await Prefs.saveToken(response.token!);
        return null; // success
      } else {
        return response.message;
      }
    } catch (e) {
      return "OTP verification failed.";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
