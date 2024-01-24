import 'package:flexify/pages/workout/exercisesPage/widgets/Heading.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flexify/pages/workout/exercisesPage/setsPage/widgets/ExerciseStats.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/pages/workout/exercisesPage/setsPage/addeditSetPage/addeditSetPage.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:collection/collection.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  List<List<Set>> setsByDate = [];
  List<Widget> setWidgets = [];
  bool loadingDone = false;

  getData() async {
    sets = (await Save.getSetList())
        .where((e) => e.exerciseName == widget.name)
        .toList();
    setsByDate = sets.isNotEmpty
        ? (groupBy(sets, (Set set) => dateString(set.date))
            .values
            .toList()
            .reversed
            .toList())
        : [];
    setWidgets = sets.isNotEmpty
        ? setsByDate.map((sets) => setWidgetsBySetList(sets)).flattened.toList()
        : [];
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

  List<Widget> setWidgetsBySetList(List<Set> setList) {
    List<Widget> returnList = [];

    if (setList.isEmpty) return returnList;

    returnList.add(
      Heading(
        title:
            'date: ${dateString(setList.first.date)}                       total sets: ${setList.length}',
      ),
    );

    for (int i = setList.length - 1; i >= 0; i--) {
      returnList.add(SizedBox(
        height: MediaQuery.of(context).size.width * 0.01,
      ));
      returnList.add(
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            PageTransition(
              child: AddEditSet(
                add: false,
                set: setList[i],
                exerciseName: widget.name,
              ),
              type: PageTransitionType.fade,
            ),
          ).then((value) => getData()),
          child: Container(
            padding: EdgeInsets.all(global.containerPadding - 10),
            width:
                MediaQuery.of(context).size.width * global.containerWidthFactor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(global.borderRadius - 5),
              color: Theme.of(context).colorScheme.background,
              boxShadow: [global.darkShadow],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // WEIGHT
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${setList[i].weight}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.009,
                      ),
                      child: Text(
                        'kg',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                // DATE
                Text(
                  '${zeroBefore(setList[i].date.hour)}:${zeroBefore(sets[i].date.minute)}',
                  style: TextStyle(
                    color: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.6),
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),

                //REPS
                Text(
                  'x${setList[i].reps}',
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      returnList.add(SizedBox(
        height: MediaQuery.of(context).size.width * 0.01,
      ));
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
    return PopScope(
      onPopInvoked: (foo) => widget.refresh(),
      child: Scaffold(
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * (1 - 0.88),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.005),
                    width: MediaQuery.of(context).size.width * 0.14,
                    height: MediaQuery.of(context).size.width * 0.14,
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
                      onPressed: () => Navigator.pop(context),
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
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.005),
                    width: MediaQuery.of(context).size.width * 0.14,
                    height: MediaQuery.of(context).size.width * 0.14,
                    decoration: BoxDecoration(
                      boxShadow: [global.lightShadow],
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
            sets.isNotEmpty
                ? ExerciseStats(
                    exerciseName: widget.name,
                    sets: sets,
                  )
                : Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.1,
                        ),
                        child: SvgPicture.asset(
                          'assets/Squiggly Arrow.svg',
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.width * 0.6,
                        ),
                      ),
                    ],
                  ),
            SizedBox(
              width: MediaQuery.of(context).size.width *
                  global.containerWidthFactor,
              child: Column(
                children: [
                  ...(loadingDone
                      ? (sets.isNotEmpty
                          ? setWidgets
                          : [
                              Center(
                                child: Text(
                                  'Click  \'+\'  to add a set!  :)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                  ),
                                ),
                              )
                            ])
                      : const [Center(child: CircularProgressIndicator())]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
