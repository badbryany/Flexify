import 'package:flexify/pages/intro/13_equipment.dart';
import 'package:flexify/pages/intro/widgets/IntroNavbarIcon.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class TwelveLocation extends StatefulWidget {
  final bool isSettings;
  const TwelveLocation({super.key, required this.isSettings});

  @override
  State<TwelveLocation> createState() => _TwelveLocationState();
}

class _TwelveLocationState extends State<TwelveLocation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  children: [
                    const IntroNavBarIcon(),
                    widget.isSettings
                        ? Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2, right:  MediaQuery.of(context).size.width * 0.25),
                          child: Text(
                              "Location",
                              style:
                                  TextStyle(color: Theme.of(context).focusColor, fontSize: MediaQuery.of(context).size.width * 0.06),
                            ),
                        )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                          ),
                    widget.isSettings
                        ? const SizedBox()
                        : 
                    GestureDetector(
                      onTap: () {
                        if (widget.isSettings == false) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ThirteenEquipment(isSettings: false,),
                            ),
                          );
                        }
                        else {
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(color: Theme.of(context).focusColor, fontSize: MediaQuery.of(context).size.width * 0.035),
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
                        'Where do you',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.01 +
                                    MediaQuery.of(context).size.width * 0.02),
                      ),
                      Text(
                        'do your training?',
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
                          setState(() {});
                        },
                        child: AnimatedContainer(
                          duration: global.standardAnimationDuration,
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01,
                            left: MediaQuery.of(context).size.width * 0.03,
                          ),
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: selected == 1
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface,
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
                                    MediaQuery.of(context).size.height * 0.012,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Commercial Gym',
                                    style: TextStyle(
                                        color: selected == 1
                                          ? Colors.black
                                          : Theme.of(context)
                                              .focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02 +
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
                                    'Access to machines, ',
                                    style: TextStyle(
                                        color: selected == 1
                                          ? Colors.black
                                          : Theme.of(context)
                                              .focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.015 +
                                            MediaQuery.of(context).size.width *
                                                0.001),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'free weights and cables',
                                    style: TextStyle(
                                        color: selected == 1
                                          ? Colors.black
                                          : Theme.of(context)
                                              .focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.015 +
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
                          selected = 2;
                          setState(() {});
                        },
                        child: AnimatedContainer(
                          duration: global.standardAnimationDuration,
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01,
                            left: MediaQuery.of(context).size.width * 0.03,
                          ),
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: selected == 2
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface,
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
                                    MediaQuery.of(context).size.height * 0.012,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Home Gym',
                                    style: TextStyle(
                                       color: selected == 2
                                          ? Colors.black
                                          : Theme.of(context)
                                              .focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02 +
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
                                    'Barbell, Squat Rack,',
                                    style: TextStyle(
                                       color: selected == 2
                                          ? Colors.black
                                          : Theme.of(context)
                                              .focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.015 +
                                            MediaQuery.of(context).size.width *
                                                0.001),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Dumbbells, Pull-Up Bar',
                                    style: TextStyle(
                                       color: selected == 2
                                          ? Colors.black
                                          : Theme.of(context)
                                              .focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.015 +
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
                          selected = 3;
                          setState(() {});
                        },
                        child: AnimatedContainer(
                          duration: global.standardAnimationDuration,
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.005,
                            left: MediaQuery.of(context).size.width * 0.03,
                          ),
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: selected == 3
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface,
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
                                    MediaQuery.of(context).size.height * 0.012,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Basic Equipment',
                                    style: TextStyle(
                                        color: selected == 3
                                          ? Colors.black
                                          : Theme.of(context)
                                              .focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02 +
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
                                    'Dumbbells, Pull-Up Bar',
                                    style: TextStyle(
                                        color: selected == 3
                                          ? Colors.black
                                          : Theme.of(context)
                                              .focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.015 +
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
                          selected = 4;
                          setState(() {});
                        },
                        child: AnimatedContainer(
                          duration: global.standardAnimationDuration,
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01,
                            left: MediaQuery.of(context).size.width * 0.03,
                          ),
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            color: selected == 4
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surface,
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
                                    MediaQuery.of(context).size.height * 0.012,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'No Equipment',
                                    style: TextStyle(
                                        color: selected == 4
                                          ? Colors.black
                                          : Theme.of(context)
                                              .focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02 +
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
                                    'You don\'t have access to',
                                    style: TextStyle(
                                        color: selected == 4
                                          ? Colors.black
                                          : Theme.of(context)
                                              .focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.015 +
                                            MediaQuery.of(context).size.width *
                                                0.001),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'any fitness equipment',
                                    style: TextStyle(
                                        color: selected == 4
                                          ? Colors.black
                                          : Theme.of(context)
                                              .focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.015 +
                                            MediaQuery.of(context).size.width *
                                                0.001),
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
                GestureDetector(
                  onTap: () {
                    if (selected != 0 && widget.isSettings == false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ThirteenEquipment(isSettings: false,),
                        ),
                      );
                    }
                    else {
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
