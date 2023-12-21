import 'package:flutter/material.dart';

class ExperienceLevel extends StatefulWidget {
  const ExperienceLevel({super.key});

  @override
  State<ExperienceLevel> createState() => _ExperienceLevelState();
}

class _ExperienceLevelState extends State<ExperienceLevel> {
  double spaceBetween = 100;

  onChange(newValue) {
    value = newValue;

    if (value == 0) {
      exeperienceString = 'brutal beginner';
    }
    if (value == 2.5) {
      exeperienceString = 'beginner';
    }
    if (value == 5) {
      exeperienceString = 'more advanced';
    }
    if (value == 7.5) {
      exeperienceString = 'gymrat';
    }
    if (value == 10) {
      exeperienceString = 'expert';
    }
    setState(() {});
  }

  double value = 2.5;
  String exeperienceString = 'beginner';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Tell us your',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
              color: Theme.of(context).focusColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'experience level',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                '!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                  color: Theme.of(context).focusColor,
                ),
              ),
            ],
          ),
          SizedBox(height: spaceBetween),
          Text(
            exeperienceString,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).focusColor,
            ),
          ),
          SizedBox(height: spaceBetween * 0.5),
          Slider(
            value: value,
            min: 0,
            max: 10,
            divisions: 4,
            onChanged: onChange,
          ),
        ],
      ),
    );
  }
}
