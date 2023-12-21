import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class Heading extends StatelessWidget {
  const Heading({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * global.containerWidthFactor,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(global.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).focusColor,
            spreadRadius: -10.0,
            blurRadius: 10.0,
            offset: const Offset(0, 10.0),
          )
        ],
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.045,
        ),
      ),
    );
  }
}
