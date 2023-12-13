import 'package:flexify/pages/workout/exercisesPage/addExercisePage/addExercisePage.dart';
import 'package:flexify/pages/workout/exercisesPage/widgets/exerciseButton.dart';
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
  List<Set> sets = [];
  bool loadingDone = false;

  getData() async {
    loadingDone = false;
    setState(() {});

    exercises = (await Save.setExerciseIfNull())
        .map((e) => Exercise.fromStringtoObject(e))
        .toList();

    sets = (await Save.setSetIfNull())
        .map((e) => Set.fromStringToObject(e))
        .toList();

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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.reload();
                        Navigator.pop(context);
                      },
                      color: Theme.of(context).focusColor,
                      icon: Icon(Icons.arrow_back_ios_new_rounded),
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
                              size: 30,
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
              Column(
                children: [
                  ...(loadingDone
                      ? exercises.map(
                          (e) => ExerciseButton(
                            exercise: e,
                            sets: sets
                                .where(
                                    (element) => element.exerciseName == e.name)
                                .toList(),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}