import 'package:flexify/pages/workout/workoutCreator.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class DashboardXOptionButton extends StatefulWidget {
  Widget targetPage;

  DashboardXOptionButton({
    super.key,
    required this.targetPage,
  });

  @override
  State<DashboardXOptionButton> createState() => _DashboardXOptionButtonState();
}

class _DashboardXOptionButtonState extends State<DashboardXOptionButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          PageTransition(
            child: const WorkoutCreator(),
            type: PageTransitionType.fade,
          )),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          color: const Color.fromARGB(255, 68, 53, 53),
          height: 200,
        ),
      ),
    );
  }
}
