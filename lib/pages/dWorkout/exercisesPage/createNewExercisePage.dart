import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateNewExercise extends StatefulWidget {
  const CreateNewExercise({
    super.key,
    required this.exercise,
    required this.reload,
  });

  final Exercise exercise;
  final Function() reload;

  @override
  State<CreateNewExercise> createState() => _CreateNewExerciseState();
}

class _CreateNewExerciseState extends State<CreateNewExercise> {
  Exercise? saveExercise;
  bool loading = false;

  TextEditingController titleController = TextEditingController();

  List<String> types = [
    'Bodyweight',
    'Gym',
    'Strength',
    'Home',
    'Stretch',
    'Cardio',
    'Yoga',
    'Calestenics',
  ];
  List<String> sportsAndFitnessEquipment = [
    // Cardio Equipment
    "Treadmill",
    "Elliptical Trainer",
    "Stationary Bicycle",
    "Rowing Machine",
    "Stair Climber",
    "Jump Rope",

    // Strength Training Equipment
    "Dumbbells",
    "Barbells and Plates",
    "Kettlebells",
    "Weight Benches",
    "Power Rack/Squat Rack",
    "Smith Machine",
    "Cable Machines",
    "Resistance Bands",
    "Medicine Balls",
    "Sandbags",

    // Functional Training Equipment
    "TRX Suspension Trainer",
    "Battle Ropes",
    "Plyometric Boxes",
    "Sleds",
    "Agility Ladders",
    "Cones and Markers",

    // Flexibility and Recovery Equipment
    "Yoga Mats",
    "Foam Rollers",
    "Stretch Straps",
    "Massage Balls",

    // Sports-Specific Equipment
    "Soccer Ball",
    "Basketball",
    "Tennis Racket",
    "Baseball Bat and Gloves",
    "Hockey Stick",
    "Golf Clubs",
    "Volleyball",
    "Boxing Gloves and Pads",
    "Swimming Goggles and Cap",

    // Outdoor and Adventure Equipment
    "Bicycle",
    "Kayak/Canoe",
    "Climbing Gear (Harness, Ropes, Carabiners)",
    "Camping Gear (Tent, Sleeping Bag)",
    "Skateboard/Longboard",

    // Additional Accessories
    "Heart Rate Monitor",
    "Fitness Tracker/Smartwatch",
    "Weightlifting Gloves",
    "Lifting Belts",
    "Ankle/Wrist Weights",
    "Exercise Ball",
    "Hula Hoop",

    // Indoor Team Sports Equipment
    "Volleyball Net",
    "Basketball Hoop",
    "Badminton Net",
    "Table Tennis Table",

    // Miscellaneous
    "Balance Board",
    "Punching Bag",
    "Speed Bag",
    "Foam Pits"
  ];

  List<String> selectedEquipment = [];
  List<String> selectedMuscles = [];

  String type = '';

  int titleLength = 1;

  @override
  void initState() {
    saveExercise = widget.exercise;

    super.initState();

    titleController.text = saveExercise!.name;
    titleLength = titleController.text.length;

    titleController.addListener(() {
      titleLength = titleController.text.length;
      if (titleLength == 0) titleLength = 1;
      setState(() {});
    });
  }

  ScrollController listController = ScrollController();

