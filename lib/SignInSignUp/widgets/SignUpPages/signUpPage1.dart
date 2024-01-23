import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/widgets/input.dart';

class SignUpPage1 extends StatefulWidget {
  const SignUpPage1({super.key});

  @override
  State<SignUpPage1> createState() => _SignUpPage1State();
}

class _SignUpPage1State extends State<SignUpPage1> {
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();

  Icon? passwordIcon;
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> inputs = [
      {
        'labelText': 'first name',
        'hintText': 'Peter',
        'controller': firstNameController,
        'icon': null,
        'password': false,
      },
      {
        'labelText': 'surname',
        'hintText': 'Pan',
        'controller': surnameController,
        'icon': null,
        'password': false,
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
