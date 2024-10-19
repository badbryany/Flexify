import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/signUp.dart';
import 'package:flexify/SignInSignUp/widgets/LoadingButton.dart';
import 'package:flexify/data/exerciseModels.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flexify/pages/dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  List<Map<String, dynamic>> inputs = [
    {
      'title': 'username',
      'icon': const Icon(Icons.person),
      'controller': TextEditingController(),
      'obscure': false,
    },
    {
      'title': 'password',
      'icon': const Icon(Icons.key),
      'controller': TextEditingController(),
      'obscure': true,
    }
  ];

  String errorText = '';
  bool visible = true;
  bool loading = false;
  String url = '${global.host}/signin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.centerRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.onPrimary,
                ],
              )),
            ),
            Stack(
              children: [
                ClipPath(
                  clipper: BezierClipper(),
                  child: Container(
                    color: global.isDarkMode(context)
                        ? Theme.of(context).scaffoldBackgroundColor
                        : Colors.black,
                    height: global.height(context) * .8,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: global.height(context) * 0.05),
                  width: global.width(context),
                  child: Text(
                    'SIGN IN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: global.width(context) * 0.1,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                )
              ],
            ),
            Center(
              child: Container(
                width: global.width(context) * global.containerWidthFactor,
                height: global.height(context) * 0.65,
                decoration: BoxDecoration(
                    color: global.isDarkMode(context)
                        ? Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(.8)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(global.borderRadius),
                    boxShadow: global.isDarkMode(context)
                        ? []
                        : [global.darkShadow(context)]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...inputs.map(
                      (e) => Container(
                        width: global.width(context) * .8,
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.background,
                          borderRadius:
                              BorderRadius.circular(global.borderRadius - 10),
                        ),
                        child: TextField(
                          obscureText: e['obscure'],
                          controller: e['controller'],
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: e['icon'],
                            prefixIconColor:
                                Theme.of(context).colorScheme.onBackground,
                            labelText: e['title'],
                            labelStyle: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(.3),
                            ),
                            border: InputBorder.none,
                          ),
                          cursorColor:
                              Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      duration: global.standardAnimationDuration,
                      opacity: errorText == '' ? 0 : 1,
                      child: AnimatedContainer(
                        duration: global.standardAnimationDuration,
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        height:
                            errorText == '' ? 0 : global.height(context) * .025,
                        child: Text(
                          errorText,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: global.width(context) * 0.04,
                          ),
                        ),
                      ),
                    ),
                    LoadingButton(
                      title: 'SIGN IN',
                      loading: loading,
                      onTap: () async {
                        if (loading) return;

                        errorText = '';
                        loading = true;
                        setState(() {});

                        String username = inputs[0]['controller'].text;
                        String password = inputs[1]['controller'].text;
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        if (username != '' && password != '') {
                          http.Response res = await http.post(
                            Uri.parse(url),
                            body: {
                              'username': username,
                              'password': password,
                            },
                          );

                          print(res.body);

                          if (res.body == 'Username or password is incorrect') {
                            errorText = res.body;
                            loading = false;
                            loading = false;

                            setState(() {});
                            return;
                          }

                          dynamic body = jsonDecode(res.body);

                          prefs.setString('username', username);
                          prefs.setString('password', password);
                          prefs.setString('jwt', body['jwt']);
                          prefs.setString('email', body['email']);
                          prefs.setString('firstname', body['firstname']);

                          await syncData();

                          loading = false;
                          setState(() {});

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const PopScope(
                                canPop: false,
                                child: Dashboard(),
                              ),
                            ),
                          );
                          return;
                        }
                        errorText = 'Some of the inputs are empty.';
                        loading = false;
                        setState(() {});
                      },
                    ),
                    SizedBox(height: global.height(context) * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: global.width(context) * 0.1,
                          height: 1,
                          color: Theme.of(context).focusColor,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: global.width(context) * 0.025,
                            vertical: 0,
                          ),
                          child: Text(
                            'or continue with',
                            style: TextStyle(
                              color: Theme.of(context).focusColor,
                            ),
                          ),
                        ),
                        Container(
                          width: global.width(context) * 0.1,
                          height: 1,
                          color: Theme.of(context).focusColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: global.height(context) * 0.0425,
                    ),
                    ...[
                      {
                        'title': 'Continue with Apple',
                        'icon': Transform.scale(
                          scale: 1.1,
                          child: Image.asset(
                            'assets/icon/apple.png',
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      },
                      {
                        'title': 'Continue with Google',
                        'icon': Image.asset(
                          'assets/icon/google.png',
                          // scale: 27,
                        ),
                      },
                    ].map(
                      (e) => Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        alignment: Alignment.center,
                        width: global.width(context) * .8,
                        height: global.height(context) * 0.05,
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(1000),
                            boxShadow: [global.lightShadow(context)]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            e['title'] == 'Continue with Google'
                                ? SizedBox(
                                    width: global.width(context) * 0.012,
                                  )
                                : const SizedBox(),
                            SizedBox(
                              width: global.width(context) * .05,
                              child: e['icon'] as Widget,
                            ),
                            Text(
                              e['title'] as String,
                              style: TextStyle(
                                letterSpacing: -0.5,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                fontSize: global.width(context) * 0.03,
                              ),
                            ),
                            const SizedBox(),
                            const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: global.height(context) * 0.01),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).focusColor,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.7),
                            fontSize: global.width(context) * .04,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PopScope(
                                canPop: false,
                                child: SignUp(),
                              ),
                            ),
                          ),
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).focusColor,
                              fontSize: global.width(context) * .04,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
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
  print('fixme!!!!!');
  List notParsedSets = jsonDecode(res.body);
  for (int i = 0; i < notParsedSets.length; i++) {
    print(notParsedSets[i][4]);
    Save.saveSet(
      Set(
        setID: notParsedSets[i][0],
        exerciseName: notParsedSets[i][1],
        reps: notParsedSets[i][2],
        weight: double.parse(notParsedSets[i][3].toString()),
        date: DateTime.parse(notParsedSets[i][4]),
        durationInSeconds: 0, // ! FIXME
        isBodyweight: false, // ! FIXME
        isDuration: false, // ! FIXME
        synced: 1,
      ),
      notParsedSets[i][0],
    );
  }
}

class BezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.75);

    path.quadraticBezierTo(size.width * 0.25, size.height * 0.5,
        size.width * 0.5, size.height * 0.75);
    //
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 1, size.width, size.height * 0.75);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
