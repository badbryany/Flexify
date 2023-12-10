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
        focusColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xffa4fbbc),
          onPrimary: Color(0xfff2f58d),
          secondary: Colors.red,
          onSecondary: Colors.red,
          error: Colors.red,
          onError: Colors.red,
          background: const Color(0xff27272d),
          onBackground: Colors.red,
          surface: Color(0xfff5f5fb),
          onSurface: const Color.fromARGB(255, 37, 37, 37),
        ),
        fontFamily: 'JosefinSans',
      ),
      home: const Dashboard(),
    );
  }
}
