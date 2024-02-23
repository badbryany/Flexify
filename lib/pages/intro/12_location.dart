import 'package:flexify/pages/intro/13_equipment.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class TwelveLocation extends StatefulWidget {
  const TwelveLocation({super.key});

  @override
  State<TwelveLocation> createState() => _TwelveLocationState();
}

class _TwelveLocationState extends State<TwelveLocation> {
  @override
  void initState() {
    super.initState();
  }

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
                    IconButton(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Theme.of(context).focusColor,
                      icon: const Icon(Icons.arrow_back_rounded),
                      iconSize: MediaQuery.of(context).size.width * 0.04,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ThirteenEquipment(),
                          ),
                        );
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(color: Theme.of(context).focusColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.03,
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
                      padding: EdgeInsets.all(5),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.0225,
                        width: MediaQuery.of(context).size.height * 0.0325,
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
                                    MediaQuery.of(context).size.width * 0.01),
                      ),
                      Text(
                        'do your training?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.01 +
                                    MediaQuery.of(context).size.width * 0.01),
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
                        child: Container(
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
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
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
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
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
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
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
                        child: Container(
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
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
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
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
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
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
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
                        child: Container(
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
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
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
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
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
                        child: Container(
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
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
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
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
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
                                        color: Theme.of(context).focusColor,
                                        fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01 +
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
                    if (selected != 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ThirteenEquipment(),
                        ),
                      );
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
                          'Next',
                          style: TextStyle(
                              color: Theme.of(context).focusColor,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.02),
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
