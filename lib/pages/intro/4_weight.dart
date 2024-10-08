import 'package:flexify/pages/intro/5_bodyfat.dart';
import 'package:flexify/pages/intro/widgets/IntroNavbarIcon.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class FourWeight extends StatefulWidget {
  final bool isSettings;
  const FourWeight({super.key, required this.isSettings});

  @override
  State<FourWeight> createState() => _FourWeightState();
}

class _FourWeightState extends State<FourWeight> {
  late FixedExtentScrollController _kgController;
  int kgIdx = 71;
  late FixedExtentScrollController _lbsController;
  int lbsIdx = 157;

  int selected = 0;

  var unitview = "kg";

  @override
  void initState() {
    super.initState();
    _kgController = FixedExtentScrollController(initialItem: kgIdx);
    _lbsController = FixedExtentScrollController(initialItem: lbsIdx);
  }

  @override
  void dispose() {
    _kgController.dispose();
    _lbsController.dispose();
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
                                left: global.width(context) * 0.25,
                                right: global.width(context) * 0.275),
                            child: Text(
                              "Weight",
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FiveBodyFat(
                                    isFemale: true,
                                    isSettings: false,
                                  ),
                                ),
                              );
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
                        'How much do',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: global.height(context) * 0.01 +
                                global.width(context) * 0.02),
                      ),
                      Text(
                        'you weight?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: global.height(context) * 0.01 +
                                global.width(context) * 0.02),
                      ),
                    ],
                  ),
                ),
                Container(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  height: global.height(context) * 0.55,
                  width: global.width(context) * 0.8,
                  padding: EdgeInsets.only(
                    top: global.height(context) * 0.2,
                    bottom: global.height(context) * 0.2,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    height: global.height(context) * 0.56,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(global.width(context) * 0.2),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: global.height(context) * .04,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).focusColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              global.width(context) * 0.2,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            unitview == "kg"
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: global.width(context) * 0.2,
                                        child: ListWheelScrollView.useDelegate(
                                          controller: _kgController,
                                          onSelectedItemChanged: (index) {
                                            selected = 1;
                                            setState(() {});
                                          },
                                          itemExtent: 50,
                                          perspective: 0.005,
                                          diameterRatio: 3.5,
                                          physics:
                                              const FixedExtentScrollPhysics(),
                                          childDelegate:
                                              ListWheelChildBuilderDelegate(
                                            childCount: 201,
                                            builder: (context, index) {
                                              return KgTile(kilogram: index);
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(
                                    width: global.width(context) * .2,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          child:
                                              ListWheelScrollView.useDelegate(
                                            controller: _lbsController,
                                            onSelectedItemChanged: (index) {
                                              setState(() {
                                                selected = 1;
                                              });
                                            },
                                            itemExtent: 50,
                                            perspective: 0.005,
                                            diameterRatio: 3.5,
                                            physics:
                                                const FixedExtentScrollPhysics(),
                                            childDelegate:
                                                ListWheelChildBuilderDelegate(
                                              childCount: 451,
                                              builder: (context, index) {
                                                return LbsTile(pounds: index);
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              width: global.width(context) * 0.2,
                              child: ListWheelScrollView.useDelegate(
                                onSelectedItemChanged: (value) {
                                  value == 0
                                      ? setState(
                                          () {
                                            unitview = "kg";
                                          },
                                        )
                                      : setState(
                                          () {
                                            unitview = "lbs";
                                          },
                                        );
                                },
                                itemExtent: 50,
                                perspective: 0.005,
                                diameterRatio: 3.5,
                                physics: const FixedExtentScrollPhysics(),
                                childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 2,
                                  builder: (context, index) {
                                    if (index == 0) {
                                      return const MetricTile(isKg: true);
                                    } else {
                                      return const MetricTile(isKg: false);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
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
                          builder: (context) => const FiveBodyFat(
                            isFemale: true,
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

class KgTile extends StatelessWidget {
  final int kilogram;

  const KgTile({super.key, required this.kilogram});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        kilogram.toString(),
        style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize:
                global.height(context) * 0.01 + global.width(context) * 0.035),
      ),
    );
  }
}

class LbsTile extends StatelessWidget {
  final int pounds;

  const LbsTile({super.key, required this.pounds});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '$pounds',
        style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize:
                global.height(context) * 0.01 + global.width(context) * 0.035),
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
                global.height(context) * 0.01 + global.width(context) * 0.035),
      ),
    );
  }
}
