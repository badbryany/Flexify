import 'dart:convert';
import 'dart:async';
import 'package:flexify/pages/dWorkout/exercisesPage/createNewExercisePage.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/pages/dWorkout/exercisesPage/widgets/exerciseButton.dart';
import 'package:flexify/widgets/AnimatedSearchBar.dart';
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
  bool searchBarOpen = false;
  Duration loadingSpeed = Duration.zero;

  StreamSubscription<http.Response>? searchStream;

  ScrollController scrollController = ScrollController();

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
                isBodyweight: false,
                isDuration: false,
                durationInSeconds: 0,
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

  toggleSearchBar() {
    searchBarOpen = !searchBarOpen;

    for (var i = 0; i < searchExercises.length; i++) {
      searchExercises[i]['added'] = exerciseExistsAlready(
        (searchExercises[i]['exercise'] as Exercise),
      );
    }
    setState(() {});
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

      loadingSpeed = DateTime.now().difference(start);
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
                  isBodyweight: false,
                  isDuration: false,
                  durationInSeconds: 0,
                )
              ]);
    }
    List<Widget> returnList = [];

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
    searchForExercises();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    // loadingDone = false;
    return Scaffold(
      body: SafeArea(
        child: PopScope(
          canPop: !searchBarOpen,
          onPopInvoked: (foo) {
            if (!foo) {
              toggleSearchBar();
            }
          },
          child: SizedBox(
            height: global.height(context),
            width: global.width(context),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.all(global.height(context) * .025),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: global.width(context) * .66,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AnimatedOpacity(
                              duration: global.standardAnimationDuration,
                              opacity: searchBarOpen ? 0 : 1,
                              child: BounceElement(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(
                                      global.height(context) * 0.0025),
                                  width: global.width(context) * 0.15,
                                  height: global.width(context) * 0.15,
                                  decoration: BoxDecoration(
                                    color: global.darkGrey,
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: global.shadow(context),
                                  ),
                                  child: Icon(
                                    Icons.arrow_back_rounded,
                                    size: global.width(context) * 0.05,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            AnimatedOpacity(
                              duration: global.standardAnimationDuration,
                              opacity: searchBarOpen ? 0 : 1,
                              child: Text(
                                'All Exercises',
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
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        right: 0,
                        child: Center(
                          child: AnimatedContainer(
                            curve: Curves.easeInOut,
                            duration: global.standardAnimationDuration,
                            width: searchBarOpen
                                ? global.width(context) * .895
                                : global.width(context) * .15,
                            child: AnimatedSearchBar(
                              isOpen: searchBarOpen,
                              radius: global.width(context) * 0.075,
                              hintText: 'Search (eg. "Bench Pre...")',
                              searchBarWidth: Tuple(
                                global.containerWidth(context) -
                                    global.width(context) * .1,
                                global.width(context) * 0.15,
                              ),
                              backgroundColor: global.darkGrey,
                              searchController: _controller,
                              duration: const Duration(milliseconds: 0),
                              iconSize: global.width(context) * 0.055,
                              onTap: toggleSearchBar,
                              openIcon: Icons.close,
                              closedIcon: Icons.add,
                              fadeDuration: global.standardAnimationDuration,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                !searchBarOpen
                    ? Column(
                        key: ValueKey(searchBarOpen),
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
                        key: ValueKey(searchBarOpen),
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
                                            'No Connection',
                                            style: TextStyle(
                                              fontSize:
                                                  global.width(context) * .04,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Scrollbar(
                                        radius: const Radius.circular(100),
                                        controller: scrollController,
                                        child: ListView(
                                          controller: scrollController,
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          children: [
                                            Text(
                                              'loaded ${searchExercises.length} exercise(s) (0.${loadingSpeed != Duration.zero ? loadingSpeed.inMilliseconds.toString().substring(1)[0] : '0'} Sekunden)',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .focusColor
                                                    .withOpacity(0.3),
                                              ),
                                            ),
                                            ...searchExercises.map(
                                              (e) => BounceElement(
                                                onTap: () {
                                                  if (e['new']) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            CreateNewExercise(
                                                                exercise: e[
                                                                    'exercise'],
                                                                reload:
                                                                    getData),
                                                      ),
                                                    );
                                                  } else {
                                                    Save.saveExercise(
                                                      e['exercise'],
                                                    );
                                                    setState(() =>
                                                        e['added'] = true);
                                                    toggleSearchBar();
                                                  }
                                                  getData();
                                                  _controller.text = '';
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(
                                                      global.containerPadding),
                                                  margin:
                                                      const EdgeInsets.all(7.5),
                                                  decoration: BoxDecoration(
                                                    border: e['added']
                                                        ? Border.all(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary,
                                                            width: 1,
                                                          )
                                                        : null,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            global
                                                                .borderRadius),
                                                    color: Theme.of(context)
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
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.65,
                                                            child: Text(
                                                              e['exercise']
                                                                  .name,
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onBackground,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: global
                                                                        .width(
                                                                            context) *
                                                                    0.045,
                                                              ),
                                                            ),
                                                          ),
                                                          Icon(
                                                            e['added']
                                                                ? CupertinoIcons
                                                                    .check_mark
                                                                : CupertinoIcons
                                                                    .add,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onBackground,
                                                            size: global.width(
                                                                    context) *
                                                                .06,
                                                          )
                                                        ],
                                                      ),
                                                      e['new']
                                                          ? Text(
                                                              'create this exercise',
                                                              style: TextStyle(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .onBackground,
                                                              ),
                                                            )
                                                          : const SizedBox(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
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
