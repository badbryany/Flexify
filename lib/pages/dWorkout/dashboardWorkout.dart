import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/pages/dWorkout/widgets/AllExercises.dart';
import 'package:flexify/pages/dWorkout/widgets/QuickActions.dart';
import 'package:flexify/pages/dWorkout/widgets/WorkoutPlan.dart';
import 'package:flexify/pages/dWorkout/widgets/YourTrainingplan.dart';
import 'package:flexify/pages/dWorkout/widgets/dashboardWorkoutStats.dart';
import 'package:flutter/material.dart';

import 'package:flexify/data/globalVariables.dart' as global;

class DashboardWorkout extends StatefulWidget {
  const DashboardWorkout({super.key});

  @override
  State<DashboardWorkout> createState() => _DashboardWorkoutState();
}

class _DashboardWorkoutState extends State<DashboardWorkout> {
  List<Set> sets = [];

  getData() async {
    sets = await Save.getSetList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<Widget> elements(BuildContext context) => [
        DashboardWorkoutStats(sets: sets),
        const WorkoutPlan(),
        QuickActions(),
        AllExercises(sets: sets, reload: getData),
        YourTrainingPlan(sets: sets),
      ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: elements(context)
          .map(
            (e) => Padding(
              padding: EdgeInsets.only(
                bottom: global.height(context) * .015,
              ),
              child: e,
            ),
          )
          .toList(),
    );
  }
}
