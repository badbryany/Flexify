import 'dart:convert';

import 'package:flexify/SignInSignUp/signIn.dart';
import 'package:flexify/themeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flexify/pages/dashboard.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:provider/provider.dart';

Future<bool> checkLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  return !(prefs.getString('username') == null ||
      prefs.getString('username') == '' ||
      prefs.getString('password') == null ||
      prefs.getString('password') == '');
}

Future<bool> login() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final http.Response res = await http.post(
    Uri.parse('${global.host}/signin'),
    body: {
      'username': prefs.getString('username'),
      'password': prefs.getString('password'),
    },
  );

  dynamic data = jsonDecode(res.body);

  prefs.setString('jwt', data['jwt']);
  prefs.setString('email', data['email']);
  prefs.setString('firstname', data['firstname']);

  return true;
}

Future<ThemeMode> getThemeMode() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  switch (prefs.getString('themeMode')) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ThemeProvider themeProvider = ThemeProvider();
  bool isLoggedIn = await checkLogin();

  runApp(
    ChangeNotifierProvider(
      create: (context) => themeProvider,
      child: MyApp(
        startWidget: isLoggedIn ? const Dashboard() : const SignIn(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.startWidget,
  });

  final Widget startWidget;

  Future<bool> _initializeApp() async {
    return await checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvier, child) {
        return MaterialApp(
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(.7),
              ),
              child: child!,
            );
          },
          debugShowCheckedModeBanner: false,
          themeMode: themeProvier.themeMode,
          theme: ThemeData(
            fontFamily: 'KronaOne',
            focusColor: Colors.black,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 0,
            ),
            canvasColor: const Color.fromARGB(255, 23, 23, 23),
            brightness: Brightness.light,
            colorScheme: const ColorScheme(
              brightness: Brightness.light,
              primary: Color(0xffa4fba4),
              onPrimary: Color(0xfff2f58d),
              secondary: Color.fromARGB(255, 214, 140, 55),
              onSecondary: Colors.red,
              error: Colors.red,
              onError: Colors.red,
              background: Color.fromARGB(255, 26, 26, 29),
              onBackground: Colors.white,
              surface: Color.fromARGB(255, 38, 38, 43),
              onSurface: Colors.white,
              outline: Color.fromARGB(255, 125, 185, 125),
              outlineVariant: Color.fromARGB(127, 125, 185, 125),
              shadow: Color.fromARGB(255, 170, 170, 170),
            ),
          ),
          darkTheme: ThemeData(
            fontFamily: 'KronaOne',
            focusColor: Colors.white,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              backgroundColor: Colors.black,
              elevation: 0,
              toolbarHeight: 0,
            ),
            canvasColor: const Color.fromARGB(255, 23, 23, 23),
            brightness: Brightness.dark,
            colorScheme: const ColorScheme(
              brightness: Brightness.dark,
              primary: Color(0xffa4fba4),
              onPrimary: Color(0xfff2f58d),
              secondary: Color.fromARGB(255, 214, 140, 55),
              onSecondary: Colors.red,
              error: Colors.red,
              onError: Colors.red,
              background: Color.fromARGB(255, 38, 38, 43),
              onBackground: Colors.white,
              surface: Color.fromARGB(255, 26, 26, 29),
              onSurface: Colors.white,
              outline: Color.fromARGB(255, 125, 185, 125),
              outlineVariant: Color.fromARGB(127, 125, 185, 125),
              shadow: Color.fromARGB(255, 170, 170, 170),
            ),
          ),
          home: FutureBuilder(
            future: _initializeApp(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                bool isLoggedIn = snapshot.data as bool;
                return isLoggedIn ? const Dashboard() : const SignIn();
              }
            },
          ),
        );
      },
    );
  }
}
