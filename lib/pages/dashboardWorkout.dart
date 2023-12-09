import 'package:flutter/material.dart';

class DashboardWorkout extends StatefulWidget {
  const DashboardWorkout({super.key});

  @override
  State<DashboardWorkout> createState() => _DashboardWorkoutState();
}

class _DashboardWorkoutState extends State<DashboardWorkout> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Workout',
        style: TextStyle(fontSize: 50),
      ),
    );
  }
}