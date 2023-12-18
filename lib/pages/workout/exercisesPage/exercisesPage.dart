import 'package:flexify/pages/workout/exercisesPage/setsPage/addeditSetPage/addeditSetPage.dart';
import 'package:flexify/pages/workout/exercisesPage/widgets/exerciseButton.dart';
import 'package:flexify/widgets/SearchBar.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/data/dummyExercises.dart' as dummyExercises;
import 'package:flexify/data/globalVariables.dart' as global;
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
  List<Exercise> searchRecommendations = List.from(dummyExercises.gymExercises);
  List<Set> sets = [];
  bool loadingDone = false;
  int _searchBarOpen = 0;
  TextEditingController _controller = TextEditingController();

  getData() async {
    loadingDone = false;
    setState(() {});

    exercises = await Save.getExersiseList();
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

  Duration duration = const Duration(milliseconds: 300);

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
                height: MediaQuery.of(context).size.height * (1 - 0.88),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Visibility(
                      visible: _searchBarOpen == 0,
                      child: AnimatedContainer(
                        duration: duration,
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
                      duration: duration,
                      width: MediaQuery.of(context).size.width *
                          0.4 *
                          (_searchBarOpen == 0 ? 1 : 0),
                      padding: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: AnimatedOpacity(
                        duration: duration,
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
                    AnimSearchBar(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      helpText: 'Add exercise',
                      width: MediaQuery.of(context).size.width *
                          global.containerWidthFactor *
                          0.9,
                      textController: _controller,
                      suffixIcon: const Icon(Icons.clear),
                      onSuffixTap: () {
                        _controller.clear();
                      },
                      onSubmitted: (foo) {},
                      onToggle: (int open) {
                        setState(() => _searchBarOpen = open);
                      },
                      closeSearchOnSuffixTap: true,
                      autoFocus: true,
                    ),
                  ],
                ),
              ),
              _searchBarOpen == 0
                  ? AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      child: Column(
                        children: [
                          ...(loadingDone
                              ? exercises.map(
                                  (e) => ExerciseButton(
                                      exercise: e,
                                      sets: sets
                                          .where((element) =>
                                              element.exerciseName == e.name)
                                          .toList(),
                                      reload: () {
                                        getData();
                                      }),
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
                              contentPadding: EdgeInsets.all(10),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    child: AddEditSet(
                                        add: true,
                                        set: null,
                                        doublePop: true,
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
