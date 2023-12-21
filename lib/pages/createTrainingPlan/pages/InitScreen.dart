import 'package:flutter/material.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          Image.asset(
            'assets/img/logo.png',
            width: MediaQuery.of(context).size.width * 0.4,
          ),
          Text(
            'Create your',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
              color: Theme.of(context).focusColor,
            ),
          ),
          Text(
            'personal',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            'Trainingplan!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
              color: Theme.of(context).focusColor,
            ),
          ),
        ],
      ),
    );
  }
}
