import 'package:flexify/pages/workout/workoutPage/addExercisePage/addExercisePage.dart';
import 'package:flexify/pages/workout/workoutPage/widgets/exerciseButton.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:page_transition/page_transition.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({
    super.key,
    required this.reload,
  });

  final Function reload;

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  List<Exercise> exercises = [];
  bool loadingDone = false;

  getData() async {
    loadingDone = false;
    setState(() {});
    exercises = [];
    List<String> exerciseList = await Save.setExerciseIfNull();

    for (int i = 0; i < exerciseList.length; i++) {
      exercises.add(
        Exercise.fromStringtoObject(exerciseList[i]),
      );
    }

    loadingDone = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * (1 - 0.82),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      bottom: 15,
                      left: 0,
                      child: GestureDetector(
                        onTap: () {
                          widget.reload();
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: Icon(
                            color: Theme.of(context).focusColor,
                            Icons.arrow_back_ios_new_rounded,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Workout',
                        style: TextStyle(
                          color: Theme.of(context).focusColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  ...(loadingDone
                      ? exercises.map(
                          (e) => ExerciseButton(
                            exercise: e,
                            reload: getData,
                          ),
                        )
                      : [
                          Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.width * 0.1,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: const CircularProgressIndicator(),
                            ),
                          )
                        ]),
                  loadingDone
                      ? IconButton(
                          onPressed: () => Navigator.push(
                            context,
                            PageTransition(
                              child: AddExercise(refresh: getData),
                              type: PageTransitionType.fade,
                            ),
                          ),
                          icon: Icon(
                            Icons.add_rounded,
                            color: Theme.of(context).focusColor,
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
