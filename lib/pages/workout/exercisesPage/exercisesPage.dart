import 'dart:convert';
import 'dart:async';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/pages/workout/exercisesPage/widgets/exerciseButton.dart';
import 'package:flexify/widgets/SearchBar.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

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

  List<dynamic> searchExercises = [];

  List<Set> sets = [];

  bool loadingDone = false;
  bool connectedToInternet = true;
  int _searchBarOpen = 0;
  Duration loadingSpeed = Duration.zero;

  StreamSubscription<http.Response>? searchStream;

  String previosSearchText = '';

  final TextEditingController _controller = TextEditingController();

  List<List<Set>> exerciseSets = [];

  bool initialLoad = true;

  getData() async {
    loadingDone = false;
    setState(() {});

    exercises = await Save.getExerciseList();
    sets = await Save.getSetList();

    loadingDone = true;
    setState(() {});

    exerciseSets = List.generate(
        exercises.length,
        (index) => [
              Set(
                date: DateTime.now(),
                exerciseName: '',
                reps: 0,
                weight: 0,
                setID: -10,
              )
            ]);
    for (int i = 0; i < exercises.length; i++) {
      if (initialLoad) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
      exerciseSets[i] = sets
          .where((element) => element.exerciseName == exercises[i].name)
          .toList();
      setState(() {});
    }
    initialLoad = false;
  }

  bool exerciseExistsAlready(Exercise newExercise) {
    for (int i = 0; i < exercises.length; i++) {
      if (exercises[i].name == newExercise.name) {
        return true;
      }
    }
    return false;
  }

  searchForExercises() async {
    loadingDone = false;
    setState(() {});

    ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      loadingDone = true;
      connectedToInternet = false;
      setState(() {});
      return;
    }

    String url = '${global.host}/searchExercises';
    String searchString = _controller.text;

    if (searchStream != null) {
      searchStream!.cancel();
    }

    DateTime start = DateTime.now();

    searchStream = http
        .get(Uri.parse('$url?q=$searchString'))
        .asStream()
        .listen((http.Response res) {
      loadingSpeed = DateTime.now().difference(start);

      List<dynamic> stringExercises = jsonDecode(res.body);

      searchExercises = [];
      for (int i = 0; i < stringExercises.length; i++) {
        dynamic e = stringExercises[i];
        Exercise exercise = Exercise(
          name: e[0],
          type: e[2],
          affectedMuscle: e[1],
          equipment: e[3],
        );

        searchExercises.add({
          'new': false,
          'added': exerciseExistsAlready(exercise),
          'exercise': exercise,
        });
      }

      if (searchExercises.isEmpty) {
        searchExercises.add({
          'new': true,
          'added': false,
          'exercise': Exercise(
            name: searchString,
            type: '',
            affectedMuscle: '',
            equipment: '',
          ),
        });
      }
      loadingDone = true;
      setState(() {});
    });
  }

  List<Widget> exerciseWidgets() {
    if (exerciseSets.length != exercises.length) {
      exerciseSets = List.generate(
          exercises.length,
          (index) => [
                Set(
                  date: DateTime.now(),
                  exerciseName: '',
                  reps: 0,
                  weight: 0,
                  setID: -10,
                )
              ]);
    }
    List<Widget> returnList = [];

    /* exercises.sort((a, b) {
      var aSets =
          sets.where((element) => element.exerciseName == a.name).toList();
      double foo = 0;
      if (aSets.isNotEmpty) {
        foo = aSets.last.date.difference(DateTime.now()).inHours.abs() / 72;
      }

      var bSets =
          sets.where((element) => element.exerciseName == b.name).toList();
      double bar = 0;
      if (bSets.isNotEmpty) {
        bar = bSets.last.date.difference(DateTime.now()).inHours.abs() / 72;
      }
      return (bar * 100).round() - (foo * 100).round();
    }); */

    for (int i = 0; i < exercises.length; i++) {
      returnList.add(
        ExerciseButton(
          exercise: exercises[i],
          reload: getData,
          sets: exerciseSets[i],
        ),
      );
    }

    return returnList;
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.text != previosSearchText) {
        previosSearchText = _controller.text;
        searchForExercises();
      }
    });
    getData();
  }

  @override
  Widget build(BuildContext context) {
    Widget animSearchBar = AnimSearchBar(
      color: Theme.of(context).colorScheme.background,
      prefixIconColor: Theme.of(context).colorScheme.onBackground,
      hintTextColor: Theme.of(context).focusColor.withOpacity(0.6),
      textFieldColor: Theme.of(context).scaffoldBackgroundColor,
      textColor: Theme.of(context).focusColor,
      helpText: 'Add exercise',
      width: MediaQuery.of(context).size.width *
          global.containerWidthFactor *
          0.95,
      textController: _controller,
      suffixIcon: Icon(
        Icons.clear,
        color: Theme.of(context).focusColor,
      ),
      open: _searchBarOpen == 1,
      onSuffixTap: () async {
        await getData();
        _controller.clear();
      },
      onToggle: (int open) {
        setState(() => _searchBarOpen = open);
        if (open == 1) {
          searchForExercises();
        }
      },
      closeSearchOnSuffixTap: true,
      autoFocus: true,
    );

    return Scaffold(
      body: SafeArea(
        child: PopScope(
          canPop: _searchBarOpen == 0,
          onPopInvoked: (foo) {
            if (!foo) {
              _searchBarOpen = 0;
              setState(() {});
            }
          },
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
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [global.darkShadow(context)],
                          ),
                          child: IconButton(
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              widget.reload();
                              Navigator.pop(context);
                            },
                            color: Theme.of(context).colorScheme.onBackground,
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
                        child: AnimatedOpacity(
                          duration: global.standardAnimationDuration,
                          opacity: _searchBarOpen == 0 ? 1 : 0,
                          child: Text(
                            'Workout',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).focusColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -1,
                              fontSize: global.width(context) * 0.1,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(7.5),
                        child: animSearchBar,
                      ),
                    ],
                  ),
                ),
                _searchBarOpen == 0
                    ? Column(
                        key: ValueKey(_searchBarOpen),
                        children: [
                          ...(exercises.isEmpty
                              ? [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                        ),
                                        child: SvgPicture.asset(
                                          'assets/Squiggly Arrow.svg',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: Text(
                                      'Click  \'+\'  to add an exercise!  :)',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04,
                                        color: Theme.of(context).focusColor,
                                      ),
                                    ),
                                  )
                                ]
                              : exerciseWidgets()),
                        ],
                      )
                    : Column(
                        key: ValueKey(_searchBarOpen),
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width *
                                global.containerWidthFactor,
                            height: MediaQuery.of(context).size.height *
                                (!loadingDone ? 0.1 : 0.845),
                            child: !loadingDone
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : !connectedToInternet
                                    ? const Center(child: Text('no connection'))
                                    : Scrollbar(
                                        radius: const Radius.circular(100),
                                        child: ListView(
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          children: [
                                            Text(
                                              '${searchExercises.length} Ergebnisse (0.${loadingSpeed.inMilliseconds.toString().substring(1)[0]} Sekunden)',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .focusColor
                                                    .withOpacity(0.3),
                                              ),
                                            ),
                                            ...searchExercises
                                                .map((e) => BounceElement(
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          Save.saveExercise(
                                                              e['exercise']);
                                                          e['added'] = true;
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .all(global
                                                                  .containerPadding),
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(7.5),
                                                          decoration:
                                                              BoxDecoration(
                                                            boxShadow: [
                                                              global.darkShadow(
                                                                  context)
                                                            ],
                                                            borderRadius: BorderRadius
                                                                .circular(global
                                                                    .borderRadius),
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .background,
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  SizedBox(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.65,
                                                                    child: Text(
                                                                      e['exercise']
                                                                          .name,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .onBackground,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            MediaQuery.of(context).size.width *
                                                                                0.045,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  AnimatedSwitcher(
                                                                    duration: global
                                                                        .standardAnimationDuration,
                                                                    transitionBuilder:
                                                                        (child, animation) =>
                                                                            RotationTransition(
                                                                      turns:
                                                                          animation,
                                                                      child:
                                                                          child,
                                                                    ),
                                                                    key: ValueKey(
                                                                        '${e['added']}${e['exercise'].name}'),
                                                                    child: e[
                                                                            'added']
                                                                        ? Icon(
                                                                            Icons.check_rounded,
                                                                            color:
                                                                                Theme.of(context).colorScheme.primary,
                                                                          )
                                                                        : Icon(
                                                                            Icons.add_rounded,
                                                                            color:
                                                                                Theme.of(context).colorScheme.onBackground,
                                                                          ),
                                                                  ),
                                                                ],
                                                              ),
                                                              e['new']
                                                                  ? Text(
                                                                      'create this exercise',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .onBackground,
                                                                      ),
                                                                    )
                                                                  : const SizedBox(),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ))
                                                .toList()
                                          ],
                                        ),
                                      ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
