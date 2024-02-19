import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class ThreeHeight extends StatefulWidget {
  const ThreeHeight({super.key});

  @override
  State<ThreeHeight> createState() => _ThreeHeightState();
}

// Initialise value to average height / width
// When inches is dragged over the value of 11 the value of feet incremenets automatically

class _ThreeHeightState extends State<ThreeHeight> {
  late FixedExtentScrollController _cmController;
  // 180cm
  int cmIdx = 80;
  late FixedExtentScrollController _ftController;
  // 5ft
  int ftIdx = 2;
  late FixedExtentScrollController _inController;
  // 10in
  int inIdx = 0;

  var unitview = "cm";

  @override
  void initState() {
    _ftController = FixedExtentScrollController(initialItem: ftIdx);
    _inController = FixedExtentScrollController(initialItem: inIdx);
    _cmController = FixedExtentScrollController(initialItem: cmIdx);
    super.initState();
  }

  void dispose() {
    _ftController.dispose();
    _inController.dispose();
    _cmController.dispose();
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
                  height: MediaQuery.of(context).size.height * 0.087,
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
                  height: MediaQuery.of(context).size.height * 0.055,
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
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'How tall',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.01 +
                                    MediaQuery.of(context).size.width * 0.01),
                      ),
                      Text(
                        'are you?',
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
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.25,
                      bottom: MediaQuery.of(context).size.height * 0.3),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.56,
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2),
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        unitview == "cm"
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      child: ListWheelScrollView.useDelegate(
                                        controller: _cmController,
                                        onSelectedItemChanged: (index) {},
                                        itemExtent: 50,
                                        perspective: 0.005,
                                        diameterRatio: 3.5,
                                        physics:
                                            const FixedExtentScrollPhysics(),
                                        childDelegate:
                                            ListWheelChildBuilderDelegate(
                                          childCount: 175,
                                          builder: (context, index) {
                                            return CmTile(centimeter: index);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
                                      child: ListWheelScrollView.useDelegate(
                                        controller: _ftController,
                                        onSelectedItemChanged: (index) {},
                                        itemExtent: 50,
                                        perspective: 0.005,
                                        diameterRatio: 3.5,
                                        physics:
                                            const FixedExtentScrollPhysics(),
                                        childDelegate:
                                            ListWheelChildBuilderDelegate(
                                          childCount: 10,
                                          builder: (context, index) {
                                            return FtTile(ft: index);
                                          },
                                        ),
                                      ),
                                    ),
                                    const Text('\''),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.02),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.05,
                                      child: ListWheelScrollView.useDelegate(
                                        controller: _inController,
                                        onSelectedItemChanged: (index) {},
                                        itemExtent: 50,
                                        perspective: 0.005,
                                        diameterRatio: 3.5,
                                        physics:
                                            const FixedExtentScrollPhysics(),
                                        childDelegate:
                                            ListWheelChildBuilderDelegate(
                                          childCount: 12 * 9 + 1,
                                          builder: (context, index) {
                                            return InchTile(inches: index);
                                          },
                                        ),
                                      ),
                                    ),
                                    const Text('\'\''),
                                  ],
                                ),
                              ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: ListWheelScrollView.useDelegate(
                            onSelectedItemChanged: (value) {
                              value == 0
                                  ? setState(
                                      () {
                                        unitview = "cm";
                                        _cmController.jumpToItem(cmIdx);
                                      },
                                    )
                                  : setState(
                                      () {
                                        unitview = "ft";
                                        _ftController.jumpToItem(ftIdx);
                                        _inController.jumpToItem(inIdx);
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
                                  return const MetricTile(isCm: true);
                                } else {
                                  return const MetricTile(isCm: false);
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    boxShadow: [global.darkShadow(context)],
                    color: Theme.of(context).primaryColor,
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FtTile extends StatelessWidget {
  final int ft;

  const FtTile({super.key, required this.ft});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        ft.toString(),
        style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize: MediaQuery.of(context).size.height * 0.005 +
                MediaQuery.of(context).size.width * 0.02),
      ),
    );
  }
}

class CmTile extends StatelessWidget {
  final int centimeter;

  const CmTile({super.key, required this.centimeter});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        (centimeter + 100).toString(),
        style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize: MediaQuery.of(context).size.height * 0.005 +
                MediaQuery.of(context).size.width * 0.02),
      ),
    );
  }
}

class InchTile extends StatelessWidget {
  final int inches;

  const InchTile({super.key, required this.inches});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '${inches % 12}',
        style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize: MediaQuery.of(context).size.height * 0.005 +
                MediaQuery.of(context).size.width * 0.02),
      ),
    );
  }
}

class MetricTile extends StatelessWidget {
  final bool isCm;

  const MetricTile({super.key, required this.isCm});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        isCm ? 'cm' : 'ft',
        style: TextStyle(
            color: Theme.of(context).focusColor,
            fontSize: MediaQuery.of(context).size.height * 0.005 +
                MediaQuery.of(context).size.width * 0.02),
      ),
    );
  }
}
