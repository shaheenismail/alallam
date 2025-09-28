import 'package:allallam/models/dashboard_model.dart';
import 'package:allallam/utils/prefs.dart';
import 'package:dio/dio.dart';

class DashboardService {
  final Dio _dio = Dio();

  Future<DashboardModel?> fetchDashboardData(String token) async {
    try {
      final response = await _dio.post(
        "https://realestate.alallamtech.com/demo/api-agent/dash/fetchTotalData",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return DashboardModel.fromJson(response.data);
      } else {
        print("Dashboard API failed with status: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Dashboard API error: $e");
      return null;
    }
  }
}
