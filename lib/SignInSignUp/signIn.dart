import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/widgets/button.dart';
import 'package:flexify/SignInSignUp/widgets/background.dart';
import 'package:flexify/SignInSignUp/widgets/input.dart';
import 'package:flexify/data/globalVariables.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    String url = '$host/signin';
    String errorText = '';
    Icon passwordIcon = visible
        ? Icon(
            Icons.visibility_off,
            color: Theme.of(context).colorScheme.onBackground,
          )
        : Icon(
            Icons.visibility,
            color: Theme.of(context).colorScheme.onBackground,
          );

    List<Map<String, dynamic>> inputs = [
      {
        'labelText': 'username',
        'hintText': 'e.g. Peter Pan',
        'controller': usernameController,
        'icon': null,
        'password': false,
      },
      {
        'labelText': 'password',
        'hintText': 'at least 6 signs',
        'controller': passwordController,
        'icon': passwordIcon,
        'password': visible,
      },
    ];

    return Scaffold(
      body: Stack(
        children: [
// background
          const Background(),
// text
          Container(
            alignment: const Alignment(0, -0.3),
            child: Text(
              'Sign In',
              style: TextStyle(
                fontSize: 30,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
// error text
          AnimatedContainer(
            duration: standardAnimationDuration,
            alignment: const Alignment(0, 0.63),
            child: Text(
              errorText,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
// input
          Container(
            alignment: const Alignment(1, 0.5),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...inputs.map(
                    (e) => Input(
                      password: e['password'],
                      labelText: e['labelText'],
                      hintText: e['hintText'],
                      controller: e['controller'],
                      icon: e['icon'],
                      onTap: () {
                        if (visible) {
                          visible = false;
                        } else {
                          visible = true;
                        }
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
// back button
          Container(
            alignment: Alignment.topLeft * 0.9,
            child: ButtonWithIcon(
              onTap: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
// sign in button
          Container(
            alignment: Alignment.bottomCenter * 0.9,
            child: ButtonWithText(
              text: 'Sign In',
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                if (usernameController.text != '' &&
                    passwordController.text != '') {
                  final http.Response res = await http.post(
                    Uri.parse(url),
                    body: {
                      'username': usernameController.text,
                      'password': passwordController.text,
                    },
                  );
                  print(res.body);
                  prefs.setString('jwt', res.body);
                  if (res.body != 'username or password is wrong') {
                    errorText = res.body;
                  }
                }
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }
}
