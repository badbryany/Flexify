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
        fontFamily: 'JosefinSans',
        focusColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        canvasColor: const Color.fromARGB(255, 23, 23, 23),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xffa4fba4),
          onPrimary: Color(0xfff2f58d),
          secondary: Color.fromARGB(255, 214, 140, 55),
          onSecondary: Colors.red,
          error: Colors.red,
          onError: Colors.red,
          background: Color.fromARGB(255, 46, 46, 53),
          onBackground: Color.fromARGB(255, 117, 117, 137),
          surface: Color(0xfff5f5fb),
          onSurface: Color.fromARGB(255, 37, 37, 37),
          outline: Color.fromARGB(255, 125, 185, 125),
          outlineVariant: Color.fromARGB(127, 125, 185, 125),
          shadow: Color.fromARGB(255, 170, 170, 170),
        ),
      ),
      home: const Dashboard(),
    );
  }
}
