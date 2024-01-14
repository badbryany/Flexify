import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/widgets/input.dart';

class SignInInput extends StatefulWidget {
  const SignInInput({super.key});

  @override
  State<SignInInput> createState() => _SignInInputState();
}

class _SignInInputState extends State<SignInInput> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  Icon? passwordIcon;
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> inputs = [
      {
        'labelText': 'username',
        'hintText': 'e.g. Peter Pan',
        'controller': username,
        'icon': null,
        'password': false,
      },
      {
        'labelText': 'password',
        'hintText': 'at least 6 signs',
        'controller': password,
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
