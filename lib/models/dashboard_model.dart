class DashboardModel {
  final int viewRequest;
  final int holdRequest;
  final int enabledCompanies;
  final int holdRequestMonth;
  final int viewRequestMonth;
  final int properties;
  final List<ChartData> buildData;
  final List<ChartData> roomData;
  final List<ChartData> locationData;
  final List<ChartData> propCompData;

  DashboardModel({
    required this.viewRequest,
    required this.holdRequest,
    required this.enabledCompanies,
    required this.holdRequestMonth,
    required this.viewRequestMonth,
    required this.properties,
    required this.buildData,
    required this.roomData,
    required this.locationData,
    required this.propCompData,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      viewRequest: json['viewRequest'] ?? 0,
      holdRequest: json['holdRequest'] ?? 0,
      enabledCompanies: json['enabledCompanies'] ?? 0,
      holdRequestMonth: json['holdRequestMonth'] ?? 0,
      viewRequestMonth: json['viewRequestMonth'] ?? 0,
      properties: json['properties'] ?? 0,
      buildData: (json['buildData'] as List<dynamic>)
          .map((e) => ChartData.fromJson(e))
          .toList(),
      roomData: (json['roomData'] as List<dynamic>)
          .map((e) => ChartData.fromJson(e))
          .toList(),
      locationData: (json['locationData'] as List<dynamic>)
          .map((e) => ChartData.fromJson(e))
          .toList(),
      propCompData: (json['propCompData'] as List<dynamic>)
          .map((e) => ChartData.fromJson(e))
          .toList(),
    );
  }
}

class ChartData {
  final dynamic label;
  final int value;

  ChartData({required this.label, required this.value});

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      label: json['label'],
      value: json['value'] ?? 0,
    );
  }
}
