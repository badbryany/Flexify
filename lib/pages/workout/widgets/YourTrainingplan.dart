import 'package:flutter/material.dart';
import 'package:flexify/data/globaleVariables.dart' as global;

import 'package:flexify/data/AnaliseWorkoutData/analyseWorkoutData.dart'
    as analize;
import 'package:flexify/data/AnaliseWorkoutData/WorkoutDay.dart';
import 'package:flexify/data/exerciseModels.dart';

class YourTrainingPlan extends StatefulWidget {
  const YourTrainingPlan({super.key});

  @override
  State<YourTrainingPlan> createState() => _YourTrainingPlanState();
}

class _YourTrainingPlanState extends State<YourTrainingPlan> {
  List<WorkoutDay> workoutDays = [];
  List<Set> sets = [];
  getData() async {
    sets = (await Save.setSetIfNull())
        .map((e) => Set.fromStringToObject(e))
        .toList();

    workoutDays = analize.analyseWorkout(sets);

    setState(() {});
  }

  List<Widget> workoutDaysWidgets() {
    List<Widget> _showSets(WorkoutDay workoutDay) {
      List<dynamic> realSets = analize.getAverageWorkoutString(
        workoutDay,
        sets,
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
            ..._showSets(workoutDays[i]),
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
            'We maybe have too little trainingdata to detect every split.',
            'If you track enough it will be more percisely.',
            'If that data still isn\'t correct, please contact the support!'
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
