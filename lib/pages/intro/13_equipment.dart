import 'package:flexify/pages/intro/14_targetWeight.dart';
import 'package:flexify/pages/intro/widgets/IntroNavbarIcon.dart';
import 'package:flutter/cupertino.dart';
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

  @override
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
                                left: global.width(context) * 0.16,
                                right: global.width(context) * 0.19),
                            child: Text(
                              "Equipment",
                              style: TextStyle(
                                  color: Theme.of(context).focusColor,
                                  fontSize: global.width(context) * 0.06),
                            ),
                          )
                        : SizedBox(
                            width: global.width(context) * 0.7,
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
                                  fontSize: global.width(context) * 0.035),
                            ),
                          ),
                    SizedBox(width: global.width(context) * 0.02)
                  ],
                ),
                SizedBox(
                  height: global.height(context) * 0.03,
                ),
                widget.isSettings
                    ? SizedBox(
                        height: global.height(context) * 0.01,
                      )
                    : Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                            height: global.width(context) * 0.045,
                            width: global.width(context) * 0.8,
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
                            padding:
                                EdgeInsets.all(global.width(context) * 0.005),
                            child: Container(
                              height: global.width(context) * 0.035,
                              width: global.width(context) * 0.035,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(
                                    global.width(context)),
                              ),
                            ),
                          ),
                        ],
                      ),
                SizedBox(
                  height: global.height(context) * 0.01,
                ),
                Container(
                  alignment: Alignment.center,
                  height: global.height(context) * 0.07,
                  width: global.width(context) * 0.8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius:
                        BorderRadius.circular(global.width(context) * 0.0375),
                    boxShadow: [global.darkShadow(context)],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Make changes if',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: global.height(context) * 0.01 +
                              global.width(context) * 0.02,
                        ),
                      ),
                      Text(
                        'neccessary',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: global.height(context) * 0.01 +
                              global.width(context) * 0.02,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  height: global.height(context) * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: global.height(context) * 0.03,
                      ),
                      SizedBox(
                        height: global.height(context) * 0.05,
                        width: global.width(context) * 0.8,
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
                                    width: global.width(context) * 0.4,
                                    decoration: BoxDecoration(
                                      color: selectedType == index
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .surface,
                                      boxShadow: global.isDarkMode(context)
                                          ? [global.darkShadow(context)]
                                          : [],
                                      borderRadius: BorderRadius.circular(
                                          global.width(context) * 0.1),
                                    ),
                                    child: Text(selectedTypeName[index],
                                        style: TextStyle(
                                            color: selectedType == index
                                                ? Colors.black
                                                : Theme.of(context).focusColor,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.035,
                                            fontWeight: FontWeight.w100)),
                                  ),
                                  SizedBox(
                                    width: global.width(context) * 0.05,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: global.height(context) * 0.05,
                      ),
                      SizedBox(
                        height: global.height(context) * 0.45,
                        width: global.width(context) * 0.8,
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
                                        left: global.width(context) * 0.05,
                                        right: global.width(context) * 0.05),
                                    height: global.height(context) * 0.1,
                                    width: global.width(context) * 0.8,
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
                                          global.width(context) * 0.0375),
                                      boxShadow: global.isDarkMode(context)
                                          ? [global.darkShadow(context)]
                                          : [global.lightShadow(context)],
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
                                                    CupertinoIcons
                                                        .checkmark_alt,
                                                    color: Colors.black,
                                                    size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.08,
                                                  )
                                                : Icon(
                                                    CupertinoIcons.add,
                                                    color: Theme.of(context)
                                                        .focusColor,
                                                    size: MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.07,
                                                  )
                                          ]),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: global.height(context) * 0.025),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: global.height(context) * 0.02,
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
                    height: global.height(context) * 0.05,
                    width: global.width(context) * 0.8,
                    decoration: BoxDecoration(
                      boxShadow: [global.darkShadow(context)],
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.isSettings ? "Enter" : "Next",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: global.height(context) * 0.025),
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
