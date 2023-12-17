import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flexify/pages/workout/exercisesPage/setsPage/widgets/ExerciseStats.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/pages/workout/exercisesPage/setsPage/addeditSetPage/addeditSetPage.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class ExerciseSets extends StatefulWidget {
  const ExerciseSets({
    super.key,
    required this.name,
    required this.refresh,
  });

  final String name;
  final Function refresh;

  @override
  State<ExerciseSets> createState() => _ExerciseSetsState();
}

class _ExerciseSetsState extends State<ExerciseSets> {
  List<Set> sets = [];
  bool loadingDone = false;
  getData() async {
    sets = (await Save.getSetList())
        .where((e) => e.exerciseName == widget.name)
        .toList();

    loadingDone = true;
    setState(() {});
  }

  String zeroBefore(int num) {
    if (num <= 9) {
      return '0$num';
    }
    return '$num';
  }

  String dateString(DateTime date) {
    String month = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ][date.month - 1];

    return '$month ${date.day}';
  }

  List<Widget> setList() {
    List<Widget> returnList = [];

    if (sets.isEmpty) return returnList;

    DateTime currentDate = sets.last.date;

    for (int i = sets.length - 1; i >= 0; i--) {
      if (currentDate.difference(sets[i].date).abs() >
          const Duration(hours: 1, minutes: 45)) {
        returnList.add(const SizedBox(height: 40));
      }

      returnList.add(
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            PageTransition(
              child: AddEditSet(
                add: false,
                doublePop: false,
                set: sets[i],
                exerciseName: widget.name,
              ),
              type: PageTransitionType.fade,
            ),
          ).then((value) => getData()),
          child: Container(
            padding: const EdgeInsets.all(10),
            width:
                MediaQuery.of(context).size.width * global.containerWidthFactor,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [global.lightShadow],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ICON
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        Icons.fitness_center_rounded,
                        color: Theme.of(context).focusColor,
                        size: 40,
                      ),
                    ),

                    const SizedBox(width: 30),

                    // WEIGHT + DATE
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${sets[i].weight}kg',
                          style: TextStyle(
                            color: Theme.of(context).focusColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${dateString(sets[i].date)} at ${zeroBefore(sets[i].date.hour)}:${zeroBefore(sets[i].date.minute)}',
                          style: TextStyle(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(),

                //REPS
                Text(
                  'x${sets[i].reps}',
                  style: TextStyle(
                    color: Theme.of(context).focusColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(),
              ],
            ),
          ),
        ),
      );
      currentDate = sets[i].date;
    }
    return returnList;
  }

  @override
  void initState() {
    super.initState();
    for (int i = 5; i < 100; i++) {
      Save.deleteExercise(Exercise(
          name: '$i', type: '$i', affectedMuscle: '$i', equipment: '$i'));
    }
    Save.saveExercise(Exercise(
        name: 'Barbell Squat',
        type: 'Barbell',
        affectedMuscle: 'Quads',
        equipment: 'Barbell'));
    Save.saveExercise(Exercise(
        name: 'Deadlift',
        type: 'Barbell',
        affectedMuscle: 'Quads',
        equipment: 'Barbell'));
    Save.saveExercise(Exercise(
        name: 'Squat',
        type: 'Barbell',
        affectedMuscle: 'Quads',
        equipment: 'Barbell'));
    Save.saveExercise(Exercise(
        name: 'Push-Ups',
        type: 'Barbell',
        affectedMuscle: 'Quads',
        equipment: 'Barbell'));
    Save.saveExercise(Exercise(
        name: 'Pullups',
        type: 'Barbell',
        affectedMuscle: 'Quads',
        equipment: 'Barbell'));
    Save.saveExercise(Exercise(
        name: 'Single Leg Calf Raises',
        type: 'Barbell',
        affectedMuscle: 'Quads',
        equipment: 'Barbell'));
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * (1 - 0.88),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.005),
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
                      widget.refresh();
                      Navigator.pop(context);
                    },
                    color: Theme.of(context).focusColor,
                    icon: const Icon(Icons.arrow_back_rounded),
                    iconSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.01,
                    right: MediaQuery.of(context).size.width * 0.01,
                  ),
                  child: Text(
                    widget.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).focusColor,
                        fontSize: MediaQuery.of(context).size.width * 0.05),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.005),
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
                    onPressed: () => Navigator.push(
                        context,
                        PageTransition(
                          child: AddEditSet(
                            add: true,
                            set: null,
                            doublePop: false,
                            exerciseName: widget.name,
                          ),
                          type: PageTransitionType.fade,
                        ),
                      ).then((value) => getData()),
                    color: Theme.of(context).focusColor,
                    icon: const Icon(Icons.add),
                    iconSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                ),
              ],
            ),
          ),
          ExerciseStats(
            exerciseName: widget.name,
            sets: sets,
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.075,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'All sets',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(),
                const SizedBox(),
                const SizedBox(),
                const SizedBox(),
                Text(
                  'total: ${sets.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(),
              ],
            ),
          ),
          SizedBox(
            width:
                MediaQuery.of(context).size.width * global.containerWidthFactor,
            child: Column(
              children: [
                ...(loadingDone
                    ? setList()
                    : [
                        Center(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width * 0.1,
                            width: MediaQuery.of(context).size.width *
                                global.containerWidthFactor,
                            child: const CircularProgressIndicator(),
                          ),
                        )
                      ]),
                loadingDone && sets.isEmpty
                    ? Column(
                        children: [
                          ...[0, 0, 0].map(
                            (e) => Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              width: MediaQuery.of(context).size.width *
                                  global.containerWidthFactor,
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
