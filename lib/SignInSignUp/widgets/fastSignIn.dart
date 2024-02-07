import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/widgets/button.dart';

class FastSignin extends StatefulWidget {
  const FastSignin({super.key});

  @override
  State<FastSignin> createState() => _FastSigninState();
}

class _FastSigninState extends State<FastSignin> {
  List<Map<String, dynamic>> fastSignIn = [
    {
      'image': 'assets/icon/google.png',
    },
    {
      'image': 'assets/icon/apple2.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...fastSignIn.map(
            (e) => Row(
              children: [
                ImageButton(
                  onTap: () {},
                  image: Image.asset(
                    e['image'],
                    scale: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
