import 'package:flexify/pages/workout/exercisesPage/exercisesPage.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/material.dart';

import 'package:flexify/data/AnalyseWorkoutData/analyseWorkoutData.dart'
    as analyse;
import 'package:flexify/data/AnalyseWorkoutData/predictNextWorkout.dart';
import 'package:flexify/data/AnalyseWorkoutData/WorkoutDay.dart';

import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:page_transition/page_transition.dart';

class StartWorkout extends StatefulWidget {
  const StartWorkout({
    super.key,
    required this.reload,
    required this.sets,
  });

  final Function reload;
  final List<Set> sets;

  @override
  State<StartWorkout> createState() => _StartWorkoutState();
}

class _StartWorkoutState extends State<StartWorkout> {
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
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          PageTransition(
            child: ExercisesPage(reload: widget.reload),
            type: PageTransitionType.rightToLeft,
          ),
        ).then((value) => widget.reload()),
        child: Container(
          padding: EdgeInsets.all(global.containerPadding),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(global.borderRadius),
            boxShadow: [global.lightShadow],
          ),
          width:
              MediaQuery.of(context).size.width * global.containerWidthFactor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Start Workout:',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  const Icon(Icons.arrow_forward_rounded),
                ],
              ),
              Text(
                'Recommended Workout',
                style: TextStyle(
                    color: Theme.of(context).focusColor.withOpacity(0.7)),
              ),
              ...(nextWorkoutDay == null
                  ? [const Text('error')]
                  : showSets(nextWorkoutDay!)),
              const SizedBox(height: 20),
              ...[
                'More data needed for accurate evalutation',
                'Please continue using the app for added performance'
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
        ),
      ),
    );
  }
}
