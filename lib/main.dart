import 'package:flutter/material.dart';

import 'package:flexify/pages/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        focusColor: Colors.white,
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color.fromARGB(255, 208, 255, 222),
          onPrimary: Color.fromARGB(255, 0, 0, 0),
          secondary: Color.fromARGB(255, 84, 84, 84),
          onSecondary: Color.fromARGB(255, 0, 0, 0),
          error: Colors.red,
          onError: Color.fromARGB(255, 0, 0, 0),
          background: Color.fromARGB(255, 55, 54, 54),
          onBackground: Color.fromARGB(255, 0, 0, 0),
          surface: Color.fromARGB(255, 44, 44, 44),
          onSurface: Color.fromARGB(255, 0, 0, 0),
        ),
        fontFamily: 'JosefinSans',
      ),
      home: const Dashboard(),
    );
  }
}
