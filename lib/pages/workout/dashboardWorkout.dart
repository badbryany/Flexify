import 'package:flexify/pages/workout/widgets/dashboardWorkoutStats.dart';
import 'package:flutter/material.dart';

import 'package:flexify/widgets/DashboardOptionButton.dart';
import 'package:flexify/pages/workout/exercisesPage/exercisesPage.dart';

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
        DashboardXOptionButton(
          title: 'Recommended Workout',
          targetPage: WorkoutPage(
            reload: reload,
          ),
          content: const Text(''),
        ),
        const SizedBox(height: 10),
        DashboardXOptionButton(
          title: 'Custom Workout',
          targetPage: WorkoutPage(
            reload: reload,
          ),
          content: const Text(''),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
