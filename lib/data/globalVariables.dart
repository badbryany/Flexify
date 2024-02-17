import 'package:flutter/material.dart';

double borderRadius = 35;
double containerWidthFactor = 0.95;
double containerPadding = 30;

String host = 'https://flexify.kellermann.team/api';

Duration standardAnimationDuration = const Duration(milliseconds: 300);

IconData arrow = Icons.arrow_back_rounded;

final List<String> cardinals = [
  "st",
  "nd",
  "rd",
  "th",
];

final List<String> months = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "May",
  "Jun",
  "Jul",
  "Aug",
  "Sep",
  "Oct",
  "Nov",
  "Dec"
];

BoxShadow lightShadow = const BoxShadow(
  color: Color.fromARGB(136, 72, 72, 72),
  spreadRadius: -10.0,
  blurRadius: 10.0,
  offset: Offset(0.0, 10.0),
);

BoxShadow darkShadow = const BoxShadow(
  color: Color.fromARGB(137, 0, 0, 0),
  spreadRadius: -5.0,
  blurRadius: 10.0,
  offset: Offset(0.0, 10.0),
);

String zeroBefore(int num) {
  if (num <= 9) {
    return '0$num';
  }
  return '$num';
}
