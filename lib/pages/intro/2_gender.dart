import 'package:flexify/pages/intro/3_height.dart';
import 'package:flexify/pages/intro/widgets/IntroNavbarIcon.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class TwoGender extends StatefulWidget {
  final bool isSettings;
  const TwoGender({super.key, required this.isSettings});

  @override
  State<TwoGender> createState() => _TwoGenderState();
}

class _TwoGenderState extends State<TwoGender> {
  int selected = 0;

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
                    IntroNavBarIcon(),
                    widget.isSettings
                        ? Padding(
                            padding: EdgeInsets.only(
                                left: global.width(context) * 0.23,
                                right: global.width(context) * 0.25),
                            child: Text(
                              "Gender",
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
                                  builder: (context) => const ThreeHeight(
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
                                color: Theme.of(context).colorScheme.background,
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(1000),
                            ),
                          ),
                          Container(
                            margin:
                                EdgeInsets.all(global.width(context) * 0.005),
                            height: global.width(context) * 0.035,
                            width: global.width(context) * 0.035,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius:
                                  BorderRadius.circular(global.width(context)),
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
                    borderRadius: BorderRadius.circular(
                      global.width(context) * 0.0375,
                    ),
                    boxShadow: [global.darkShadow(context)],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Are you male or',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: global.height(context) * 0.01 +
                                global.width(context) * 0.02),
                      ),
                      Text(
                        'female?',
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
                  width: global.width(context) * 0.8,
                  padding: EdgeInsets.only(top: global.width(context) * 0.1),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              selected = -1;
                              setState(() {});
                            },
                            child: AnimatedContainer(
                              duration: global.standardAnimationDuration,
                              width: global.width(context) * 0.35,
                              height: global.width(context) * 0.35,
                              padding: EdgeInsets.only(
                                  top: global.width(context) * 0.02),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                borderRadius: BorderRadius.circular(
                                  global.width(context) * 0.0375,
                                ),
                                boxShadow: selected == -1
                                    ? [
                                        BoxShadow(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          blurRadius: 10.0,
                                          offset: const Offset(0.0, 0.0),
                                        )
                                      ]
                                    : [
                                        global.darkShadow(context),
                                      ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: global.width(context) * 0.05,
                                  ),
                                  Text(
                                    "Female",
                                    style: TextStyle(
                                      color: selected == -1
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                      fontSize: global.width(context) * 0.045,
                                    ),
                                  ),
                                  Icon(
                                    Icons.female_outlined,
                                    color: selected == -1
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                    size: global.width(context) * 0.17,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: global.width(context) * 0.1,
                      ),
                      GestureDetector(
                        onTap: () {
                          selected = 1;
                          setState(() {});
                        },
                        child: Column(
                          children: [
                            AnimatedContainer(
                              duration: global.standardAnimationDuration,
                              width: global.width(context) * 0.35,
                              height: global.width(context) * 0.35,
                              padding: EdgeInsets.only(
                                  top: global.width(context) * 0.02),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.background,
                                borderRadius: BorderRadius.circular(
                                  global.width(context) * 0.0375,
                                ),
                                boxShadow: selected == 1
                                    ? [
                                        BoxShadow(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          blurRadius: 10.0,
                                          offset: const Offset(0.0, 0.0),
                                        )
                                      ]
                                    : [
                                        global.darkShadow(context),
                                      ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: global.width(context) * 0.05),
                                  Text(
                                    "Male",
                                    style: TextStyle(
                                      color: selected == 1
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                      fontSize: global.width(context) * 0.045,
                                    ),
                                  ),
                                  SizedBox(
                                    height: global.width(context) * 0.007,
                                  ),
                                  Icon(
                                    Icons.male_outlined,
                                    color: selected == 1
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onBackground,
                                    size: global.width(context) * 0.17,
                                  ),
                                ],
                              ),
                            )
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
                          builder: (context) => const ThreeHeight(
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
