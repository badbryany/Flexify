import 'package:flexify/pages/intro/11_targetMuscles.dart';
import 'package:flexify/pages/intro/12_location.dart';
import 'package:flexify/pages/intro/widgets/IntroNavbarIcon.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class TenSplit extends StatefulWidget {
  final bool isSettings;
  const TenSplit({super.key, required this.isSettings});

  @override
  State<TenSplit> createState() => _TenSplitState();
}

class _TenSplitState extends State<TenSplit> {
  int selected = 0;
  int selectedSplit = 1;

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
                                left: global.width(context) * 0.13,
                                right: global.width(context) * 0.19),
                            child: Text(
                              "Training Split",
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
                                        const ElevenTargetMuscles(
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
                  height: global.height(context) * 0.01,
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
                        'Choose your',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: global.height(context) * 0.01 +
                                global.width(context) * 0.02),
                      ),
                      Text(
                        'training split',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: global.height(context) * 0.01 +
                                global.width(context) * 0.02),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: global.height(context) * 0.55,
                  padding: EdgeInsets.only(top: global.height(context) * 0.05),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          selected = 1;
                          selectedSplit = 1;
                          setState(() {});
                        },
                        child: AnimatedContainer(
                          duration: global.standardAnimationDuration,
                          padding: EdgeInsets.only(
                              left: global.width(context) * 0.03),
                          height: global.height(context) * 0.105,
                          width: global.width(context) * 0.8,
                          decoration: BoxDecoration(
                            color: selectedSplit == 1
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(
                                global.width(context) * 0.0375),
                            boxShadow: [global.darkShadow(context)],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: global.height(context) * 0.015,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: global.width(context) * 0.025),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'AI Generated',
                                      style: TextStyle(
                                          color: selectedSplit == 1
                                              ? Colors.black
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02 +
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.015),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(
                                          global.width(context) * 0.02),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: selectedSplit == 1
                                              ? [global.darkShadow(context)]
                                              : [],
                                          border: selectedSplit != 1
                                              ? Border.all(
                                                  color: Colors.white
                                                      .withOpacity(0.8),
                                                  width: 0.5)
                                              : Border.all(
                                                  color: Colors.transparent),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background),
                                      child: Text(
                                        "Recommended",
                                        style: TextStyle(
                                            color: selectedSplit == 1
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.0125 +
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.001),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Optimized based on your',
                                    style: TextStyle(
                                        color: selectedSplit == 1
                                            ? Colors.black
                                            : Theme.of(context)
                                                .colorScheme
                                                .shadow,
                                        fontSize:
                                            global.height(context) * 0.0125 +
                                                global.width(context) * 0.001),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'personal fitness journey',
                                    style: TextStyle(
                                        color: selectedSplit == 1
                                            ? Colors.black
                                            : Theme.of(context)
                                                .colorScheme
                                                .shadow,
                                        fontSize:
                                            global.height(context) * 0.0125 +
                                                global.width(context) * 0.001),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: global.height(context) * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          selected = 1;
                          selectedSplit = 2;
                          setState(() {});
                        },
                        child: AnimatedContainer(
                          duration: global.standardAnimationDuration,
                          padding: EdgeInsets.only(
                              left: global.width(context) * 0.03),
                          height: global.height(context) * 0.105,
                          width: global.width(context) * 0.8,
                          decoration: BoxDecoration(
                            color: selectedSplit == 2
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(
                                global.width(context) * 0.0375),
                            boxShadow: [global.darkShadow(context)],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: global.height(context) * 0.02,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Push/Pull/Legs',
                                    style: TextStyle(
                                        color: selectedSplit == 2
                                            ? Colors.black
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary,
                                        fontSize:
                                            global.height(context) * 0.015 +
                                                global.width(context) * 0.02),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: global.height(context) * 0.005,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Well suited for beginners',
                                    style: TextStyle(
                                        color: selectedSplit == 2
                                            ? Colors.black
                                            : Theme.of(context)
                                                .colorScheme
                                                .shadow,
                                        fontSize:
                                            global.height(context) * 0.0125 +
                                                global.width(context) * 0.001),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'and intermediate trainees',
                                    style: TextStyle(
                                        color: selectedSplit == 2
                                            ? Colors.black
                                            : Theme.of(context)
                                                .colorScheme
                                                .shadow,
                                        fontSize:
                                            global.height(context) * 0.0125 +
                                                global.width(context) * 0.001),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: global.height(context) * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          selected = 1;
                          selectedSplit = 3;
                          setState(() {});
                        },
                        child: AnimatedContainer(
                          duration: global.standardAnimationDuration,
                          padding: EdgeInsets.only(
                              left: global.width(context) * 0.03),
                          height: global.height(context) * 0.105,
                          width: global.width(context) * 0.8,
                          decoration: BoxDecoration(
                            color: selectedSplit == 3
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(
                                global.width(context) * 0.0375),
                            boxShadow: [global.darkShadow(context)],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: global.height(context) * 0.02,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Upper Lower',
                                    style: TextStyle(
                                        color: selectedSplit == 3
                                            ? Colors.black
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary,
                                        fontSize:
                                            global.height(context) * 0.015 +
                                                global.width(context) * 0.02),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: global.height(context) * 0.01,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Separate training days into upper',
                                    style: TextStyle(
                                        color: selectedSplit == 3
                                            ? Colors.black
                                            : Theme.of(context)
                                                .colorScheme
                                                .shadow,
                                        fontSize:
                                            global.height(context) * 0.0125 +
                                                global.width(context) * 0.001),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'or lower body workouts',
                                    style: TextStyle(
                                        color: selectedSplit == 3
                                            ? Colors.black
                                            : Theme.of(context)
                                                .colorScheme
                                                .shadow,
                                        fontSize:
                                            global.height(context) * 0.0125 +
                                                global.width(context) * 0.001),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: global.height(context) * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          selected = 1;
                          selectedSplit = 4;
                          setState(() {});
                        },
                        child: AnimatedContainer(
                          duration: global.standardAnimationDuration,
                          padding: EdgeInsets.only(
                              left: global.width(context) * 0.03),
                          height: global.height(context) * 0.105,
                          width: global.width(context) * 0.8,
                          decoration: BoxDecoration(
                            color: selectedSplit == 4
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(
                                global.width(context) * 0.0375),
                            boxShadow: [global.darkShadow(context)],
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: global.height(context) * 0.02,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Full Body',
                                    style: TextStyle(
                                        color: selectedSplit == 4
                                            ? Colors.black
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary,
                                        fontSize:
                                            global.height(context) * 0.015 +
                                                global.width(context) * 0.02),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: global.height(context) * 0.01,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'No restrictions. Well suited',
                                    style: TextStyle(
                                        color: selectedSplit == 4
                                            ? Colors.black
                                            : Theme.of(context)
                                                .colorScheme
                                                .shadow,
                                        fontSize:
                                            global.height(context) * 0.0125 +
                                                global.width(context) * 0.001),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'for more experienced trainees',
                                    style: TextStyle(
                                        color: selectedSplit == 4
                                            ? Colors.black
                                            : Theme.of(context)
                                                .colorScheme
                                                .shadow,
                                        fontSize:
                                            global.height(context) * 0.0125 +
                                                global.width(context) * 0.001),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: global.height(context) * .02,
                ),
                GestureDetector(
                  onTap: () {
                    if (selected != 0 && widget.isSettings == false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TwelveLocation(
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
