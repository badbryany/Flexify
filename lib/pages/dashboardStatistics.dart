import 'package:flutter/material.dart';

class DashboardStatistics extends StatefulWidget {
  const DashboardStatistics({super.key});
  
  @override
  State<DashboardStatistics> createState() => DashboardStatisticsState();
}

class DashboardStatisticsState extends State<DashboardStatistics> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Statistics',
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
