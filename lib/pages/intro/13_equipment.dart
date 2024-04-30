import 'package:flexify/pages/intro/14_targetWeight.dart';
import 'package:flexify/pages/intro/widgets/IntroNavbarIcon.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class ThirteenEquipment extends StatefulWidget {
  final bool isSettings;
  const ThirteenEquipment({super.key, required this.isSettings});

  @override
  State<ThirteenEquipment> createState() => _ThirteenEquipmentState();
}

class _ThirteenEquipmentState extends State<ThirteenEquipment> {
  int selectedType = 0;

  List<String> selectedTypeName = [
    "Free Weights",
    "Benches & Racks",
    "Bodyweight",
    "Cable Machines",
    "Machines",
  ];

  List<Map<String, bool>> items = [
    <String, bool>{
      "Barbell": true,
      "Dumbbells": false,
      "EZ Bar": false,
      "Trap Bar": false,
      "Safety Bar": false,
      "Resistance Bands": false,
    },
    <String, bool>{
      "Flat Bench": false,
      "Adjustable Bench": false,
      "Decline Bench": false,
      "Flat Bench with Rack": false,
      "Incline Bench with Rack": false,
      "Decline Bench with Rack": false,
      "Squat Rack": false,
      "Preacher Curl Bench": false,
      "Row Bench": false,
    },
    <String, bool>{
      "Pull-Up Bar": false,
      "Dip Bars": false,
      "Vertical Bench": false,
      "Roman Chair": false,
      "Glute Ham Raise Bench": false,
      "Sissy Squat Bench": false,
      "TRX": false,
    },
    <String, bool>{
      "Lat Pulldown": false,
      "Cable": false,
      "Cable Crossover": false,
      "Row Cable": false,
    },
    <String, bool>{
      "Ab Machines": false,
      "Butterfly": false,
      "Butterfly Reverse": false,
      "Leg Extension Machines": false,
      "Leg Curl Machines": false,
      "Chest Press Machines": false,
      "Leg Press Machines": false,
      "Biceps Machines": false,
      "Smith Machine": false,
      "Hack Squat Machines": false,
      "Lat Pulldown Machines": false,
      "Row Machines": false,
      "Deadlift Machines": false,
      "Back Extension Machines": false,
      "Shoulder Press Machines": false,
      "Lateral Raise Machines": false,
      "Triceps Machines": false,
      "Calf Raise Machines": false,
      "Glute Machines": false,
      "All other Machines": false,
    }
  ];

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const IntroNavBarIcon(),
                    widget.isSettings
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.16,
                                right:
                                    MediaQuery.of(context).size.width * 0.19),
                            child: Text(
                              "Equipment",
                              style: TextStyle(
                                  color: Theme.of(context).focusColor,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06),
                            ),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                          ),
                    widget.isSettings
                        ? const SizedBox()
                        : GestureDetector(
                            onTap: () {
                              if (widget.isSettings == false) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const FourteenTargetWeight(
                                      isSettings: false,
                                    ),
                                  ),
                                );
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                  color: Theme.of(context).focusColor,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.035),
                            ),
                          ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02)
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                widget.isSettings
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      )
                    : Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.width * 0.045,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              border: Border.all(
                                  color: Theme.of(context).focusColor,
                                  width: 2,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(1000),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.005),
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.035,
                              width: MediaQuery.of(context).size.width * 0.035,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width),
                              ),
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.0375),
                    border: Border.all(
                      color: Theme.of(context).focusColor,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Make changes if',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.01 +
                              MediaQuery.of(context).size.width * 0.02,
                        ),
                      ),
                      Text(
                        'neccessary',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.01 +
                              MediaQuery.of(context).size.width * 0.02,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.025,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(
                                  () {
                                    selectedType = index;
                                  },
                                );
                              },
                              child: Row(
                                children: [
                                  AnimatedContainer(
                                    duration: global.standardAnimationDuration,
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                      color: selectedType == index
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .surface,
                                      border: Border.all(
                                        color: Theme.of(context).focusColor,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.width *
                                              0.1),
                                    ),
                                    child: Text(selectedTypeName[index],
                                        style: TextStyle(
                                            color: selectedType == index
                                                ? Colors.black
                                                : Theme.of(context).focusColor,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.03,
                                            fontWeight: FontWeight.w100)),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.05,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: items[selectedType].length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Map<String, bool> equipmentMap =
                                        items[selectedType];
                                    bool val =
                                        equipmentMap.values.toList()[index];
                                    if (val) {
                                      items[selectedType][items[selectedType]
                                          .keys
                                          .toList()[index]] = false;
                                    } else {
                                      items[selectedType][items[selectedType]
                                          .keys
                                          .toList()[index]] = true;
                                    }
                                    setState(
                                      () {},
                                    );
                                  },
                                  child: AnimatedContainer(
                                    duration: global.standardAnimationDuration,
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.03),
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    decoration: BoxDecoration(
                                      color: items[selectedType]
                                                  .values
                                                  .toList()[index] ==
                                              true
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .surface,
                                      borderRadius: BorderRadius.circular(
                                          MediaQuery.of(context).size.width *
                                              0.0375),
                                      border: Border.all(
                                        color: Theme.of(context).focusColor,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      clipBehavior: Clip.hardEdge,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              items[selectedType]
                                                  .keys
                                                  .elementAt(index),
                                              style: TextStyle(
                                                  color: items[selectedType]
                                                                  .values
                                                                  .toList()[
                                                              index] ==
                                                          true
                                                      ? Colors.black
                                                      : Theme.of(context)
                                                          .focusColor,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.01 +
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.02),
                                            ),
                                            items[selectedType]
                                                    .values
                                                    .toList()[index]
                                                ? Icon(
                                                    Icons.check_circle_outlined,
                                                    color: items[selectedType]
                                                                  .values
                                                                  .toList()[
                                                              index] ==
                                                          true
                                                      ? Colors.black
                                                      : Theme.of(context)
                                                          .focusColor,
                                                    size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.17,
                                                  )
                                                : Container()
                                          ]),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.isSettings == false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FourteenTargetWeight(
                            isSettings: false,
                          ),
                        ),
                      );
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      boxShadow: [global.darkShadow(context)],
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.025),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
