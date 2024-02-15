import 'package:flexify/data/exerciseModels.dart';
import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/widgets/button.dart';
import 'package:flexify/SignInSignUp/widgets/background.dart';
import 'package:flexify/SignInSignUp/SignUp/signUp1.dart';
import 'package:flexify/SignInSignUp/SignUp/signUp2.dart';
import 'package:flexify/pages/dashboard.dart';
import 'package:flexify/data/globalVariables.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Widget? refresh;
  int pageSwitch = 0;
  String nextButtonText = 'next';
  String url = '$host/signup';
  String errorText = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    if (pageSwitch == 0) {
      refresh = SignUp1(
        firstNameController: firstNameController,
        surnameController: surnameController,
        emailAddressController: emailAddressController,
      );
      nextButtonText = 'next';
    }
    if (pageSwitch == 1) {
      refresh = SignUp2(
        usernameController: usernameController,
        passwordController: passwordController,
      );
      nextButtonText = 'finish';
    }
    return Scaffold(
      body: Stack(
        children: [
// background
          const Background(),
// text
          Container(
            alignment: const Alignment(0, -0.3),
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: Theme.of(context).colorScheme.surface,
                fontSize: 30,
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
// SignUp page
          Container(
            alignment: const Alignment(1, 0.4),
            child: AnimatedSwitcher(
              duration: standardAnimationDuration,
              child: refresh,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: child,
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
              onPressed: () {
                if (pageSwitch == 0) {
                  Navigator.pop(context);
                } else {
                  pageSwitch = 0;
                }
                errorText = '';
                setState(() {});
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),

// next button
          Container(
            alignment: Alignment.bottomCenter * 0.9,
            child: ButtonWithText(
              text: nextButtonText,
              loading: loading,
              onTap: () async {
                if (nextButtonText == 'next') {
                  pageSwitch++;
                  setState(() {});
                  return;
                }

                loading = true;
                setState(() {});
                String username = usernameController.text;
                String password = passwordController.text;

                SharedPreferences prefs = await SharedPreferences.getInstance();
                if (usernameController.text != '' &&
                    passwordController.text != '' &&
                    passwordController.text.length > 5) {
                  final http.Response res = await http.post(
                    Uri.parse(url),
                    body: {
                      'username': usernameController.text,
                      'password': passwordController.text,
                      'firstname': firstNameController.text,
                      'surname': surnameController.text,
                      'email': emailAddressController.text,
                    },
                  );

                  print(res.body);

                  if (res.body == 'username already taken') {
                    errorText = res.body;
                    setState(() {});
                    return;
                  }

                  prefs.setString('username', username);
                  prefs.setString('password', password);
                  prefs.setString('firstname', firstNameController.text);
                  prefs.setString('surname', surnameController.text);

                  prefs.setString('jwt', res.body);

                  await Save.clearData();

                  loading = false;
                  setState(() {});

                  Navigator.of(context).push(
                    PageTransition(
                      child: const Dashboard(),
                      type: PageTransitionType.fade,
                    ),
                  );
                  return;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
