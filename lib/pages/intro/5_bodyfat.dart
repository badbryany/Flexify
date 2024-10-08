import 'package:flexify/pages/intro/6_birthday.dart';
import 'package:flexify/pages/intro/widgets/IntroNavbarIcon.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter_svg/flutter_svg.dart';

class FiveBodyFat extends StatefulWidget {
  final bool isFemale;
  final bool isSettings;
  const FiveBodyFat(
      {super.key, required this.isFemale, required this.isSettings});

  @override
  State<FiveBodyFat> createState() => _FiveBodyFatState();
}

class _FiveBodyFatState extends State<FiveBodyFat> {
  final FixedExtentScrollController fixedExtentScrollController =
      FixedExtentScrollController();
  String selectedBodyFatPercentageRange = "____";
  int selected = 0;

  List<String> maleSelectedRange = [
    "4-6%",
    "7-10%",
    "11-15%",
    "16-23%",
    "23-30%",
    "31-40%",
    ">40%"
  ];

  List<String> femaleSelectedRange = [
    "10-15%",
    "16-20%",
    "21-25%",
    "26-30%",
    "31-35%",
    "36-45%",
    ">45%"
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
                SizedBox(
                  height: global.height(context) * 0.05,
                ),
                Row(
                  children: [
                    const IntroNavBarIcon(),
                    widget.isSettings
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: global.width(context) * 0.05,
                                right: global.width(context) * 0.075),
                            child: Text(
                              "Body Fat Percentage",
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
                                    builder: (context) => const SixBirthday(
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
                  height: global.height(context) * 0.03,
                ),
                Container(
                  alignment: Alignment.center,
                  height: global.height(context) * 0.07,
                  width: global.width(context) * 0.8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius:
                        BorderRadius.circular(global.width(context) * 0.0525),
                    boxShadow: [global.darkShadow(context)],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Estimate your current',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: global.height(context) * 0.01 +
                              global.width(context) * 0.02,
                        ),
                      ),
                      Text(
                        'body fat percentage',
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
                  alignment: Alignment.center,
                  height: global.height(context) * 0.55,
                  width: global.width(context) * global.containerWidthFactor,
                  child: Container(
                    clipBehavior: Clip.none,
                    height: global.width(context) * 0.8,
                    width: global.width(context) * 0.8,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [global.darkShadow(context)]),
                    child: Column(
                      children: [
                        SizedBox(
                          height: global.height(context) * 0.08,
                        ),
                        SizedBox(
                          height: global.width(context) * 0.3,
                          child: RotatedBox(
                            quarterTurns: -1,
                            child: ListWheelScrollView.useDelegate(
                              onSelectedItemChanged: (value) {
                                selectedBodyFatPercentageRange = widget.isFemale
                                    ? femaleSelectedRange[value]
                                    : maleSelectedRange[value];
                                selected = 1;
                                setState(() {});
                              },
                              itemExtent: global.width(context) * 0.3,
                              controller:
                                  FixedExtentScrollController(initialItem: 3),
                              physics: const FixedExtentScrollPhysics(),
                              perspective: 0.005,
                              childDelegate: ListWheelChildBuilderDelegate(
                                childCount: 7,
                                builder: (context, index) {
                                  return widget.isFemale
                                      ? RotatedBox(
                                          quarterTurns: 1,
                                          child: Container(
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              boxShadow: [
                                                global.lightShadow(context)
                                              ],
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/bodyFatPercentage/female/${femaleSelectedRange[index]}.svg',
                                            ),
                                          ),
                                        )
                                      : RotatedBox(
                                          quarterTurns: 1,
                                          child: Container(
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .background,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              boxShadow: [
                                                global.lightShadow(context)
                                              ],
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/bodyFatPercentage/male/${maleSelectedRange[index]}.svg',
                                            ),
                                          ),
                                        );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: global.width(context) * 0.125,
                        ),
                        Text(
                          selectedBodyFatPercentageRange,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: global.width(context) * 0.08),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (selected != 0 && widget.isSettings == false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SixBirthday(
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
                      color: selected != 0
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.isSettings ? "Enter" : 'Next',
                          style: TextStyle(
                              color: selected != 0
                                  ? Colors.black : Colors.white,
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

// Old Slider, mabye Needed in future

// Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: global.height(context) * 0.4,
//                       ),
//                       Container(
//                         clipBehavior: Clip.hardEdge,
//                         height: global.height(context) * 0.15,
//                         width: global.width(context) * 0.8,
//                         decoration: BoxDecoration(
//                           color: Theme.of(context)
//                               .colorScheme
//                               .onBackground
//                               .withOpacity(0.2),
//                           border: Border.all(
//                             width: 1.2,
//                             color: Theme.of(context).focusColor,
//                           ),
//                           borderRadius: BorderRadius.circular(
//                               global.width(context) * 0.0375),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               padding: EdgeInsets.all(
//                                   global.height(context) * 0.01),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(
//                                       global.width(context) *
//                                           0.0375),
//                                 ),
//                                 color: Theme.of(context).colorScheme.background,
//                               ),
//                               child: Text(
//                                 '${selectedBodyFatPercentage.toStringAsFixed(0)}%',
//                                 style: TextStyle(
//                                     color:
//                                         Theme.of(context).colorScheme.primary,
//                                     fontSize:
//                                         global.height(context) *
//                                             0.01),
//                               ),
//                             ),
//                             SizedBox(
//                                 height: global.height(context) *
//                                     0.0125),
//                             SliderTheme(
//                               data: SliderThemeData(
//                                 thumbShape: RoundSliderThumbShape(
//                                     enabledThumbRadius:
//                                         global.height(context) *
//                                             0.0125),
//                                 thumbColor:
//                                     Theme.of(context).colorScheme.primary,
//                                 trackHeight:
//                                     global.height(context) * 0.01,
//                                 activeTrackColor: Colors.transparent,
//                                 inactiveTrackColor: Colors.transparent,
//                               ),
//                               child: Stack(
//                                 alignment: Alignment.center,
//                                 children: [
//                                   Container(
//                                     height: global.height(context) *
//                                         0.0075,
//                                     width:
//                                         global.width(context) * 0.8,
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .background,
//                                   ),
//                                   Slider(
//                                     min: 5,
//                                     max: 50,
//                                     value: selectedBodyFatPercentage,
//                                     onChanged: (double value) {
//                                       setState(
//                                         () {
//                                           selected = 1;
//                                           selectedBodyFatPercentage =
//                                               value.clamp(5, 50);
//                                         },
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),