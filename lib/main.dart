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
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.red,
          onPrimary: Colors.red,
          secondary: Colors.red,
          onSecondary: Colors.red,
          error: Colors.red,
          onError: Colors.red,
          background: const Color.fromRGBO(29, 29, 29, 1),
          onBackground: Colors.red,
          surface: Colors.red,
          onSurface: const Color.fromARGB(255, 37, 37, 37),
        ),
        fontFamily: 'JosefinSans',
      ),
      home: const Dashboard(),
    );
  }
}
