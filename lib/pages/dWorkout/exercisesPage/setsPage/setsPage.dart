import 'package:flexify/pages/dWorkout/exercisesPage/setsPage/widgets/ExerciseTimer.dart';
import 'package:flexify/pages/dWorkout/exercisesPage/widgets/Heading.dart';
import 'package:flexify/widgets/DeleteAlertDialog.dart';
import 'package:flexify/widgets/Navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/pages/dWorkout/exercisesPage/setsPage/widgets/ExerciseStats.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/pages/dWorkout/exercisesPage/setsPage/addeditSetPage/addeditSetPage.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:collection/collection.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                fontFamily: 'KronaOne',
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
                    hintText: 'Name of exercise',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      editNameController.text = oldName;
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
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
                    child: const Text('Save'),
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
              'Date:  ${dateString(setList.first.date)}                     Total Sets:  ${setList.length}',
        ),
      );

      for (int i = setList.length - 1; i >= 0; i--) {
        returnList.add(SizedBox(
          height: global.width(context) * 0.01,
        ));

        returnList.add(
          Dismissible(
            key: ValueKey(setList[i].setID),
            dismissThresholds: const {DismissDirection.endToStart: 0.7},
            direction: DismissDirection.horizontal,
            background: AnimatedContainer(
                key: const ValueKey(Alignment),
                duration: const Duration(milliseconds: 150),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: global.width(context) * 0.1),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  CupertinoIcons.trash,
                  color: Colors.white,
                  size: global.height(context) * .02,
                )),
            confirmDismiss: (diracion) async {
              bool returnValue = false;
              await showDialog(
                context: context,
                builder: (BuildContext context) => DeleteAlertDialog(
                  title: 'Delete this Set?',
                  actions: [
                    TextButton(
                      onPressed: () {
                        returnValue = false;
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        await Save.deleteSet(setList[i]);
                        await getData();
                        returnValue = true;
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
              return returnValue;
            },
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditSet(
                    add: false,
                    set: setList[i],
                    exerciseName: widget.name,
                  ),
                ),
              ).then((value) => getData()),
              child: Container(
                padding: EdgeInsets.all(global.containerPadding - 10),
                width: global.width(context) * global.containerWidthFactor,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(global.borderRadius - 5),
                  color: global.darkGrey,
                  boxShadow: [global.darkShadow(context)],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // WEIGHT
                    Column(
                      children: [
                        setList[i].isBodyweight
                            ? const Text('Bodyweight + ')
                            : const SizedBox(),
                        global.gradient(
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${setList[i].weight}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: global.width(context) * 0.08,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: global.height(context) * 0.009,
                                ),
                                child: Text(
                                  'kg',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: global.width(context) * 0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // DATE
                    Container(
                      alignment: Alignment.center,
                      width: global.width(context) * .33,
                      child: Text(
                        '${global.zeroBefore(setList[i].date.hour)}:${global.zeroBefore(sets[i].date.minute)}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.6),
                          fontSize: global.width(context) * 0.04,
                        ),
                      ),
                    ),

                    //REPS
                    SizedBox(
                      width: global.width(context) * .19,
                      child: sets[i].isDuration
                          ? Text(
                              global.durationString(sets[i].getDuration()),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: global.width(context) * 0.06,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text(
                              textAlign: TextAlign.right,
                              'x${setList[i].reps}',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: global.width(context) * 0.06,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
        returnList.add(SizedBox(
          height: global.width(context) * 0.01,
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
  CarouselSliderController carouselController = CarouselSliderController();
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

    int nameLength = 18;
    String newExerciseName = exerciseName;
    if (exerciseName.length > nameLength) {
      newExerciseName =
          '${exerciseName.substring(0, nameLength - 3).trim()}...';
    }

    return PopScope(
      onPopInvoked: (foo) => widget.refresh(),
      child: Scaffold(
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Navbar(
              title: newExerciseName,
              actionButton: ActionButton(
                iconData: Icons.add,
                action: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditSet(
                      add: true,
                      set: sets.isNotEmpty ? sets.last : null,
                      exerciseName: widget.name,
                    ),
                  ),
                ).then((value) => getData()),
              ),
            ),
            SizedBox(
              width: global.width(context) * global.containerWidthFactor,
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
                                  height: global.height(context) * .4,
                                  enlargeCenterPage: true,
                                  enlargeFactor: .125,
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
                                  right: global.width(context) * 0.1,
                                ),
                                child: SvgPicture.asset(
                                  'assets/Squiggly Arrow.svg',
                                  width: global.width(context) * 0.8,
                                  height: global.width(context) * 0.6,
                                  color: Theme.of(context).focusColor,
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Click  \'+\'  to add a set!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: global.width(context) * 0.04,
                                    color: Theme.of(context).focusColor,
                                  ),
                                ),
                              )
                            ])
                      : [
                          Padding(
                            padding: EdgeInsets.only(
                                top: global.height(context) * 0.3),
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
