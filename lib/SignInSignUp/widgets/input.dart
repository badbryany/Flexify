import 'package:flexify/data/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/widgets/shadow.dart';

class Input extends StatelessWidget {
  const Input(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.controller,
      required this.onTap,
      this.icon,
      required this.password});
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final Icon? icon;
  final Function() onTap;
  final bool password;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: containerPadding,
        right: containerPadding,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Shadow(
              borderRadius: borderRadius,
              child: TextFormField(
                onTap: () {},
                textInputAction: TextInputAction.done,
                obscureText: password,
                cursorColor: Theme.of(context).colorScheme.background,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.background,
                ),
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  labelText: labelText,
                  contentPadding: const EdgeInsets.only(
                    left: 15,
                    bottom: 10,
                  ),
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.background,
                  ),
                ),
              ),
            ),
            Container(
              alignment: const Alignment(0.9, 0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
                height: MediaQuery.of(context).size.height * 0.07,
                child: GestureDetector(
                  onTap: onTap,
                  child: icon,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}