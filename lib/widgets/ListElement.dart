import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class ListElement extends StatefulWidget {
  ListElement({
    super.key,
    required this.icon,
    required this.title,
    required this.link,
    this.normal,
    this.small,
    this.then,
    this.bgColor,
  });

  final IconData icon;
  final String title;
  final Widget link;
  Function? then;
  bool? normal;
  bool? small;
  Color? bgColor;

  @override
  State<ListElement> createState() => _ListElementState();
}

class _ListElementState extends State<ListElement> {
  double scale = 1;
  int duration = 100;

  @override
  Widget build(BuildContext context) {
    widget.normal ??= true;
    widget.small ??= false;
    widget.then ??= () {};
    widget.bgColor ??= Theme.of(context).colorScheme.onPrimary;

    widget.bgColor ??= widget.normal!
        ? Theme.of(context).colorScheme.onSecondary
        : Theme.of(context).colorScheme.onPrimary;

    return OpenContainer(
      closedColor: Theme.of(context).scaffoldBackgroundColor,
      openColor: Theme.of(context).scaffoldBackgroundColor,
      closedElevation: 0,
      openElevation: 0,
      closedBuilder: (context, openLink) => AnimatedScale(
        duration: Duration(milliseconds: duration),
        scale: scale,
        child: GestureDetector(
          onTapDown: (value) => setState(() {
            scale = 0.98;
          }),
          onTapUp: (value) => setState(() {
            scale = 1.02;
            Future.delayed(
              Duration(milliseconds: duration),
              () {
                setState(() => scale = 1);
                openLink();
              },
            );
          }),
          onTapCancel: () => setState(() {
            scale = 1.02;
            Future.delayed(
              Duration(milliseconds: duration),
              () => setState(() => scale = 1),
            );
          }),
          child: Container(
            padding: const EdgeInsets.all(30),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: widget.bgColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                  visible: !widget.small!,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      /* color: widget.normal!
                          ? Theme.of(context).colorScheme.background
                          : Theme.of(context).focusColor, */
                    ),
                    child: Icon(
                      widget.icon,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: widget.small!,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Icon(
                          widget.icon,
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: widget.small!
                          ? MediaQuery.of(context).size.width * 0.28
                          : null,
                      child: Text(
                        widget.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: widget.small! ? 18 : 25,
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: !widget.small!,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Icon(
                      Icons.arrow_right_alt_rounded,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      openBuilder: (context, closeLink) => widget.link,
    );
  }
}
