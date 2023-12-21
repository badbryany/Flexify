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
      Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            width:
                MediaQuery.of(context).size.width * global.containerWidthFactor,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.onPrimary,
                ],
              ),
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.03),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(133, 158, 158, 158),
                  spreadRadius: -10.0,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                )
              ],
            ),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                Text(
                  'date:   ${dateString(setList.first.date).toLowerCase()}',
                  style: TextStyle(
                    color: Theme.of(context).focusColor,
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Text(
                  'total sets:   ${setList.length}',
                  style: TextStyle(
                    color: Theme.of(context).focusColor,
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                )
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
        ],
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
                exerciseExists: true,
                set: setList[i],
                exerciseName: widget.name,
              ),
              type: PageTransitionType.fade,
            ),
          ).then((value) => getData()),
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
            width:
                MediaQuery.of(context).size.width * global.containerWidthFactor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.width * 0.03),
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(133, 211, 211, 211),
                  spreadRadius: -10.0,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // ICON
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/PR_previous.svg',
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.width * 0.1,
                    ),

                    const SizedBox(width: 30),

                    // WEIGHT + DATE
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${setList[i].weight}kg',
                          style: TextStyle(
                            color: Theme.of(context).focusColor,
                            fontSize: MediaQuery.of(context).size.width * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${dateString(setList[i].date)} at ${zeroBefore(setList[i].date.hour)}:${zeroBefore(sets[i].date.minute)}',
                          style: TextStyle(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.4),
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(),

                //REPS
                Text(
                  'x${setList[i].reps}',
                  style: TextStyle(
                    color: Theme.of(context).focusColor,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(),
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
                          exerciseExists: true,
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
                      child: SvgPicture.asset('assets/Squiggly Arrow.svg',
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.width * 0.6),
                    ),
                  ],
                ),
          SizedBox(
            width:
                MediaQuery.of(context).size.width * global.containerWidthFactor,
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
                                      MediaQuery.of(context).size.width * 0.04,
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
    );
  }
}
