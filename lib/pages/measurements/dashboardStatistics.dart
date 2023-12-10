import 'package:flutter/material.dart';

class DashboardMeasurements extends StatefulWidget {
  const DashboardMeasurements({super.key});
  
  @override
  State<DashboardMeasurements> createState() => DashboardMeasurementsState();
}

class DashboardMeasurementsState extends State<DashboardMeasurements> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Measurements',
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}
