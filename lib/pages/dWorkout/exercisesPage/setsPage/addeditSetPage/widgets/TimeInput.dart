import 'package:flexify/pages/intro/9_duration.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class Timeinput extends StatelessWidget {
  const Timeinput({
    super.key,
    required this.title,
    required this.minuteController,
    required this.secondController,
  });

  final String title;
  final ScrollController minuteController;
  final ScrollController secondController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: global.height(context) * .01),
      width: global.width(context) * global.containerWidthFactor,
      height: global.height(context) * .18,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [global.darkShadow(context)],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: global.height(context) * .04,
            width: global.width(context) * .7,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.5),
              borderRadius: BorderRadius.circular(
                global.width(context) * 0.2,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: global.width(context) * 0.2,
                child: ListWheelScrollView.useDelegate(
                  controller: minuteController,
                  onSelectedItemChanged: (index) {
                    // setState(() {});
                  },
                  itemExtent: 50,
                  perspective: 0.005,
                  diameterRatio: 3.5,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 30,
                    builder: (context, index) {
                      return MinuteTile(minutes: index);
                    },
                  ),
                ),
              ),
              Text(
                "m",
                style: TextStyle(
                    color: Colors.white, fontSize: global.width(context) * .04),
              ),
              SizedBox(
                width: global.width(context) * .05,
              ),
              SizedBox(
                width: global.width(context) * 0.2,
                child: ListWheelScrollView.useDelegate(
                  controller: secondController,
                  onSelectedItemChanged: (index) {
                    // setState(() {});
                  },
                  itemExtent: 50,
                  perspective: 0.005,
                  diameterRatio: 3.5,
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: 60,
                    builder: (context, index) {
                      return SecondTile(seconds: index);
                    },
                  ),
                ),
              ),
              Text(
                "s",
                style: TextStyle(
                    color: Colors.white, fontSize: global.width(context) * .04),
              ),
              SizedBox(
                width: global.width(context) * .05,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class SecondTile extends StatelessWidget {
  final int seconds;

  const SecondTile({super.key, required this.seconds});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        seconds.toString(),
        style: TextStyle(
            color: Colors.white,
            fontSize:
                global.height(context) * 0.01 + global.width(context) * 0.035),
      ),
    );
  }
}
