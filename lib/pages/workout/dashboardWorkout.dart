import 'package:flexify/pages/workout/workoutPage.dart';
import 'package:flutter/material.dart';
import 'package:flexify/widgets/dashboardXOptionButton.dart';

class DashboardWorkout extends StatefulWidget {
  const DashboardWorkout({super.key});

  @override
  State<DashboardWorkout> createState() => _DashboardWorkoutState();
}

class _DashboardWorkoutState extends State<DashboardWorkout> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        DashboardXOptionButton(
          title: 'suggested workout',
          targetPage: WorkoutPage(),
          content: Text(
              '4 x 13 Benchpress\n4 x 13 Benchpress\n4 x 13 Benchpress\n4 x 13 Benchpress\n'),
        ),
        DashboardXOptionButton(
          title: 'start workout',
          targetPage: WorkoutPage(),
          content: Text(''),
        ),
        DashboardXOptionButton(
          title: 'start workout',
          targetPage: WorkoutPage(),
          content: Text(''),
        ),
      ],
    );
  }
}
