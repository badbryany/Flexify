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
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(global.borderRadius - 10),
        boxShadow: [global.lightShadow(context)],
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.038,
          color: Theme.of(context).focusColor,
        ),
      ),
    );
  }
}
