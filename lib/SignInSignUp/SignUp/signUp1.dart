import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/widgets/input.dart';

class SignUp1 extends StatefulWidget {
  const SignUp1({super.key});

  @override
  State<SignUp1> createState() => _SignUp1State();
}

class _SignUp1State extends State<SignUp1> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
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
      {
        'labelText': 'e-mail adress',
        'hintText': 'peter.pan@email.com',
        'controller': emailAddressController,
        'icon': null,
        'password': false,
      },
    ];

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
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
        ],
      ),
    );
  }
}
