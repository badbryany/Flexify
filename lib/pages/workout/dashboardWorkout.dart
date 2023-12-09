import 'package:flexify/pages/workout/workoutCreator.dart';
import 'package:flutter/material.dart';
import 'package:flexify/widgets/workout/dashboardXOptionButton.dart';

class DashboardWorkout extends StatefulWidget {
  const DashboardWorkout({super.key});

  @override
  State<DashboardWorkout> createState() => _DashboardWorkoutState();
}

class _DashboardWorkoutState extends State<DashboardWorkout> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return DashboardXOptionButton(targetPage: WorkoutCreator(),);
      },
    );
  }
}
