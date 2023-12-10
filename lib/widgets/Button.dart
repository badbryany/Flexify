import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  Button({
    Key? key,
    required this.text,
    required this.onPressed,
    this.filled,
    this.color,
    this.borderRadius,
  }) : super(key: key);

  final String text;
  final void Function()? onPressed;
  bool? filled;
  Color? color;
  double? borderRadius;

  @override
  Widget build(BuildContext context) {
    filled ??= false;
    borderRadius ??= 100;
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(15),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius!),
            border: Border.all(
              color: color == null
                  ? Theme.of(context).colorScheme.primary
                  : color!,
              width: 0.85,
            ),
            color: filled!
                ? (color == null
                    ? Theme.of(context).colorScheme.primary
                    : color!)
                : null,
          ),
          padding: const EdgeInsets.all(20),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).focusColor,
            ),
          ),
        ),
      ),
    );
  }
}