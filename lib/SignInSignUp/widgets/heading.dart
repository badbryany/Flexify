import 'package:flutter/material.dart';

class LogInHeading extends StatelessWidget {
  const LogInHeading({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(1, -0.75),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Sign',
            style: TextStyle(
              fontSize: 75,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sacramento',
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 75,
              fontWeight: FontWeight.bold,
              fontFamily: 'Sacramento',
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ],
      ),
    );
  }
}
