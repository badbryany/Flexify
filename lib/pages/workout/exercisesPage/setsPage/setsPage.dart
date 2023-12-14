import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flexify/pages/workout/exercisesPage/setsPage/ExerciseStats.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/pages/workout/exercisesPage/setsPage/add_editSetPage/addSetPage.dart';
import 'package:flexify/pages/workout/exercisesPage/setsPage/add_editSetPage/editSetPage.dart';

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
    sets = (await Save.setSetIfNull())
        .map((e) => Set.fromStringToObject(e))
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
              child: EditSet(set: sets[i]),
              type: PageTransitionType.fade,
            ),
          ).then((value) => getData()),
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.surface,
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
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.fitness_center_rounded,
                        color: Theme.of(context).focusColor,
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
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            height: MediaQuery.of(context).size.height * 0.1,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Theme.of(context).focusColor,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    PageTransition(
                      child: AddSet(
                        exerciseName: widget.name,
                      ),
                      type: PageTransitionType.bottomToTop,
                    ),
                  ).then((value) => getData()),
                  child: Text(
                    'add',
                    style: TextStyle(
                      color: Theme.of(context).focusColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: ExerciseStats(
              exerciseName: widget.name,
              sets: sets,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.075,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All sets',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(),
              ],
            ),
          ),
          Column(
            children: [
              ...(loadingDone
                  ? setList()
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
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
