import 'package:flexify/pages/workout/exercisesPage/setsPage/widgets/ExerciseTimer.dart';
import 'package:flexify/pages/workout/exercisesPage/widgets/Heading.dart';
import 'package:flexify/widgets/DeleteAlertDialog.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flexify/pages/workout/exercisesPage/setsPage/widgets/ExerciseStats.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/pages/workout/exercisesPage/setsPage/addeditSetPage/addeditSetPage.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:collection/collection.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
  bool loadingDone = false;
  TextEditingController editNameController = TextEditingController();

  String exerciseName = '...';

  bool thresholdReached = false;
  double thresholdProgress = 0.0;

  getData() async {
    sets = (await Save.getSetList())
        .where((e) => e.exerciseName == exerciseName)
        .toList();
    setsByDate = sets.isNotEmpty
        ? (groupBy(sets, (Set set) => dateString(set.date))
            .values
            .toList()
            .reversed
            .toList())
        : [];

    loadingDone = true;
    setState(() {});
  }

  setEditName() async {
    String oldName = exerciseName;
    editNameController.text = exerciseName;
    editNameController.addListener(() {
      exerciseName = editNameController.text;
      setState(() {});
    });
    await showDialog(
        context: context,
        builder: (context) => Theme(
              data: ThemeData(
                fontFamily: 'JosefinSans',
                brightness: Brightness.dark,
                colorScheme: ColorScheme(
                  brightness: Brightness.dark,
                  primary: Colors.transparent,
                  onPrimary: Theme.of(context).colorScheme.primary,
                  secondary: Colors.red,
                  onSecondary: Colors.red,
                  error: Colors.red,
                  onError: Colors.red,
                  background: Colors.green,
                  onBackground: Colors.transparent,
                  surface: Theme.of(context).colorScheme.background,
                  onSurface: Theme.of(context).focusColor,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              child: AlertDialog(
                backgroundColor: Theme.of(context).colorScheme.background,
                content: TextField(
                  autofocus: true,
                  controller: editNameController,
                  decoration: const InputDecoration(
                    hintText: 'Name of Exercise',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      editNameController.text = oldName;
                      Navigator.pop(context);
                    },
                    child: const Text('cancle'),
                  ),
                  TextButton(
                    onPressed: () async {
                      await Save.editExerciseName(
                        widget.name,
                        editNameController.text,
                      );
                      await getData();
                      Navigator.pop(context);
                    },
                    child: const Text('save'),
                  ),
                ],
              ),
            ));
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

  List<Widget> setWidgetsBySetList(List<Set> setList, BuildContext context) {
    List<Widget> returnList = [];

    if (setList.isEmpty) return [];

    for (int i = 0; i < setsByDate.length; i++) {
      setList = setsByDate[i];
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
          Dismissible(
            key: ValueKey(setList[i].setID),
            dismissThresholds: const {DismissDirection.endToStart: 0.7},
            direction: DismissDirection.horizontal,
            background: AnimatedContainer(
              key: const ValueKey(Alignment),
              duration: const Duration(milliseconds: 150),
              alignment: thresholdReached
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
              padding: thresholdReached
                  ? EdgeInsets.only(
                      left: max(
                          ((1 - thresholdProgress) *
                                  (global.containerWidthFactor) *
                                  MediaQuery.of(context).size.width) +
                              MediaQuery.of(context).size.width * 0.05,
                          (MediaQuery.of(context).size.width * 0.1)))
                  : EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.1),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error,
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width * 0.08),
              ),
              child: Text(
                'delete',
                style: TextStyle(
                  color: Theme.of(context).focusColor,
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                ),
              ),
            ),
            confirmDismiss: (diracion) async {
              bool returnValue = false;
              await showDialog(
                context: context,
                builder: (BuildContext context) => DeleteAlertDialog(
                  title: 'Do you want to delete this set?',
                  actions: [
                    TextButton(
                      onPressed: () {
                        returnValue = false;
                        Navigator.pop(context);
                      },
                      child: const Text('cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await Save.deleteSet(setList[i]);
                        await getData();
                        returnValue = true;
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      child: const Text('delete'),
                    ),
                  ],
                ),
              );
              return returnValue;
            },
            child: GestureDetector(
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
                width: MediaQuery.of(context).size.width *
                    global.containerWidthFactor,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(global.borderRadius - 5),
                  color: Theme.of(context).colorScheme.background,
                  boxShadow: [global.darkShadow(context)],
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
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // DATE
                    Text(
                      '${global.zeroBefore(setList[i].date.hour)}:${global.zeroBefore(sets[i].date.minute)}',
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.6),
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),

                    //REPS
                    Text(
                      'x${setList[i].reps}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: MediaQuery.of(context).size.width * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        returnList.add(SizedBox(
          height: MediaQuery.of(context).size.width * 0.01,
        ));
      }
    }

    return returnList;
  }

  @override
  void initState() {
    exerciseName = widget.name;
    super.initState();
    getData();
  }

  PageController pageController = PageController();
  CarouselController carouselController = CarouselController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pannels = [
      ExerciseStats(
        exerciseName: exerciseName,
        sets: sets,
      ),
      ExerciseTimer(
        sets: sets,
      ),
    ];

    return PopScope(
      onPopInvoked: (foo) => widget.refresh(),
      child: Scaffold(
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Container(
              height: MediaQuery.of(context).size.height * (1 - 0.88),
              margin: const EdgeInsets.only(left: 10, right: 10),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.005),
                    width: MediaQuery.of(context).size.width * 0.14,
                    height: MediaQuery.of(context).size.width * 0.14,
                    decoration: BoxDecoration(
                      boxShadow: ([global.darkShadow(context)]),
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: IconButton(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () => Navigator.pop(context),
                      color: Theme.of(context).colorScheme.onBackground,
                      icon: const Icon(Icons.arrow_back_rounded),
                      iconSize: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                  GestureDetector(
                    onTap: setEditName,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Text(
                        exerciseName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).focusColor,
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
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
                      boxShadow: [global.darkShadow(context)],
                      color: Theme.of(context).colorScheme.background,
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
                      color: Theme.of(context).colorScheme.onBackground,
                      icon: const Icon(Icons.add),
                      iconSize: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width *
                  global.containerWidthFactor,
              child: Column(
                children: [
                  ...(loadingDone
                      ? (sets.isNotEmpty
                          ? [
                              CarouselSlider(
                                items: pannels,
                                carouselController: carouselController,
                                options: CarouselOptions(
                                  onPageChanged: (index, reason) =>
                                      setState(() => pageIndex = index),
                                  viewportFraction: 1,
                                  height: global.height(context) * .5,
                                  enlargeCenterPage: true,
                                  enlargeFactor: .25,
                                  initialPage: pageIndex,
                                  padEnds: true,
                                  enableInfiniteScroll: false,
                                  scrollPhysics: const BouncingScrollPhysics(),
                                ),
                              ),
                              AnimatedSmoothIndicator(
                                count: pannels.length,
                                activeIndex: pageIndex,
                                onDotClicked: (int index) =>
                                    carouselController.animateToPage(
                                  index,
                                  duration: global.standardAnimationDuration,
                                ),
                                effect: WormEffect(
                                  dotColor:
                                      Theme.of(context).colorScheme.background,
                                  activeDotColor:
                                      Theme.of(context).colorScheme.primary,
                                  spacing: 5,
                                  dotHeight: global.width(context) * .025,
                                  dotWidth: global.width(context) * .025,
                                  type: WormType.thin,
                                ),
                              ),
                              SizedBox(height: global.height(context) * .005),
                              ...setWidgetsBySetList(sets, context),
                            ]
                          : [
                              Padding(
                                padding: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.1,
                                ),
                                child: SvgPicture.asset(
                                  'assets/Squiggly Arrow.svg',
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.width * 0.6,
                                  color: Theme.of(context).focusColor,
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Click  \'+\'  to add a set!  :)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04,
                                    color: Theme.of(context).focusColor,
                                  ),
                                ),
                              )
                            ])
                      : [
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.3),
                            child: const CircularProgressIndicator(),
                          )
                        ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
