import 'package:flexify/pages/dashboard.dart';
import 'package:flexify/pages/intro/widgets/IntroNavbarIcon.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class FourteenTargetWeight extends StatefulWidget {
  final bool isSettings;
  const FourteenTargetWeight({super.key, required this.isSettings});

  @override
  State<FourteenTargetWeight> createState() => _FourteenTargetWeightState();
}

class _FourteenTargetWeightState extends State<FourteenTargetWeight> {
  // Male vs Female initialization
  // recommendedRange Formula
  // within recommendedRange Formula
  // change topLeft icon based on within recommendedRange Formula
  String unitview = "kg";

  int currentWeight = 61;
  int targetWeight = 66;
  bool continueCount = false;

  double selectedKgPerWeek = 0.21;
  int weeksToCompletion = 12;
  DateTime estimatedCompletion = DateTime.now();
  bool withinRecommendedRange = true;

  int selected = 0;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    weeksToCompletion =
        ((currentWeight - targetWeight).abs() / selectedKgPerWeek)
            .round()
            .clamp(0, 500);
    withinRecommendedRange = 0 < selectedKgPerWeek && selectedKgPerWeek < 0.7;
    estimatedCompletion =
        DateTime.now().add(Duration(days: (weeksToCompletion * 7)));
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
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  children: [
                    const IntroNavBarIcon(),
                    widget.isSettings
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.12,
                                right:
                                    MediaQuery.of(context).size.width * 0.17),
                            child: Text(
                              "Target Weight",
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
                                    builder: (context) => const Dashboard(),
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
                        'Select your',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.01 +
                              MediaQuery.of(context).size.width * 0.02,
                        ),
                      ),
                      Text(
                        'target weight',
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
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTapDown: (details) async {
                              if (selected == 0) {
                                selected = 1;
                              }
                              if (selected == 2) {
                                selected = 3;
                              }
                              continueCount = true;
                              while (continueCount) {
                                targetWeight--;
                                await Future.delayed(
                                    const Duration(milliseconds: 125));
                                setState(() {
                                  refresh();
                                });
                              }
                            },
                            onTapUp: (details) => continueCount = false,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width * 0.02),
                                  border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).focusColor)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '-',
                                    style: TextStyle(
                                        color: Theme.of(context).focusColor,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.07),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.025,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: MediaQuery.of(context).size.height * 0.1,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.of(context).size.width * 0.02),
                                border: Border.all(
                                    width: 2,
                                    color: Theme.of(context).focusColor)),
                            child: Center(
                              child: Text(
                                '${(targetWeight).toString()}kg',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.025,
                          ),
                          GestureDetector(
                            onTapDown: (details) async {
                              if (selected == 0) {
                                selected = 1;
                              }
                              if (selected == 2) {
                                selected = 3;
                              }
                              continueCount = true;
                              while (continueCount) {
                                targetWeight++;
                                await Future.delayed(
                                    const Duration(milliseconds: 125));
                                setState(() {
                                  refresh();
                                });
                              }
                            },
                            onTapUp: (details) => continueCount = false,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(
                                      MediaQuery.of(context).size.width * 0.02),
                                  border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).focusColor)),
                              child: Center(
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                      color: Theme.of(context).focusColor,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.07),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
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
                              'Choose a',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: MediaQuery.of(context).size.height *
                                        0.01 +
                                    MediaQuery.of(context).size.width * 0.02,
                              ),
                            ),
                            Text(
                              'timeframe',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: MediaQuery.of(context).size.height *
                                        0.01 +
                                    MediaQuery.of(context).size.width * 0.02,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        clipBehavior: Clip.hardEdge,
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.2),
                          border: Border.all(
                            width: 1.2,
                            color: Theme.of(context).focusColor,
                          ),
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * 0.0375),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.height * 0.01),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                      MediaQuery.of(context).size.width *
                                          0.0375),
                                ),
                                color: Theme.of(context).colorScheme.background,
                              ),
                              child: Text(
                                '${selectedKgPerWeek.toStringAsFixed(2)}kg / Week',
                                style: TextStyle(
                                    color: withinRecommendedRange
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).focusColor,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.015),
                              ),
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.0125),
                            SliderTheme(
                              data: SliderThemeData(
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius:
                                        MediaQuery.of(context).size.height *
                                            0.0125),
                                thumbColor: withinRecommendedRange
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).focusColor,
                                trackHeight:
                                    MediaQuery.of(context).size.height * 0.01,
                                activeTrackColor: Colors.transparent,
                                inactiveTrackColor: Colors.transparent,
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.0075,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                  Slider(
                                    value: selectedKgPerWeek,
                                    onChanged: (double value) {
                                      if (selected == 0) {
                                        selected = 2;
                                      }
                                      if (selected == 1) {
                                        selected = 3;
                                      }
                                      setState(
                                        () {
                                          selectedKgPerWeek =
                                              value.clamp(0.01, 1);
                                          weeksToCompletion =
                                              ((currentWeight - targetWeight)
                                                          .abs() /
                                                      selectedKgPerWeek)
                                                  .round()
                                                  .clamp(1, 500);
                                          estimatedCompletion =
                                              DateTime.now().add(
                                            Duration(
                                              days: (weeksToCompletion * 7)
                                                  .clamp(0, 104 * 7),
                                            ),
                                          );
                                          withinRecommendedRange =
                                              0.15 < selectedKgPerWeek &&
                                                  selectedKgPerWeek < 0.7;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.025,
                            left: MediaQuery.of(context).size.width * 0.036),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Duration:  ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                                0.015 +
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                  ),
                                ),
                                Text(
                                  '${weeksToCompletion.toString()} Weeks',
                                  style: TextStyle(
                                    color: withinRecommendedRange
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).focusColor,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                                0.015 +
                                            MediaQuery.of(context).size.width *
                                                0.02,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Estimated completion:  ${estimatedCompletion.day}${estimatedCompletion.day > 3 ? 'th' : global.cardinals[estimatedCompletion.day]} ${global.months[estimatedCompletion.month - 1]} ${estimatedCompletion.year}',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.shadow,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                                0.006 +
                                            MediaQuery.of(context).size.width *
                                                0.01,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (selected != 0 && widget.isSettings == false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dashboard(),
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
                      color: selected == 3
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surface,
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

class MetricTile extends StatelessWidget {
  final bool isKg;

  const MetricTile({super.key, required this.isKg});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        isKg ? 'kg' : 'lbs',
        style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize: MediaQuery.of(context).size.height * 0.005 +
                MediaQuery.of(context).size.width * 0.02),
      ),
    );
  }
}
