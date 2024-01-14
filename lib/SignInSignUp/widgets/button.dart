import 'package:flexify/data/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/models/shadow.dart';
import 'package:flexify/widgets/BounceElement.dart';

class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    super.key,
    required this.onTap,
    required this.text,
  });
  final Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return BounceElement(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.09,
        child: Shadow(
          borderRadius: borderRadius,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).colorScheme.outline,
            ),
            child: GestureDetector(
              onTap: onTap(),
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ImageButton extends StatelessWidget {
  const ImageButton({
    super.key,
    required this.onTap,
    required this.image,
  });
  final Function() onTap;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Shadow(
      borderRadius: borderRadius - 25,
      child: BounceElement(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.width * 0.1,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius - 25),
              border: Border.all(),
            ),
            child: GestureDetector(
              onTap: onTap(),
              child: Center(
                child: image,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
