import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

import 'package:flexify/data/AnalyseWorkoutData/analyseWorkoutData.dart'
    as analize;
import 'package:flexify/data/AnalyseWorkoutData/WorkoutDay.dart';
import 'package:flexify/data/exerciseModels.dart';

class YourTrainingPlan extends StatefulWidget {
  const YourTrainingPlan({
    super.key,
    required this.sets,
  });

  final List<Set> sets;

  @override
  State<YourTrainingPlan> createState() => _YourTrainingPlanState();
}

class _YourTrainingPlanState extends State<YourTrainingPlan> {
  List<WorkoutDay> workoutDays = [];
  getData() async {
    workoutDays = analize.analyseWorkout(widget.sets);

    setState(() {});
  }

  List<Widget> workoutDaysWidgets() {
    List<Widget> showSets(WorkoutDay workoutDay) {
      List<dynamic> realSets = analize.getAverageWorkoutString(
        workoutDay,
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

    List<Widget> returnList = [];
    for (int i = 0; i < workoutDays.length; i++) {
      returnList.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Day ${i + 1}:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).focusColor,
              ),
            ),
            ...showSets(workoutDays[i]),
          ],
        ),
      );
    }
    return returnList;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(global.containerPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(global.borderRadius),
        boxShadow: [global.lightShadow],
      ),
      width: MediaQuery.of(context).size.width * global.containerWidthFactor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detected Trainingplan:',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).focusColor,
            ),
          ),
          const SizedBox(height: 20),
          ...workoutDaysWidgets(),
          const SizedBox(height: 20),
          ...[
            'More data needed for accurate evalutation',
            'Please continue using the app to enable this feature'
          ].map(
            (e) => Text(
              e,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).focusColor.withOpacity(0.25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
