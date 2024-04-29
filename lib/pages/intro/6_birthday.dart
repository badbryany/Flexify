import 'package:flexify/pages/intro/7_experience.dart';
import 'package:flexify/pages/intro/widgets/IntroNavbarIcon.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class SixBirthday extends StatefulWidget {
  final bool isSettings;
  const SixBirthday({super.key, required this.isSettings});

  @override
  State<SixBirthday> createState() => _SixBirthdayState();
}

class _SixBirthdayState extends State<SixBirthday> {
  DateTime birthday = DateTime.now();

  late FixedExtentScrollController _dayController;
  int dayIdx = 0;
  late FixedExtentScrollController _monthController;
  int monthIdx = 0;
  late FixedExtentScrollController _yearController;
  int yearIdx = 99;

  int selected = 0;

  @override
  void initState() {
    super.initState();
    _dayController = FixedExtentScrollController(initialItem: dayIdx);
    _monthController = FixedExtentScrollController(initialItem: monthIdx);
    _yearController = FixedExtentScrollController(initialItem: yearIdx);
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
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
                    IntroNavBarIcon(),
                    widget.isSettings
                        ? Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2, right:  MediaQuery.of(context).size.width * 0.27),
                          child: Text(
                              "Birthday",
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
                              builder: (context) => const SevenExperience(isSettings: false,),
                            ),
                          );
                        }
                        else {
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            color: Theme.of(context).focusColor,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.035),
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
                        'When is your',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.01 +
                                    MediaQuery.of(context).size.width * 0.02),
                      ),
                      Text(
                        'birthday?',
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
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.25,
                      bottom: MediaQuery.of(context).size.height * 0.3),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.01,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Theme.of(context).focusColor),
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: ListWheelScrollView.useDelegate(
                                  controller: _dayController,
                                  onSelectedItemChanged: (index) {
                                    selected = 1;
                                    setState(() {});
                                  },
                                  itemExtent: 50,
                                  perspective: 0.005,
                                  diameterRatio: 3.5,
                                  physics: const FixedExtentScrollPhysics(),
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: 31,
                                    builder: (context, index) {
                                      return DayTile(day: index);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: ListWheelScrollView.useDelegate(
                                  controller: _monthController,
                                  onSelectedItemChanged: (index) {
                                    selected = 1;
                                    setState(() {});
                                  },
                                  itemExtent: 50,
                                  perspective: 0.005,
                                  diameterRatio: 3.5,
                                  physics: const FixedExtentScrollPhysics(),
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: 12,
                                    builder: (context, index) {
                                      return MonthTile(month: index);
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.065,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.15,
                                child: ListWheelScrollView.useDelegate(
                                  controller: _yearController,
                                  onSelectedItemChanged: (index) {
                                    selected = 1;
                                    setState(() {});
                                  },
                                  itemExtent: 50,
                                  perspective: 0.005,
                                  diameterRatio: 3.5,
                                  physics: const FixedExtentScrollPhysics(),
                                  childDelegate: ListWheelChildBuilderDelegate(
                                    childCount: 100,
                                    builder: (context, index) {
                                      return YearTile(year: index);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                          builder: (context) => SevenExperience(isSettings: false,),
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

class DayTile extends StatelessWidget {
  final int day;

  const DayTile({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        (day + 1).toString(),
        style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize: MediaQuery.of(context).size.height * 0.01 +
                MediaQuery.of(context).size.width * 0.02),
      ),
    );
  }
}

class MonthTile extends StatelessWidget {
  final int month;

  const MonthTile({super.key, required this.month});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        (global.months[month]).toString(),
        style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize: MediaQuery.of(context).size.height * 0.01 +
                MediaQuery.of(context).size.width * 0.02),
      ),
    );
  }
}

class YearTile extends StatelessWidget {
  final int year;

  const YearTile({super.key, required this.year});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        (year + 1923).toString(),
        style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize: MediaQuery.of(context).size.height * 0.01 +
                MediaQuery.of(context).size.width * 0.02),
      ),
    );
  }
}
