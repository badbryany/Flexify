import 'package:flutter/material.dart';

class TrainingFrequency extends StatefulWidget {
  const TrainingFrequency({super.key});

  @override
  State<TrainingFrequency> createState() => _TrainingFrequencyState();
}

class _TrainingFrequencyState extends State<TrainingFrequency> {
  double spaceBetween = 40;

  onChange(newValue) {
    valueTimes = newValue;

    setState(() {});
  }

  onChange2(newValue) {
    valueLong = newValue;

    if (valueLong >= 60) {
      durationString = '${Duration(minutes: valueLong.round()).inHours}h ';
      if ((valueLong - (60 * Duration(minutes: valueLong.round()).inHours))
              .round() !=
          0) {
        durationString +=
            '${(valueLong - (60 * Duration(minutes: valueLong.round()).inHours)).round()}min';
      }
    } else {
      durationString = '${valueLong.round()}min';
    }

    setState(() {});
  }

  double valueTimes = 4;
  double valueLong = 60;

  String durationString = '1h';

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
            'How often do you want to train?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 45,
              color: Theme.of(context).focusColor,
            ),
          ),
          SizedBox(height: spaceBetween),
          Text(
            '${valueTimes.round()} time${valueTimes.round() != 1 ? 's' : ''} a week',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).focusColor,
            ),
          ),
          SizedBox(height: spaceBetween * 0.5),
          Slider(
            max: 7,
            min: 1,
            divisions: 7,
            value: valueTimes,
            onChanged: onChange,
          ),
          SizedBox(height: spaceBetween),
          Text(
            durationString,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).focusColor,
            ),
          ),
          SizedBox(height: spaceBetween * 0.5),
          Slider(
            value: valueLong,
            min: 30,
            max: 240,
            onChanged: onChange2,
          ),
        ],
      ),
    );
  }
}
