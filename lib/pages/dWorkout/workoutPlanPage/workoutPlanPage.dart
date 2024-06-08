import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/pages/dShop/pages/widgets/ShopNavbar.dart';
import 'package:flexify/pages/dWorkout/workoutPlanPage/widgets/LeadWorkout.dart';
import 'package:flexify/pages/dWorkout/workoutPlanPage/widgets/exerciseButtonLight.dart';
import 'package:flutter/material.dart';

class WorkoutPlanPage extends StatefulWidget {
  const WorkoutPlanPage({super.key});

  @override
  State<WorkoutPlanPage> createState() => _WorkoutPlanPageState();
}

class _WorkoutPlanPageState extends State<WorkoutPlanPage> {
  List<Exercise> exercises = [];
  List<Set> sets = [];

  getData() async {
    exercises = await Save.getExerciseList();
    sets = await Save.getSetList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<Widget> exerciseWidgets(BuildContext context) {
    if (exercises.isEmpty) return [global.loadingWidget(context, .75)];

    List<Widget> returnWidgets = [];

    for (int i = 0; i < exercises.length; i++) {
      returnWidgets.add(
        ExerciseButtonLight(
          exercise: exercises[i],
          sets: sets,
        ),
      );
    }

    return returnWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ShopNavbar(
              title: 'Personal Workout',
              actionButton: ActionButton(
                iconData: Icons.play_arrow_rounded,
                action: () {},
              ),
            ),
            LeadWorkout(),
            ...exerciseWidgets(context),
          ],
        ),
      ),
    );
  }
}
