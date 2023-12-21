import 'package:flexify/pages/workout/exercisesPage/setsPage/addeditSetPage/addeditSetPage.dart';
import 'package:flexify/pages/workout/exercisesPage/widgets/exerciseButton.dart';
import 'package:flexify/pages/workout/exercisesPage/widgets/RecommendedExerciseButton.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/widgets/SearchBar.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/data/dummyExercises.dart' as dummyExercises;
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:page_transition/page_transition.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({
    super.key,
    required this.reload,
  });

  final Function reload;

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  List<Exercise> exercises = [];
  List<Exercise> searchRecommendations = List.from(dummyExercises.gymExercises);
  List<Exercise> exerciseRecommendations =
      List.from(dummyExercises.dummyRecommendedExercises);
  List<Set> sets = [];
  bool loadingDone = false;
  int _searchBarOpen = 0;
  final TextEditingController _controller = TextEditingController();

  getData() async {
    loadingDone = false;
    setState(() {});

    exercises = await Save.getExerciseList();
    sets = await Save.getSetList();

    loadingDone = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      searchRecommendations = dummyExercises.gymExercises
          .where(
            (element) => element.name
                .toLowerCase()
                .contains(_controller.text.toLowerCase()),
          )
          .toList();
      setState(() {});
    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var animSearchBar = AnimSearchBar(
      color: Theme.of(context).scaffoldBackgroundColor,
      helpText: 'Add exercise',
      width:
          MediaQuery.of(context).size.width * global.containerWidthFactor * 0.9,
      textController: _controller,
      suffixIcon: const Icon(Icons.clear),
      onSuffixTap: () {
        _controller.clear();
      },
      onSubmitted: (String exercise) {
        setState(
          () {
            Save.saveExercise(Exercise(
                name: exercise,
                type: 'Custom',
                affectedMuscle: 'Custom',
                equipment: 'Custom'));
          },
        );
        widget.reload();
      },
      onToggle: (int open) {
        setState(() => _searchBarOpen = open);
      },
      closeSearchOnSuffixTap: true,
      autoFocus: true,
    );
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * (1 - 0.88),
                padding: _searchBarOpen == 1
                    ? EdgeInsets.only(
                        right: MediaQuery.of(context).size.width * 0.04,
                      )
                    : const EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Visibility(
                      visible: _searchBarOpen == 0,
                      child: AnimatedContainer(
                        duration: global.standardAnimationDuration,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.005),
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.width * 0.15,
                        decoration: BoxDecoration(
                          boxShadow: ([
                            global.lightShadow,
                          ]),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(1000),
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
                          iconSize: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: global.standardAnimationDuration,
                      width: MediaQuery.of(context).size.width *
                          0.4 *
                          (_searchBarOpen == 0 ? 1 : 0),
                      padding: const EdgeInsets.only(top: 10),
                      child: AnimatedOpacity(
                        duration: global.standardAnimationDuration,
                        opacity: _searchBarOpen == 0 ? 1 : 0,
                        child: Text(
                          'Workout',
                          maxLines: 1,
                          style: TextStyle(
                            color: Theme.of(context).focusColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1,
                            fontSize: MediaQuery.of(context).size.width * 0.1,
                          ),
                        ),
                      ),
                    ),
                    animSearchBar,
                  ],
                ),
              ),
              _searchBarOpen == 0
                  ? AnimatedContainer(
                      duration: global.standardAnimationDuration,
                      child: Column(
                        children: [
                          ...(loadingDone
                              ? [
                                  ...[const Text('Recommended Exercises')],
                                  ...exerciseRecommendations.take(2).toList(),
                                  ...[const Text('Current Workout')],
                                  ...(exercises.reversed.toList())
                                ].map(
                                  (e) => e.runtimeType == Text
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.01),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  global.containerWidthFactor,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary,
                                                    ],
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.03),
                                                  boxShadow: [
                                                    global.darkShadow
                                                  ]),
                                              child: Text(
                                                '  ${(e as Text).data}  ',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .focusColor,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.03,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                            ),
                                          ],
                                        )
                                      : e.runtimeType == Exercise
                                          ? (exerciseRecommendations
                                                  .map(
                                                      (element) => element.name)
                                                  .contains(
                                                      (e as Exercise).name)
                                              ? BounceElement(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      exerciseRecommendations
                                                          .remove(e);
                                                      exercises.add(e);
                                                      setState(() {});
                                                    },
                                                    child: Opacity(
                                                      opacity: 0.7,
                                                      child:
                                                          RecommendedExerciseButton(
                                                        exercise: e,
                                                        sets: sets
                                                            .where((element) =>
                                                                element
                                                                    .exerciseName ==
                                                                e.name)
                                                            .toList(),
                                                        reload: () {
                                                          getData();
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : ExerciseButton(
                                                  exercise: e,
                                                  sets: sets
                                                      .where((element) =>
                                                          element
                                                              .exerciseName ==
                                                          e.name)
                                                      .toList(),
                                                  reload: () {
                                                    getData();
                                                  },
                                                ))
                                          : Container(),
                                )
                              : [
                                  Center(
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.1,
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      child: const CircularProgressIndicator(),
                                    ),
                                  )
                                ]),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width *
                              global.containerWidthFactor *
                              0.9,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: searchRecommendations.length > 11
                                ? 12
                                : searchRecommendations.length,
                            itemBuilder: (context, index) => ListTile(
                              title: Text(searchRecommendations[index].name,
                                  style: TextStyle(
                                      color: Theme.of(context).focusColor)),
                              shape: BorderDirectional(
                                  bottom: BorderSide(
                                      color: Theme.of(context).focusColor)),
                              tileColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              contentPadding: const EdgeInsets.all(10),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: AddEditSet(
                                        add: true,
                                        set: null,
                                        exerciseExists: exercises
                                            .map((e) => e.name)
                                            .contains(
                                                searchRecommendations[index]
                                                    .name),
                                        exerciseName:
                                            searchRecommendations[index].name),
                                    type: PageTransitionType.rightToLeft,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
