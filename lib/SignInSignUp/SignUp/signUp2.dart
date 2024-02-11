import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/widgets/input.dart';

class SignUp2 extends StatefulWidget {
  const SignUp2({
    super.key,
    required this.usernameController,
    required this.passwordController,
  });
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
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
        'controller': widget.usernameController,
        'icon': null,
        'password': false,
      },
      {
        'labelText': 'password',
        'hintText': 'at least 6 signs',
        'controller': widget.passwordController,
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
              hintText: e['hintText'],
              controller: e['controller'],
              icon: IconButton(
                onPressed: () {
                  if (visible) {
                    visible = false;
                  } else {
                    visible = true;
                  }
                  setState(() {});
                },
                icon: e['icon'],
              ),
              textInputType: TextInputType.text,
            ),
          ),
        ],
      ),
    );
  }
}
