import 'package:flexify/pages/intro/11_targetMuscles.dart';
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
                                left: MediaQuery.of(context).size.width * 0.13,
                                right:
                                    MediaQuery.of(context).size.width * 0.19),
                            child: Text(
                              "Training Split",
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
                        'Choose your',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.01 +
                                    MediaQuery.of(context).size.width * 0.02),
                      ),
                      Text(
                        'training split',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.01 +
                                    MediaQuery.of(context).size.width * 0.02),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05),
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
                              left: MediaQuery.of(context).size.width * 0.03),
                          height: MediaQuery.of(context).size.height * 0.105,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: selectedSplit == 1
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.0375),
                            border: Border.all(
                              color: Theme.of(context).focusColor,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.025),
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
                                          MediaQuery.of(context).size.width *
                                              0.02),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: selectedSplit == 1
                                                ? Theme.of(context).focusColor
                                                : Colors.white,
                                            width: 2,
                                          ),
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
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.0125 +
                                            MediaQuery.of(context).size.width *
                                                0.001),
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
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.0125 +
                                            MediaQuery.of(context).size.width *
                                                0.001),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
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
                              left: MediaQuery.of(context).size.width * 0.03),
                          height: MediaQuery.of(context).size.height * 0.105,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: selectedSplit == 2
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.0375),
                            border: Border.all(
                              color: Theme.of(context).focusColor,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
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
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.015 +
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.005,
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
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.0125 +
                                            MediaQuery.of(context).size.width *
                                                0.001),
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
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.0125 +
                                            MediaQuery.of(context).size.width *
                                                0.001),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
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
                              left: MediaQuery.of(context).size.width * 0.03),
                          height: MediaQuery.of(context).size.height * 0.105,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: selectedSplit == 3
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.0375),
                            border: Border.all(
                              color: Theme.of(context).focusColor,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
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
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.015 +
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
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
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.0125 +
                                            MediaQuery.of(context).size.width *
                                                0.001),
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
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.0125 +
                                            MediaQuery.of(context).size.width *
                                                0.001),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
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
                              left: MediaQuery.of(context).size.width * 0.03),
                          height: MediaQuery.of(context).size.height * 0.105,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: selectedSplit == 4
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.0375),
                            border: Border.all(
                              color: Theme.of(context).focusColor,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
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
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.015 +
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
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
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.0125 +
                                            MediaQuery.of(context).size.width *
                                                0.001),
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
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.0125 +
                                            MediaQuery.of(context).size.width *
                                                0.001),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.075,
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
                          builder: (context) => ElevenTargetMuscles(
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
                      color: selected != 0
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surface,
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
                                  : Theme.of(context).focusColor,
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
