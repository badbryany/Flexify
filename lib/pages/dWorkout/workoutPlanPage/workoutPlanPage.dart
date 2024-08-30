import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/pages/dShop/pages/widgets/ShopNavbar.dart';
import 'package:flexify/pages/dWorkout/workoutPlanPage/widgets/exerciseButtonLight.dart';
import 'package:flexify/widgets/ModalBottomSheet.dart';
import 'package:flutter/cupertino.dart';
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

  List<Map<String, dynamic>> exercisesToBeCompleted = [
    {
      'exerciseName': 'Dumbbell Curls',
      'timed': false,
      'weighted': true,
      'time': const Duration(seconds: 60),
      'reps': 12,
      'weight': 50,
    },
    {
      'exerciseName': 'Dumbbell Rows',
      'timed': false,
      'weighted': true,
      'time': const Duration(seconds: 60),
      'reps': 12,
      'weight': 20,
    },
    {
      'exerciseName': 'Chest Press',
      'timed': false,
      'weighted': true,
      'time': const Duration(seconds: 60),
      'reps': 12,
      'weight': 100,
    },
    {
      'exerciseName': 'Bench Press',
      'timed': false,
      'weighted': true,
      'time': const Duration(seconds: 60),
      'reps': 12,
      'weight': 100,
    },
    {
      'exerciseName': 'Treadmill',
      'timed': true,
      'weighted': false,
      'time': const Duration(minutes: 10),
      'reps': 0,
      'weight': 0,
    },
  ];

  addExercise() {

  }

  removeExercise() {
    
  }

  @override
  Widget build(BuildContext context) {
    double overviewHeight = global.height(context) * .5;
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
            Padding(
              padding: EdgeInsets.all(global.containerPadding),
              child: Container(
                padding: EdgeInsets.all(
                  global.containerPadding,
                ),
                width: global.width(context),
                height: overviewHeight + global.height(context) * .07,
                decoration: global.boxDecoration(context),
                child: Column(
                  children: [
                    Container(
                      height: global.height(context) * .05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 3,
                            child: GestureDetector(
                              onTap: () {
                                showCustomModalBottomSheet(
                                  context,
                                  ModalBottomSheet(
                                      title: 'Total Exercises',
                                      titleSize: global.width(context) * .08,
                                      height: global.height(context) * .55,
                                      content: Padding(
                                        padding: EdgeInsets.all(
                                            global.containerPadding),
                                        child: Text(
                                          'This widget tells you the the total amount of exercises that are to be done within the current workout',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize:
                                                global.width(context) * .04,
                                          ),
                                        ),
                                      ),
                                      submitButtonText: 'Close',
                                      onPop: () {}),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: global.height(context) * .05,
                                decoration: BoxDecoration(
                                  boxShadow: global.shadow(context),
                                  borderRadius: BorderRadius.circular(30),
                                  color: global.lightGrey,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    global.gradient(
                                      Icon(
                                        Icons.list,
                                        color: Colors.white,
                                        size: global.width(context) * .06,
                                      ),
                                    ),
                                    global.smallWidth(context),
                                    Text(
                                      '20',
                                      style: TextStyle(
                                        fontSize: global.width(context) * .04,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            child: Container(
                              alignment: Alignment.center,
                              child: global.gradient(
                                Text(
                                  'Overview',
                                  style: TextStyle(
                                    fontSize: global.width(context) * .03 + 10,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: GestureDetector(
                              onTap: () {
                                showCustomModalBottomSheet(
                                  context,
                                  ModalBottomSheet(
                                      title: 'Total Workout Time',
                                      titleSize: global.width(context) * .08,
                                      height: global.height(context) * .55,
                                      content: Padding(
                                        padding: EdgeInsets.all(
                                            global.containerPadding),
                                        child: Text(
                                          'This widget tells you the time the entire workout is expected to take based on the data we have gathered',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize:
                                                  global.width(context) * .04),
                                        ),
                                      ),
                                      submitButtonText: 'Close',
                                      onPop: () {}),
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: global.lightGrey,
                                  boxShadow: global.shadow(context),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    global.gradient(
                                      Icon(
                                        Icons.access_alarm_outlined,
                                        color: Colors.white,
                                        size: global.width(context) * .05,
                                      ),
                                    ),
                                    global.smallWidth(context),
                                    Text(
                                      '30m',
                                      style: TextStyle(
                                        fontSize: global.width(context) * .04,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    global.smallHeight(context),
                    SizedBox(
                      height: overviewHeight -
                          global.height(context) * .05 -
                          global.height(context) * .02 -
                          global.containerPadding * 2,
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Colors.black,
                              Colors.black,
                              Colors.black,
                              Colors.black.withOpacity(.2)
                            ],
                            stops: [0.0, 0.1, 0.9, 1.0],
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.dstIn,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: exercisesToBeCompleted.length,
                          itemBuilder: (context, idx) {
                            Map<String, dynamic> exercise =
                                exercisesToBeCompleted[idx];
                            return Column(
                              children: [
                                idx != 0
                                    ? global.smallHeight(context)
                                    : const SizedBox(),
                                Container(
                                  padding:
                                      EdgeInsets.all(global.containerPadding),
                                  decoration: BoxDecoration(
                                    color: global.lightGrey,
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: global.shadow(context),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: global.width(context) * .35,
                                        child: Text(
                                          '${exercisesToBeCompleted[idx]['exerciseName']} ',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                global.width(context) * .0325,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: global.width(context) * .275,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                exercise['timed']
                                                    ? Text(
                                                        global.durationString(
                                                            exercise['time']),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              global.width(
                                                                      context) *
                                                                  .0325,
                                                        ),
                                                      )
                                                    : Text(
                                                        exercise['reps']
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              global.width(
                                                                      context) *
                                                                  .0325,
                                                        ),
                                                      ),
                                                exercise['weighted']
                                                    ? Row(
                                                        children: [
                                                          global.gradient(
                                                            Text(
                                                              ' x ',
                                                              style: TextStyle(
                                                                fontSize: global
                                                                        .width(
                                                                            context) *
                                                                    .0325,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            exercise['weight']
                                                                .toString(),
                                                            style: TextStyle(
                                                              fontSize:
                                                                  global.width(
                                                                          context) *
                                                                      .0325,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : const SizedBox(),
                                              ],
                                            ),
                                            Icon(
                                              CupertinoIcons.trash,
                                              color: Colors.white,
                                              size:
                                                  global.width(context) * .035,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    global.mediumHeight(context),
                    Container(
                      alignment: Alignment.center,
                      height: global.height(context) * .05,
                      decoration: BoxDecoration(
                        color: global.lightGrey,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: global.shadow(context),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: global.width(context) * .04,
                          ),
                          global.smallWidth(context),
                          Text(
                            'Add Exercise',
                            style: TextStyle(
                                fontSize: global.width(context) * .03),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
