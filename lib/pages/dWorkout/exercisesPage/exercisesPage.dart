import 'dart:convert';
import 'dart:async';
import 'package:flexify/pages/dWorkout/exercisesPage/createNewExercisePage.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/pages/dWorkout/exercisesPage/widgets/exerciseButton.dart';
import 'package:flexify/widgets/SearchBar.dart';
import 'package:flutter/cupertino.dart';
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

    List<ConnectivityResult> connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      loadingDone = true;
      connectedToInternet = false;
      setState(() {});
      return;
    }
    connectedToInternet = true;

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
      textFieldColor: Theme.of(context).colorScheme.background,
      textColor: Colors.white,
      helpText: 'Add exercise',
      width: global.width(context) * global.containerWidthFactor * 0.95,
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
            height: global.height(context),
            width: global.width(context),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  width: global.width(context),
                  height: global.height(context) * (1 - 0.88),
                  padding: _searchBarOpen == 1
                      ? EdgeInsets.only(
                          right: global.width(context) * 0.04,
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
                          padding:
                              EdgeInsets.all(global.width(context) * 0.005),
                          width: global.width(context) * 0.15,
                          height: global.width(context) * 0.15,
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
                            iconSize: global.width(context) * 0.05,
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: global.standardAnimationDuration,
                        width: global.width(context) *
                            0.4 *
                            (_searchBarOpen == 0 ? 1 : 0),
                        child: AnimatedOpacity(
                          duration: global.standardAnimationDuration,
                          opacity: _searchBarOpen == 0 ? 1 : 0,
                          child: Text(
                            'All exercises',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                              color: Theme.of(context).focusColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -1,
                              fontSize: global.width(context) * .075,
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
                                          color: Theme.of(context).focusColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Center(
                                    child: Text(
                                      'Click  \'+\'  to add an exercise!  :)',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: global.width(context) * 0.04,
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
                            width: global.width(context) *
                                global.containerWidthFactor,
                            height: global.height(context) *
                                (!loadingDone ? 0.1 : 0.845),
                            child: !loadingDone
                                ? const Center(
                                    child: CupertinoActivityIndicator(),
                                  )
                                : !connectedToInternet
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              height: global.height(context) *
                                                  .075),
                                          Icon(
                                            CupertinoIcons.wifi_exclamationmark,
                                            size: global.width(context) * .125,
                                          ),
                                          global.smallHeight(context),
                                          Text(
                                            'no connection',
                                            style: TextStyle(
                                              fontSize:
                                                  global.width(context) * .04,
                                            ),
                                          ),
                                        ],
                                      )
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
                                                        onTap: () {
                                                          e['new']
                                                              ? Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder: (context) => CreateNewExercise(
                                                                        exercise: e[
                                                                            'exercise'],
                                                                        reload:
                                                                            getData),
                                                                  ),
                                                                )
                                                              : Save.saveExercise(
                                                                  e['exercise']);
                                                          getData();
                                                          setState(() =>
                                                              _searchBarOpen =
                                                                  0);
                                                          _controller.text = '';
                                                          FocusScope.of(context)
                                                              .unfocus();
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
                                                                          global.width(context) *
                                                                              0.045,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Icon(
                                                                  CupertinoIcons
                                                                      .add,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .onBackground,
                                                                  size: global
                                                                          .width(context) *
                                                                      .06,
                                                                )
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
