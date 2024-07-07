import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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

String getCardinal(int n) {
  return (n > 3 || n < 1) ? "th" : cardinals[n - 1].toString();
}

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

BoxShadow lightShadow(BuildContext context) => BoxShadow(
      color: const Color.fromARGB(255, 27, 27, 31).withOpacity(0.3),
      spreadRadius: -7.0,
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

List<BoxShadow> shadow(BuildContext context) =>
    isDarkMode(context) ? [darkShadow(context)] : [lightShadow(context)];

double width(BuildContext context) => MediaQuery.of(context).size.width;
double height(BuildContext context) => MediaQuery.of(context).size.height;

double containerWidth(context) {
  return width(context) * containerWidthFactor;
}

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
        child: const CupertinoActivityIndicator(),
      ),
    );

ShaderMask gradient(child) => ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) => const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xffa4fba4),
          Color(0xfff2f58d),
        ],
      ).createShader(bounds),
      child: child,
    );

LinearGradient linearGradient = const LinearGradient(
  begin: Alignment.bottomLeft,
  end: Alignment.centerRight,
  colors: [
    Color(0xffa4fba4),
    Color(0xfff2f58d),
  ],
);

Color darkGrey = const Color.fromARGB(255, 26, 26, 29);

BoxDecoration boxDecoration(context) => BoxDecoration(
      color: darkGrey,
      borderRadius: BorderRadius.circular(30),
      boxShadow: shadow(context),
    );

SizedBox smallHeight(context) => SizedBox(height: height(context) * .01);
SizedBox mediumHeight(context) => SizedBox(height: height(context) * .02);
SizedBox largeHeight(context) => SizedBox(height: height(context) * .03);

String durationString(Duration dur) {
  double microseconds = dur.inMicroseconds.toDouble();

  var minutes = microseconds ~/ Duration.microsecondsPerMinute;
  microseconds = microseconds.remainder(Duration.microsecondsPerMinute);

  var minutesPadding = minutes < 10 ? "0" : "";

  var seconds = microseconds ~/ Duration.microsecondsPerSecond;
  microseconds = microseconds.remainder(Duration.microsecondsPerSecond);

  var secondsPadding = seconds < 10 ? "0" : "";

  return "$minutesPadding$minutes:"
      "$secondsPadding$seconds";
}
