import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class Heading extends StatelessWidget {
  const Heading({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        alignment: Alignment.center,
        width: global.containerWidth(context),
        decoration: BoxDecoration(
          color: global.lightGrey,
          borderRadius: BorderRadius.circular(global.borderRadius - 10),
          boxShadow: global.shadow(context),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: global.width(context) * .04,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle != null ? global.smallHeight(context) : const SizedBox(),
            subtitle != null
                ? Text(
                    subtitle!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: global.width(context) * .0325,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(.5),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
