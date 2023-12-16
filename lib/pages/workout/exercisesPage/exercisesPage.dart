import 'package:flexify/pages/workout/exercisesPage/widgets/exerciseButton.dart';
import 'package:flexify/widgets/SearchBar.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/data/dummyExercises.dart' as dummyExercises;
import 'package:flexify/data/globalVariables.dart' as global;

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
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * (1 - 0.88),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      alignment: Alignment.center,
                      width: _searchBarOpen == 1
                          ? 0
                          : MediaQuery.of(context).size.width * 0.33,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: ListView(
                        clipBehavior: Clip.none,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4.3),
                            decoration: BoxDecoration(
                              boxShadow: ([
                                BoxShadow(
                                  color: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.25),
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.108,
                          ),
                          Center(
                            child: Text(
                              'Workout',
                              style: TextStyle(
                                color: Theme.of(context).focusColor,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -1,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimSearchBar(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      helpText: 'Add exercise to workout',
                      width: MediaQuery.of(context).size.width *
                          global.containerWidthFactor,
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
                        ListView.builder(
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
                            onTap: () {},
                          ),
                        )
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
