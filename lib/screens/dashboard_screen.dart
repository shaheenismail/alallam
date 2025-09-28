import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../providers/dashboard_provider.dart';
import '../utils/prefs.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final dashboardProvider =
        Provider.of<DashboardProvider>(context, listen: false);
    await dashboardProvider.loadDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dashboard",
          style: GoogleFonts.figtree(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.red),
            onPressed: () async {
              await Prefs.clear();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                  (route) => false);
            },
          )
        ],
      ),
      body: dashboardProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : dashboardProvider.dashboard == null
              ? Center(child: Text("No data found"))
              : RefreshIndicator(
                  onRefresh: _loadData,
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: [
                      // 🔹 Top Stats
                      Row(
                        children: [
                          _buildStatCard(
                              "View Requests",
                              dashboardProvider.dashboard?.viewRequest ?? 0,
                              Colors.teal),
                          SizedBox(width: 12),
                          _buildStatCard(
                              "Hold Requests",
                              dashboardProvider.dashboard?.holdRequest ?? 0,
                              Colors.orange),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          _buildStatCard(
                              "Companies Enabled",
                              dashboardProvider.dashboard?.enabledCompanies ??
                                  0,
                              Colors.purple),
                          SizedBox(width: 12),
                          _buildStatCard(
                              "Properties",
                              dashboardProvider.dashboard?.properties ?? 0,
                              Colors.blue),
                        ],
                      ),
                      SizedBox(height: 20),

                      // 🔹 Charts Section
                      if (dashboardProvider.dashboard!.buildData.isNotEmpty)
                        _buildChartSection(
                          "Build Data",
                          dashboardProvider.dashboard!.buildData,
                          Colors.blueAccent,
                          Icons.apartment,
                        ),
                      SizedBox(height: 16),
                      if (dashboardProvider.dashboard!.roomData.isNotEmpty)
                        _buildChartSection(
                          "Room Data",
                          dashboardProvider.dashboard!.roomData,
                          Colors.green,
                          Icons.meeting_room,
                        ),
                      SizedBox(height: 16),
                      if (dashboardProvider.dashboard!.locationData.isNotEmpty)
                        _buildChartSection(
                          "Location Data",
                          dashboardProvider.dashboard!.locationData,
                          Colors.deepPurple,
                          Icons.location_city,
                        ),
                      SizedBox(height: 16),
                      if (dashboardProvider.dashboard!.propCompData.isNotEmpty)
                        _buildChartSection(
                          "Property Companies",
                          dashboardProvider.dashboard!.propCompData,
                          Colors.teal,
                          Icons.business,
                        ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildStatCard(String title, int value, Color color) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [color.withOpacity(0.7), color]),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value.toString(),
                style: GoogleFonts.figtree(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                title,
                style: GoogleFonts.figtree(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChartSection(
      String title, List data, Color color, IconData icon) {
    final List<_ChartData> chartData = data
        .map((item) => _ChartData(item.label.toString(), item.value?.toDouble() ?? 0))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GoogleFonts.figtree(
                fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        SizedBox(
  height: 250,
  child: SfCartesianChart(
    tooltipBehavior: TooltipBehavior(enable: true),
    primaryXAxis: CategoryAxis(),
    primaryYAxis: NumericAxis(),
    series: <CartesianSeries<_ChartData, String>>[
      ColumnSeries<_ChartData, String>(
        dataSource: chartData,
        xValueMapper: (_ChartData data, _) => data.label,
        yValueMapper: (_ChartData data, _) => data.value,
        name: title,
        color: color,
        dataLabelSettings: DataLabelSettings(isVisible: true),
      ),
    ],
  ),
),

      ],
    );
  }
}
class _ChartData {
  final String label;
  final double value;
  _ChartData(this.label, this.value);
}
