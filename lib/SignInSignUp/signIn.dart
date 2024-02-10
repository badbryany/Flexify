import 'dart:convert';

import 'package:flexify/data/exerciseModels.dart';
import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/widgets/button.dart';
import 'package:flexify/SignInSignUp/widgets/background.dart';
import 'package:flexify/SignInSignUp/widgets/input.dart';
import 'package:flexify/data/globalVariables.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flexify/pages/dashboard.dart';
import 'package:flexify/data/globalVariables.dart' as global;

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
                      textInputType: TextInputType.text,
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
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.08,
              left: MediaQuery.of(context).size.width * 0.01,
            ),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
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
                String username = usernameController.text;
                String password = passwordController.text;

                SharedPreferences prefs = await SharedPreferences.getInstance();
                if (usernameController.text != '' &&
                    passwordController.text != '') {
                  http.Response res = await http.post(
                    Uri.parse(url),
                    body: {
                      'username': username,
                      'password': password,
                    },
                  );

                  print(res.body);

                  if (res.body == 'username or password is wrong') {
                    errorText = res.body;
                    setState(() {});
                    return;
                  }
                  prefs.setString('username', username);
                  prefs.setString('password', password);
                  prefs.setString('jwt', res.body);

                  await syncData();

                  Navigator.of(context).push(
                    PageTransition(
                      child: const Dashboard(),
                      type: PageTransitionType.fade,
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

syncData() async {
  await Save.clearData();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String url = '${global.host}/getExercises';

  http.Response res = await http.get(
    Uri.parse('$url?jwt=${prefs.getString('jwt')}'),
  );

  List notParsedExercises = jsonDecode(res.body);
  for (int i = 0; i < notParsedExercises.length; i++) {
    Save.saveExercise(Exercise(
      name: notParsedExercises[i][1],
      type: notParsedExercises[i][2],
      affectedMuscle: notParsedExercises[i][3],
      equipment: notParsedExercises[i][4],
      synced: 1,
    ));
  }

  url = '${global.host}/getSets';
  res = await http.get(
    Uri.parse('$url?jwt=${prefs.getString('jwt')}'),
  );
  print(res.body);
  List notParsedSets = jsonDecode(res.body);
  for (int i = 0; i < notParsedSets.length; i++) {
    print(notParsedSets[i][4]);
    Save.saveSet(Set(
      setID: notParsedSets[i][0],
      exerciseName: notParsedSets[i][1],
      reps: notParsedSets[i][2],
      weight: double.parse(notParsedSets[i][3].toString()),
      date: DateTime.parse(notParsedSets[i][4]),
      synced: 1,
    ));
  }
}
