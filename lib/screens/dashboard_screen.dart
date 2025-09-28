import 'package:flutter/material.dart';
import '../utils/prefs.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await Prefs.clear();
              Navigator.pushReplacementNamed(context, '/');
            },
          )
        ],
      ),
      body: Center(child: Text("Welcome to Dashboard")),
    );
  }
}
