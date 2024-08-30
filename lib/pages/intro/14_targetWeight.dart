import 'package:flexify/pages/dashboard.dart';
import 'package:flexify/pages/intro/15_introOutro.dart';
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

  bool topSelected = false;
  bool botSelected = false;

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
                Row(
                  children: [
                    SizedBox(
                      height: global.height(context) * 0.15,
                    ),
                    const IntroNavBarIcon(),
                    widget.isSettings
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: global.width(context) * 0.12,
                                right: global.width(context) * 0.17),
                            child: Text(
                              "Target Weight",
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
                        BorderRadius.circular(global.width(context) * 0.0375),
                    boxShadow: [global.darkShadow(context)],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Select your',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: global.height(context) * 0.01 +
                              global.width(context) * 0.02,
                        ),
                      ),
                      Text(
                        'target weight',
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
                        height: global.height(context) * 0.015,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTapDown: (details) async {
                              topSelected = true;
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
                              width: global.width(context) * 0.25,
                              height: global.height(context) * 0.1,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(
                                    global.width(context) * 0.02),
                                boxShadow: [global.darkShadow(context)],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '-',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: global.width(context) * 0.1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: global.width(context) * 0.025,
                          ),
                          Container(
                            width: global.width(context) * 0.25,
                            height: global.height(context) * 0.1,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(
                                  global.width(context) * 0.02),
                              boxShadow: [global.darkShadow(context)],
                            ),
                            child: Center(
                              child: Text(
                                '${(targetWeight).toString()}kg',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: global.width(context) * 0.05),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: global.width(context) * 0.025,
                          ),
                          GestureDetector(
                            onTapDown: (details) async {
                              topSelected = true;
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
                              width: global.width(context) * 0.25,
                              height: global.height(context) * 0.1,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(
                                    global.width(context) * 0.02),
                                boxShadow: [global.darkShadow(context)],
                              ),
                              child: Center(
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                      fontSize: global.width(context) * 0.1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: global.height(context) * 0.05,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: global.height(context) * 0.07,
                        width: global.width(context) * 0.8,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(
                              global.width(context) * 0.0375),
                          boxShadow: [global.darkShadow(context)],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Choose a',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: global.height(context) * 0.01 +
                                    global.width(context) * 0.02,
                              ),
                            ),
                            Text(
                              'timeframe',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: global.height(context) * 0.01 +
                                    global.width(context) * 0.02,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: global.height(context) * 0.02,
                      ),
                      Container(
                        clipBehavior: Clip.hardEdge,
                        height: global.height(context) * 0.15,
                        width: global.width(context) * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(
                              global.width(context) * 0.0375),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.all(global.height(context) * 0.01),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                      global.width(context) * 0.0375),
                                ),
                                color: Theme.of(context).colorScheme.background,
                              ),
                              child: Text(
                                '${selectedKgPerWeek.toStringAsFixed(2)}kg / Week',
                                style: TextStyle(
                                    color: withinRecommendedRange
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.white,
                                    fontSize: global.height(context) * 0.015),
                              ),
                            ),
                            SizedBox(height: global.height(context) * 0.0125),
                            SliderTheme(
                              data: SliderThemeData(
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius:
                                        global.height(context) * 0.0125),
                                thumbColor: withinRecommendedRange
                                    ? Theme.of(context).colorScheme.primary
                                    : const Color.fromARGB(255, 195, 195, 195)
                                        .withOpacity(0.9),
                                trackHeight: global.height(context) * 0.01,
                                activeTrackColor: Colors.transparent,
                                inactiveTrackColor: Colors.transparent,
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: global.height(context) * 0.0075,
                                    width: global.width(context) * 0.8,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                  Slider(
                                    value: selectedKgPerWeek,
                                    onChanged: (double value) {
                                      botSelected = true;
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
                                          refresh();
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
                        height: global.height(context) * 0.02,
                      ),
                      Container(
                        height: global.height(context) * 0.1,
                        width: global.width(context) * 0.8,
                        padding: EdgeInsets.only(
                            top: global.height(context) * 0.025,
                            left: global.width(context) * 0.045),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(
                              global.width(context) * 0.0375),
                          boxShadow: [global.darkShadow(context)],
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
                                    fontSize: global.height(context) * 0.015 +
                                        global.width(context) * 0.02,
                                  ),
                                ),
                                Text(
                                  '${weeksToCompletion.toString()} Weeks',
                                  style: TextStyle(
                                    color: withinRecommendedRange
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.white,
                                    fontSize: global.height(context) * 0.015 +
                                        global.width(context) * 0.02,
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
                                    fontSize: global.height(context) * 0.006 +
                                        global.width(context) * 0.02,
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
                    if (botSelected &&
                        topSelected &&
                        widget.isSettings == false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FifteenSummary(),
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
                      color: botSelected && topSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.isSettings ? "Enter" : "Next",
                          style: TextStyle(
                              color: botSelected && topSelected
                                  ? Colors.black
                                  : Colors.white,
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
            fontSize:
                global.height(context) * 0.005 + global.width(context) * 0.02),
      ),
    );
  }
}
