import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/widgets/input.dart';

class SignUp2 extends StatefulWidget {
  const SignUp2({super.key});

  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visible = true;

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
