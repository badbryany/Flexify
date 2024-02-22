import 'package:flexify/SignInSignUp/choose.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/pages/intro/1_welcome.dart';
import 'package:flexify/pages/intro/2_gender.dart';
import 'package:flexify/pages/intro/8_schedule.dart';
import 'package:flutter/material.dart';
import 'package:flexify/pages/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter/services.dart';

checkLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('jwt', '');
  // prefs.setString('username', '');
  // prefs.setString('password', '');
  if (prefs.getString('username') == null ||
      prefs.getString('username') == '' ||
      prefs.getString('password') == null ||
      prefs.getString('password') == '') {
    return false;
  }
  return true;
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
  print(res.body);
  prefs.setString('jwt', res.body);
  return true;
}

void main() async {
  runApp(const MyApp(startWidget: Text('loading')));

  if (await checkLogin()) {
    login().then((value) => Save.syncData());
    runApp(const MyApp(
      startWidget: Dashboard(),
    ));
  } else {
    runApp(const MyApp(
      startWidget: Choose(),
    ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.startWidget,
  });

  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).colorScheme.background,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'KronaOne',
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
          onBackground: Colors.white,
          surface: Color(0xfff5f5fb),
          onSurface: Color.fromARGB(255, 37, 37, 37),
          outline: Color.fromARGB(255, 125, 185, 125),
          outlineVariant: Color.fromARGB(127, 125, 185, 125),
          shadow: Color.fromARGB(255, 170, 170, 170),
        ),
      ),
      // darkTheme: ThemeData(
      //   fontFamily: 'KronaOne',
      //   focusColor: Colors.white,
      //   scaffoldBackgroundColor: const Color.fromARGB(255, 17, 17, 17),
      //   canvasColor: const Color.fromARGB(255, 23, 23, 23),
      //   colorScheme: const ColorScheme(
      //     brightness: Brightness.dark,
      //     primary: Color(0xffa4fba4),
      //     onPrimary: Color(0xfff2f58d),
      //     secondary: Color.fromARGB(255, 214, 140, 55),
      //     onSecondary: Colors.red,
      //     error: Colors.red,
      //     onError: Colors.red,
      //     background: Color.fromARGB(255, 38, 38, 43),
      //     onBackground: Colors.white,
      //     surface: Color.fromARGB(255, 27, 27, 31),
      //     onSurface: Color.fromARGB(255, 37, 37, 37),
      //     outline: Color.fromARGB(255, 125, 185, 125),
      //     outlineVariant: Color.fromARGB(127, 125, 185, 125),
      //     shadow: Color.fromARGB(255, 170, 170, 170),
      //   ),
      // ),
      home: OneWelcome(),
    );
  }
}
