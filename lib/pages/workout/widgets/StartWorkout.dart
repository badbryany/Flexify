import 'package:flexify/pages/workout/exercisesPage/exercisesPage.dart';
import 'package:flexify/widgets/DashboardOptionButton.dart';
import 'package:flutter/material.dart';

class StartWorkout extends StatelessWidget {
  const StartWorkout({
    super.key,
    required this.reload,
  });

  final Function reload;

  @override
  Widget build(BuildContext context) {
    return DashboardXOptionButton(
      title: 'Recommended Workout',
      targetPage: WorkoutPage(
        reload: reload,
      ),
      content: const Text(''),
    );
  }
}
