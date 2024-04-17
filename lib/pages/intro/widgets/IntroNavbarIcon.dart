import 'package:flutter/material.dart';

class IntroNavBarIcon extends StatefulWidget {
  const IntroNavBarIcon({super.key});

  @override
  State<IntroNavBarIcon> createState() => _IntroNavBarIconState();
}

class _IntroNavBarIconState extends State<IntroNavBarIcon> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () {
        Navigator.pop(context);
      },
      color: Theme.of(context).focusColor,
      icon: const Icon(Icons.arrow_back_rounded),
      iconSize: MediaQuery.of(context).size.width * 0.06,
    );
  }
}