  List<Widget> pages(BuildContext context) {
    return [
      // Exercisename
      Page(
        title: 'Name of exercise',
        children: [
          SizedBox(
            width: global.width(context) * .05 * titleLength,
            child: TextField(
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).focusColor,
                fontSize: global.width(context) * .075,
              ),
              controller: titleController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      //
      // Type
      Page(
        title: 'Exercisetype',
        children: [
          Container(
            alignment: Alignment.center,
            height: global.height(context) * .05 * types.length,
            width: global.containerWidth(context),
            child: ShaderMask(
              shaderCallback: (Rect rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black
                  ],
                  stops: [
                    0.0,
                    0.025,
                    0.9,
                    1.0
                  ], // 10% purple, 80% transparent, 10% purple
                ).createShader(rect);
              },
              blendMode: BlendMode.dstOut,
              child: GridView.count(
                childAspectRatio: 2.5,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: global.width(context) * .02,
                mainAxisSpacing: global.width(context) * .02,
                crossAxisCount: 2,
                children: [
                  for (String elem in types)
                    GestureDetector(
                      onTap: () {
                        setState(() => type = elem);
                      },
                      child: AnimatedContainer(
                        duration: global.standardAnimationDuration * .75,
                        curve: Curves.easeInOut,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                          horizontal: global.width(context) * .05,
                          vertical: global.width(context) * .025,
                        ),
                        margin: EdgeInsets.symmetric(
                          vertical: global.width(context) * .0125,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(global.borderRadius - 10),
                          color: Theme.of(context).colorScheme.background,
                          border: type == elem
                              ? Border.all(
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 2,
                                )
                              : null,
                        ),
                        child: type == elem
                            ? global.gradient(Text(
                                elem,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: global.width(context) * .045,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ))
                            : Text(
                                elem,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: global.width(context) * .045,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      //
      // affectedMuscle
      Page(
        title: 'Affected muscles',
        children: [
          Text('3d model?'),
        ],
      ),
      //
      // equipment
      Page(
        title: 'Equipment',
        children: [
          Container(
            alignment: Alignment.center,
            height: global.height(context) * .55,
            width: global.containerWidth(context),
            child: ShaderMask(
              shaderCallback: (Rect rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black
                  ],
                  stops: [
                    0,
                    .025,
                    .95,
                    1
                  ], // 10% purple, 80% transparent, 10% purple
                ).createShader(rect);
              },
              blendMode: BlendMode.dstOut,
              child: GridView.count(
                childAspectRatio: 2.5,
                physics: const BouncingScrollPhysics(),
                crossAxisSpacing: global.width(context) * .02,
                mainAxisSpacing: global.width(context) * .02,
                crossAxisCount: 2,
                children: [
                  for (String elem in sportsAndFitnessEquipment)
                    GestureDetector(
                      onTap: () {
                        if (selectedEquipment.contains(elem)) {
                          selectedEquipment.remove(elem);
                        } else {
                          selectedEquipment.add(elem);
                        }
                        setState(() {});
                      },
                      child: Stack(
                        children: [
                          Center(
                            child: AnimatedContainer(
                              duration: global.standardAnimationDuration * .75,
                              curve: Curves.easeInOut,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                horizontal: global.width(context) * .05,
                                vertical: global.width(context) * .025,
                              ),
                              margin: EdgeInsets.symmetric(
                                vertical: global.width(context) * .0125,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    global.borderRadius - 10),
                                color: Theme.of(context).colorScheme.background,
                                border: selectedEquipment.contains(elem)
                                    ? Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        width: 2,
                                      )
                                    : null,
                              ),
                              child: Text(
                                elem,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: global.width(context) * .045,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: global.width(context) * .025,
                            right: global.width(context) * .025,
                            child: AnimatedScale(
                              duration: global.standardAnimationDuration,
                              curve: Curves.easeInOut,
                              scale: selectedEquipment.contains(elem) ? 1 : 0,
                              child: Icon(
                                CupertinoIcons.check_mark_circled_solid,
                                color: Theme.of(context).colorScheme.primary,
                                size: global.width(context) * .04,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    ];
  }

  int currentPage = 0;

  String buttonText = 'next';

  next(BuildContext context) async {
    currentPage++;

    if (currentPage == pages(context).length - 1) {
      buttonText = 'finish';
    }

    if (currentPage == pages(context).length) {
      await Save.saveExercise(
        Exercise(
          name: titleController.text,
          type: type,
          affectedMuscle: selectedMuscles.toString(),
          equipment: selectedEquipment.toString(),
        ),
      );

      await widget.reload();
      Navigator.pop(context);
    }

    setState(() {});
    listController.animateTo(
      currentPage * global.width(context),
      duration: global.standardAnimationDuration,
      curve: Curves.easeInOut,
    );
  }

  previous(BuildContext context) async {
    currentPage--;
    buttonText = 'next';

    setState(() {});
    listController.animateTo(
      currentPage * global.width(context),
      duration: global.standardAnimationDuration,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: global.height(context),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      top: global.height(context) * .075,
                    ),
                    height: global.height(context) * .7,
                    width: global.width(context),
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: listController,
                      scrollDirection: Axis.horizontal,
                      children: pages(context),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: global.height(context) * .05,
                  ),
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(top: 5),
                        child: Stack(
                          children: [
                            Container(
                              height: 7.5,
                              width: global.width(context) * .7,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1000),
                                color: Theme.of(context).colorScheme.background,
                              ),
                            ),
                            AnimatedContainer(
                              duration: global.standardAnimationDuration,
                              curve: Curves.easeInOut,
                              height: 7.5,
                              width: ((global.width(context) * .7) /
                                      pages(context).length) *
                                  (currentPage + 1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1000),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        child: Text(
                          '${currentPage + 1} of ${pages(context).length}',
                          style: TextStyle(
                            color: Theme.of(context).focusColor.withOpacity(.5),
                            fontSize: global.width(context) * .05,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: global.height(context) * .06,
                          width: global.height(context) * .06,
                          margin: EdgeInsets.only(
                            bottom: global.height(context) * .05,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius:
                                BorderRadius.circular(global.borderRadius - 15),
                          ),
                          child: Icon(
                            CupertinoIcons.xmark,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: global.width(context) * .025),
                    GestureDetector(
                      onTap: () => currentPage != 0 ? previous(context) : null,
                      child: AnimatedOpacity(
                        duration: global.standardAnimationDuration,
                        opacity: currentPage == 0 ? .5 : 1,
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            height: global.height(context) * .06,
                            width: global.height(context) * .06,
                            margin: EdgeInsets.only(
                              bottom: global.height(context) * .05,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(
                                  global.borderRadius - 15),
                            ),
                            child: Icon(
                              CupertinoIcons.arrow_left,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: global.width(context) * .075),
                    GestureDetector(
                      onTap: () => next(context),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          alignment: Alignment.center,
                          height: global.height(context) * .06,
                          width: global.width(context) * .5,
                          margin: EdgeInsets.only(
                            bottom: global.height(context) * .05,
                          ),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(global.borderRadius - 15),
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: global.gradient(
                            Text(
                              buttonText,
                              style: TextStyle(
                                fontSize: global.width(context) * .06,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Page extends StatelessWidget {
  const Page({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: global.height(context) * .7,
      width: global.width(context),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: global.width(context) * .1,
              color: Theme.of(context).focusColor,
            ),
          ),
          global.largeHeight(context),
          global.largeHeight(context),
          ...children,
        ],
      ),
    );
  }
}
