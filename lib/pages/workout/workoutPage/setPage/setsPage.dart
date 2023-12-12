import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flexify/pages/workout/workoutPage/setPage/addSetPage/addSetPage.dart';
import 'package:flexify/pages/workout/workoutPage/setPage/editSetPage/editSetPage.dart';
import '../../../../data/exerciseModels.dart';

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
    sets = [];
    List<String> savedSets = await Save.setSetIfNull();

    // add sets from the back to sets -> the newest sets are at the top
    for (int i = savedSets.length - 1; i >= 0; i--) {
      Set tmpSet = Set.fromStringToObject(savedSets[i]);
      if (tmpSet.exerciseName == widget.name) {
        sets.add(tmpSet);
      }
    }
    loadingDone = true;
    setState(() {});
  }

  String zeroBefore(int num) {
    if (num <= 9) {
      return '0$num';
    }
    return '$num';
  }

  List<Widget> setList(List<Color> colors) {
    List<Widget> returnList = [];
    TextStyle textStyle = TextStyle(
      color: Theme.of(context).focusColor,
    );

    returnList.add(
      const Padding(
        padding: EdgeInsets.only(top: 0, bottom: 10),
        child: Text(
          'last Workout',
        ),
      ),
    );

    DateTime? firstDate;

    for (int i = 0; i < sets.length; i++) {
      firstDate ??= sets[i].date;
      if (firstDate.difference(sets[i].date) >= const Duration(hours: 12)) {
        returnList.add(
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 10),
            child: Text(
              'Workout of the ${zeroBefore(firstDate.day)}.${zeroBefore(firstDate.month)}',
            ),
          ),
        );
        firstDate = null;
      }

      returnList.add(
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            PageTransition(
              child: EditSet(set: sets[i]),
              type: PageTransitionType.fade,
            ),
          ).then((value) => getData()),
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: colors[i % colors.length],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('${sets[i].reps} reps', style: textStyle),
                Text('${sets[i].weight} kg', style: textStyle),
                Text(
                    '${zeroBefore(sets[i].date.hour)}:${zeroBefore(sets[i].date.minute)}',
                    style: textStyle),
              ],
            ),
          ),
        ),
      );
    }
    return returnList;
  }

  @override
  void initState() {
    super.initState();
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
            height: MediaQuery.of(context).size.height * 0.1,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Theme.of(context).focusColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        content: const Text('Are you sure?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              await Save.deleteExercise(
                                  Exercise(name: widget.name));
                              widget.refresh();
                              Navigator.pop(context);
                            },
                            child: const Text('delete'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.delete_outlined,
                    color: Theme.of(context).focusColor,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    PageTransition(
                      child: AddSet(exerciseName: widget.name),
                      type: PageTransitionType.bottomToTop,
                    ),
                  ).then((value) => getData()),
                  icon: Icon(
                    Icons.add_rounded,
                    color: Theme.of(context).focusColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.2,
            alignment: Alignment.center,
            child: Text(
              widget.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).focusColor,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * (1 - 0.2 - 0.1),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                ...(loadingDone
                    ? setList([
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.onPrimary,
                      ])
                    : [
                        Center(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width * 0.1,
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: const CircularProgressIndicator(),
                          ),
                        )
                      ]),
                loadingDone && sets.isEmpty
                    ? Text(
                        'no sets',
                        style: TextStyle(
                          color: Theme.of(context).focusColor,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
