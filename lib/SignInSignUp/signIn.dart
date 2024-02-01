import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/widgets/button.dart';
import 'package:flexify/SignInSignUp/widgets/background.dart';
import 'package:flexify/SignInSignUp/widgets/input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController usernameInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();
  bool visible = true;
  bool? signedUp;

  @override
  void initState() {
    testSignedUp();
    super.initState();
  }

  void testSignedUp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('username') != null &&
        prefs.getString('password') != null &&
        prefs.getString('username') != '' &&
        prefs.getString('password') != '') {
      signedUp = true;
      prefs.setBool('signedUp', signedUp!);
    } else {
      signedUp = false;
      prefs.setBool('signedUp', signedUp!);
    }
    print(prefs.getBool('signedUp'));
  }

  void setUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', usernameInput.text);
    print(prefs.getString('username'));
  }

  void setPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('password', passwordInput.text);
    print(prefs.getString('password'));
  }

  @override
  Widget build(BuildContext context) {
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
        'controller': usernameInput,
        'icon': null,
        'password': false,
      },
      {
        'labelText': 'password',
        'hintText': 'at least 6 signs',
        'controller': passwordInput,
        'icon': passwordIcon,
        'password': visible,
      },
    ];

    testSignedUp();

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
                color: Theme.of(context).colorScheme.surface,
                fontSize: 30,
              ),
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
// button
          Container(
            alignment: Alignment.bottomCenter * 0.9,
            child: ButtonWithText(
              text: 'Sign In',
              onTap: () {
                if (usernameInput.toString() != '' &&
                    passwordInput.toString() != '' &&
                    passwordInput.toString().length > 5) {
                  setUsername();
                  setPassword();
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
