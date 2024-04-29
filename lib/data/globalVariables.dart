import 'package:flutter/material.dart';

double borderRadius = 35;
double containerWidthFactor = 0.95;
double containerPadding = 30;

String host = 'https://flexify.kellermann.team/api';

Duration standardAnimationDuration = const Duration(milliseconds: 300);

int yearsSinceRelease = 1;

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

final List<String> monthsLong = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];

final List<String> weekdaysVeryShort = [
  "S",
  "M",
  "T",
  "W",
  "T",
  "F",
  "S",
];

final List<String> weekdaysShort = [
  "Sun",
  "Mon",
  "Tue",
  "Wed",
  "Thu",
  "Fri",
  "Sat",
];

final List<String> weekdaysLong = [
  "Sunday",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
];

leapYear(int year) {
  return ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0);
}

daysInMonth(int m, int y) {
  List<int> monthLength = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  if (leapYear(y) == true) {
    monthLength[1] = 29;
  }
  return monthLength[m - 1];
}

// Bruder.
final List<int> monthsDays = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

lightShadow(BuildContext context) => BoxShadow(
      color: const Color.fromARGB(255, 27, 27, 31).withOpacity(0.3),
      spreadRadius: -10.0,
      blurRadius: 10.0,
      offset: const Offset(0.0, 10.0),
    );

BoxShadow darkShadow(BuildContext context) => const BoxShadow(
      color: Color.fromARGB(255, 27, 27, 31),
      spreadRadius: -5.0,
      blurRadius: 10.0,
      offset: Offset(0.0, 10.0),
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

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Widget loadingWidget(BuildContext context, double size) => Center(
      child: SizedBox(
        width: width(context) * .09 * size,
        height: width(context) * .09 * size,
        child: CircularProgressIndicator(strokeWidth: 4 * size),
      ),
    );
