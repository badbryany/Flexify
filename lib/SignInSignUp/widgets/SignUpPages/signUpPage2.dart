import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/widgets/input.dart';

class SignUpPage2 extends StatefulWidget {
  const SignUpPage2({super.key});

  @override
  State<SignUpPage2> createState() => _SignUpPage2State();
}

class _SignUpPage2State extends State<SignUpPage2> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Icon? passwordIcon;
  bool visible = false;
  @override
  Widget build(BuildContext context) {
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

    if (visible) {
      passwordIcon = Icon(
        Icons.visibility,
        color: Theme.of(context).colorScheme.onBackground,
      );
    } else {
      passwordIcon = Icon(
        Icons.visibility_off,
        color: Theme.of(context).colorScheme.onBackground,
      );
    }

    if (visible) {
      passwordIcon = Icon(
        Icons.visibility,
        color: Theme.of(context).colorScheme.onBackground,
      );
    } else {
      passwordIcon = Icon(
        Icons.visibility_off,
        color: Theme.of(context).colorScheme.onBackground,
      );
    }

    return SizedBox(
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
    );
  }
}
