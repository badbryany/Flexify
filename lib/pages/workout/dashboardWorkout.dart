import 'package:flexify/pages/workout/widgets/StartWorkout.dart';
import 'package:flexify/pages/workout/widgets/YourTrainingplan.dart';
import 'package:flexify/pages/workout/widgets/dashboardWorkoutStats.dart';
import 'package:flutter/material.dart';

class DashboardWorkout extends StatefulWidget {
  const DashboardWorkout({super.key});

  @override
  State<DashboardWorkout> createState() => _DashboardWorkoutState();
}

class _DashboardWorkoutState extends State<DashboardWorkout> {
  reload() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DashboardWorkoutStats(),
        const SizedBox(height: 10),
        StartWorkout(
          reload: reload,
        ),
        const SizedBox(height: 10),
        const YourTrainingPlan(),
        const SizedBox(height: 10),
      ],
    );
  }
}
