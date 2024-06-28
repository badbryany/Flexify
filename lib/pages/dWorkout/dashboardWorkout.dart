import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/pages/dWorkout/widgets/AllExercises.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashboardWorkoutStats(sets: sets),
        global.smallHeight(context),
        const WorkoutPlan(),
        global.smallHeight(context),
        AllExercises(
          sets: sets,
          reload: getData,
        ),
        global.smallHeight(context),
        YourTrainingPlan(sets: sets),
      ],
    );
  }
}
