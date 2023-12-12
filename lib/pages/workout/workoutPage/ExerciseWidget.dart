import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/pages/workout/workoutPage/setPage/setsPage.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

class ExerciseWidget extends StatelessWidget {
  const ExerciseWidget({
    super.key,
    required this.exercise,
  });

  final Exercise exercise;
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageTransition(
          child: ExerciseSets(
            name: exercise.name,
            refresh: () {},
          ),
          type: PageTransitionType.fade,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              exercise.name,
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
