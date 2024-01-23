import 'package:flutter/material.dart';

class Bubbles extends StatefulWidget {
  const Bubbles({super.key});

  @override
  State<Bubbles> createState() => _BubblesState();
}

double xPosition = -5;

class _BubblesState extends State<Bubbles> {
  @override
  Widget build(BuildContext context) {
    void animate() {
      if (xPosition == -5) {
        xPosition = -6;
      } else {
        xPosition = -5;
      }
      setState(() {});
    }
    animate();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: Alignment(xPosition, -1),
            duration: const Duration(
              seconds: 10,
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.7,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(300),
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
