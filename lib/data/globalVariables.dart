import 'package:flutter/material.dart';
import 'package:flexify/main.dart' as main;

double borderRadius = 35;
double containerWidthFactor = 0.95;
double containerPadding = 30;

IconData arrow = Icons.arrow_back_rounded;

BoxShadow lightShadow = BoxShadow(
  color: Color.fromARGB(136, 72, 72, 72),
  spreadRadius: -10.0,
  blurRadius: 10.0,
  offset: const Offset(0.0, 10.0),
);

BoxShadow darkShadow = BoxShadow(
  color: const Color.fromARGB(137, 0, 0, 0),
  spreadRadius: -5.0,
  blurRadius: 10.0,
  offset: const Offset(0.0, 10.0),
);
