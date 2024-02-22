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

lightShadow(BuildContext context) => BoxShadow(
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
      spreadRadius: -10.0,
      blurRadius: 10.0,
      offset: const Offset(0.0, 10.0),
    );

BoxShadow darkShadow(BuildContext context) => BoxShadow(
      color: Theme.of(context).colorScheme.onSurface,
      spreadRadius: -5.0,
      blurRadius: 10.0,
      offset: const Offset(0.0, 10.0),
    );

bool isDarkMode(BuildContext context) =>
    Theme.of(context).scaffoldBackgroundColor != Colors.white;

double width(BuildContext context) => MediaQuery.of(context).size.width;
double height(BuildContext context) => MediaQuery.of(context).size.height;

String zeroBefore(int num) {
  if (num <= 9) {
    return '0$num';
  }
  return '$num';
}

Color gold = const Color(0xffFFD700);
Color silver = const Color(0xffC0C0C0);
Color bronze = const Color(0xffD6B757);
