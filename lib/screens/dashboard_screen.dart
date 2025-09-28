import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        title: Text("Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await Prefs.clear();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
                (route) => false,
              );
            },
          ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStatCard(
                              "View Requests",
                              dashboardProvider.dashboard?.viewRequest ?? 0),
                          _buildStatCard(
                              "Hold Requests",
                              dashboardProvider.dashboard?.holdRequest ?? 0),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStatCard(
                              "Companies Enabled",
                              dashboardProvider.dashboard?.enabledCompanies ?? 0),
                          _buildStatCard(
                              "Properties",
                              dashboardProvider.dashboard?.properties ?? 0),
                        ],
                      ),
                      SizedBox(height: 20),

                      // 🔹 Build Data
                      Text("Build Data",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      ...((dashboardProvider.dashboard?.buildData ?? [])
                          .map(
                            (data) => ListTile(
                              leading: Icon(Icons.apartment),
                              title: Text(data.label.toString()),
                              trailing: Text(data.value.toString()),
                            ),
                          )
                          .toList()),

                      SizedBox(height: 20),

                      // 🔹 Room Data
                      Text("Room Data",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      ...((dashboardProvider.dashboard?.roomData ?? [])
                          .map(
                            (data) => ListTile(
                              leading: Icon(Icons.meeting_room),
                              title: Text(data.label.toString()),
                              trailing: Text(data.value.toString()),
                            ),
                          )
                          .toList()),
                    ],
                  ),
                ),
    );
  }

  Widget _buildStatCard(String title, int value) {
    return Expanded(
      child: Card(
        color: Colors.blue.shade50,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(title,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              SizedBox(height: 8),
              Text(
                value.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
