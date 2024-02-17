import 'package:flexify/data/exerciseModels.dart';
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
        const SizedBox(height: 10),
        StartWorkout(
          sets: sets,
          reload: getData,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
