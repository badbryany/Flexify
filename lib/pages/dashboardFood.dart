import 'package:flutter/material.dart';

class DashboardFood extends StatefulWidget {
  const DashboardFood({super.key});

  @override
  State<DashboardFood> createState() => DashboardFoodState();
}

class DashboardFoodState extends State<DashboardFood> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Food',
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}