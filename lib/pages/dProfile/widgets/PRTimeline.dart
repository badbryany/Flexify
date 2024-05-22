import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class PRTimeline extends StatefulWidget {
  final double tileHeightFactor;
  final double tileWidthFactor;

  const PRTimeline({
    super.key,
    required this.tileHeightFactor,
    required this.tileWidthFactor,
  });

  @override
  State<PRTimeline> createState() => _PRTimelineState();
}

class _PRTimelineState extends State<PRTimeline> {
  bool section = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              alignment: Alignment.center,
              height: global.height(context) * .4,
              width: global.width(context) * global.containerWidthFactor,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(30),
                boxShadow: global.isDarkMode(context)
                    ? [global.darkShadow(context)]
                    : [global.lightShadow(context)],
              ),
              child: ListView.builder(
                itemBuilder: (context, idx) {
                  if (idx == 0) {
                    return Container(
                      alignment: Alignment.center,
                      height: global.height(context) * .15,
                      width: global.width(context) *
                          global.containerWidthFactor *
                          .2,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(30),
                        border: const Border(
                          bottom: BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        boxShadow: [global.darkShadow(context)]
                      ),
                      child: global.gradient(
                        Text(
                          "PR Timeline",
                          style: TextStyle(
                            fontSize: global.width(context) * .1,
                          ),
                        ),
                      ),
                    );
                  }
                  return idx % 2 == 0 ? const Section0() : const Section1();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Section0 extends StatelessWidget {
  const Section0({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        const Column(
          children: [
            Row(
              children: [
                EmptyTile(),
                EmptyTile(),
                StraightTile(horizontal: false)
              ],
            ),
            Row(
              children: [
                EmptyTile(),
                EmptyTile(),
                StraightTile(horizontal: false)
              ],
            ),
            Row(
              children: [EmptyTile(), EmptyTile(), CircleTile()],
            ),
            Row(
              children: [
                EmptyTile(),
                EmptyTile(),
                StraightTile(horizontal: false)
              ],
            ),
            Row(
              children: [
                EmptyTile(),
                EmptyTile(),
                StraightTile(horizontal: false)
              ],
            ),
            Row(
              children: [
                EmptyTile(),
                EmptyTile(),
                CornerTile(rotation: 1),
                StraightTile(horizontal: true),
                StraightTile(horizontal: true),
                StraightTile(horizontal: true),
                CornerTile(rotation: 3)
              ],
            ),
            Row(
              children: [
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                StraightTile(horizontal: false)
              ],
            ),
          ],
        ),
        Positioned(
            top: global.width(context) * .12,
            right: global.width(context) * .09,
            child: const PRTimelineContainer())
      ],
    );
  }
}

class Section1 extends StatelessWidget {
  const Section1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Column(
          children: [
            Row(
              children: [
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                StraightTile(horizontal: false)
              ],
            ),
            Row(
              children: [
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                StraightTile(horizontal: false)
              ],
            ),
            Row(
              children: [
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                CircleTile()
              ],
            ),
            Row(
              children: [
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                StraightTile(horizontal: false)
              ],
            ),
            Row(
              children: [
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                EmptyTile(),
                StraightTile(horizontal: false)
              ],
            ),
            Row(
              children: [
                EmptyTile(),
                EmptyTile(),
                CornerTile(rotation: 2),
                StraightTile(horizontal: true),
                StraightTile(horizontal: true),
                StraightTile(horizontal: true),
                CornerTile(rotation: 4)
              ],
            ),
            Row(children: [
              EmptyTile(),
              EmptyTile(),
              StraightTile(horizontal: false)
            ]),
          ],
        ),
        Positioned(
          top: global.width(context) * .13,
          left: global.width(context) * .1,
          child: const PRTimelineContainer(),
        ),
      ],
    );
  }
}

class PRTimelineContainer extends StatelessWidget {
  const PRTimelineContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: global.width(context) * .03),
      height: global.height(context) * .13,
      width: global.width(context) * .45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color.fromARGB(255, 26, 26, 29),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: global.height(context) * .015,
          ),
          global.gradient(
            Text(
              "25th May",
              style: TextStyle(
                  color: Colors.white, fontSize: global.width(context) * .07),
            ),
          ),
          SizedBox(
            height: global.height(context) * .01,
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(global.width(context) * .02),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(30)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                global.gradient(
                  Text(
                    "Bicep Curls",
                    style: TextStyle(
                      fontSize: global.width(context) * .05,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "20kg",
                      style: TextStyle(
                        fontSize: global.width(context) * .04,
                        color: Colors.white,
                      ),
                    ),
                    global.gradient(
                      Text(
                        " x ",
                        style: TextStyle(fontSize: global.width(context) * .04),
                      ),
                    ),
                    Text(
                      "12reps",
                      style: TextStyle(
                        fontSize: global.width(context) * .04,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyTile extends StatelessWidget {
  const EmptyTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: global.width(context) * global.containerWidthFactor / 9,
    );
  }
}

class StraightTile extends StatelessWidget {
  final bool horizontal;

  const StraightTile({
    super.key,
    required this.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: horizontal ? pi / 2 : 0,
      child: Container(
        alignment: Alignment.center,
        width: global.width(context) * global.containerWidthFactor / 9,
        height: global.width(context) * global.containerWidthFactor / 9,
        child: Container(
          height: global.width(context) * global.containerWidthFactor / 9,
          width: 2,
          color: Colors.white,
        ),
      ),
    );
  }
}

class CornerTile extends StatelessWidget {
  final int rotation;

  const CornerTile({
    super.key,
    required this.rotation,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation % 4 == 1
          ? pi / 2
          : rotation % 4 == 2
              ? pi
              : rotation % 4 == 3
                  ? 3 * pi / 2
                  : 0,
      child: Container(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        width: global.width(context) * global.containerWidthFactor / 9,
        height: global.width(context) * global.containerWidthFactor / 9,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Container(
                  height: global.width(context) *
                          global.containerWidthFactor /
                          9 /
                          2 +
                      1,
                  width: 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  height: 2,
                  width: global.width(context) *
                          global.containerWidthFactor /
                          9 /
                          2 +
                      1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CircleTile extends StatelessWidget {
  const CircleTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return global.gradient(
      Container(
        height: global.width(context) * global.containerWidthFactor / 9,
        width: global.width(context) * global.containerWidthFactor / 9,
        decoration: BoxDecoration(
          border: Border.all(width: 4),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }
}
