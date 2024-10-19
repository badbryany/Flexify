import 'package:flexify/pages/dWorkout/exercisesPage/exercisesPage.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flexify/data/AnalyseWorkoutData/analyseWorkoutData.dart'
    as analyse;
import 'package:flexify/data/AnalyseWorkoutData/predictNextWorkout.dart';
import 'package:flexify/data/AnalyseWorkoutData/WorkoutDay.dart';

import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class AllExercises extends StatefulWidget {
  const AllExercises({
    super.key,
    required this.reload,
    required this.sets,
  });

  final Function reload;
  final List<Set> sets;

  @override
  State<AllExercises> createState() => _AllExercisesState();
}

class _AllExercisesState extends State<AllExercises> {
  WorkoutDay? nextWorkoutDay;

  getData() async {
    nextWorkoutDay = predictNextWorkout(
      analyse.analyseWorkout(widget.sets),
      widget.sets,
    );

    setState(() {});
  }

  List<Widget> showSets(WorkoutDay nextWorkoutDay) {
    List<dynamic> realSets = analyse.getAverageWorkoutString(
      nextWorkoutDay,
      widget.sets,
    );
    List<Widget> widgetList = [];

    for (int i = 0; i < realSets.length; i++) {
      widgetList.add(
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            '${realSets[i]['setCount']} x ${realSets[i]['exerciseName']}',
            style: TextStyle(
              fontSize: 17,
              color: Theme.of(context).focusColor,
            ),
          ),
        ),
      );
    }

    return widgetList;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return BounceElement(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExercisesPage(reload: widget.reload),
        ),
      ).then((value) => widget.reload()),
      child: Container(
        padding: EdgeInsets.all(global.containerPadding),
        decoration: BoxDecoration(
          color: global.darkGrey,
          borderRadius: BorderRadius.circular(global.borderRadius),
          boxShadow: global.shadow(context),
        ),
        width: global.width(context) * global.containerWidthFactor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All exercises',
                  style: TextStyle(
                    fontSize: global.width(context) * .0625,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Icon(
                  CupertinoIcons.arrow_right,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              'a list of all exercises you have',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
