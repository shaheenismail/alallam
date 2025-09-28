import 'package:flutter/material.dart';
import '../models/dashboard_model.dart';
import '../services/dashboard_service.dart';
import '../utils/prefs.dart';

class DashboardProvider with ChangeNotifier {
  DashboardModel? _dashboard;
  bool _isLoading = false;

  DashboardModel? get dashboard => _dashboard;
  bool get isLoading => _isLoading;

  final DashboardService _service = DashboardService();

  Future<void> loadDashboardData() async {
    _isLoading = true;
    //notifyListeners();

    try {
      final token = await Prefs.getToken();
      if (token != null) {
        _dashboard = await _service.fetchDashboardData(token);
      } else {
        _dashboard = null;
      }
    } catch (e) {
      print("Error loading dashboard: $e");
      _dashboard = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}
