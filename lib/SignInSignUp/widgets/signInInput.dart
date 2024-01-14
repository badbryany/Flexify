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
  bool visible = true;
  Icon passwordIcon = const Icon(Icons.lock);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> inputs = [
      {
        'labelText': 'username',
        'hintText': 'e.g. Peter Pan',
        'hidden': false,
        'taped': false,
        'controller': username,
        'icon': const Icon(Icons.person),
      },
      {
        'labelText': 'password',
        'hintText': 'at least 6 signs',
        'hidden': visible,
        'taped': false,
        'controller': password,
        'icon': passwordIcon,
      },
    ];

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...inputs.map(
            (e) => SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Input(
                labelText: e['labelText'],
                hintText: e['hintText'],
                hidden: e['hidden'],
                controller: e['controller'],
                icon: e['icon'],
                onTap: () {
                  passwordIcon = const Icon(Icons.visibility);
                  setState(() {});
                },
                onTapOutside: (PointerDownEvent) {
                  passwordIcon = const Icon(Icons.lock);
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
