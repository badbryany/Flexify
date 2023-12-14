import 'package:flexify/pages/workout/exercisesPage/widgets/ExerciseButton.dart';
import 'package:flexify/widgets/SearchBar.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/exerciseModels.dart';

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
  int _searchBarOpen = 0;
  TextEditingController controller = TextEditingController();

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
                    Container(
                      padding: const EdgeInsets.all(4.3),
                      decoration: BoxDecoration(
                        boxShadow: ([
                          BoxShadow(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.25),
                            spreadRadius: -10.0,
                            blurRadius: 10.0,
                            offset: const Offset(0.0, 10.0),
                          ),
                        ]),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        splashColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          widget.reload();
                          Navigator.pop(context);
                        },
                        color: Theme.of(context).focusColor,
                        icon: const Icon(Icons.arrow_back_rounded),
                        iconSize: 20,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.center,
                      width: _searchBarOpen == 1
                          ? 0
                          : MediaQuery.of(context).size.width * 0.33,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
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
                          )
                        ],
                      ),
                    ),
                    AnimSearchBar(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      helpText: 'Add exercise to workout',
                      width: 400,
                      textController: controller,
                      onSubmitted: (foo) {},
                      suffixIcon: const Icon(Icons.clear),
                      onSuffixTap: () {
                        controller.clear();
                      },
                      onToggle: (int open) {
                        setState(() => _searchBarOpen = open);
                      },
                      closeSearchOnSuffixTap: true,
                      autoFocus: true,
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
