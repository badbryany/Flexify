import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class Input extends StatelessWidget {
  const Input({
    super.key,
    required this.hintText,
    required this.textInputType,
    required this.controller,
    this.icon,
    required this.password,
  });
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController controller;
  final Icon? icon;
  final bool password;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: global.width(context) * .8,
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.25),
        borderRadius: BorderRadius.circular(global.borderRadius - 15),
      ),
      child: TextField(
        obscureText: password,
        controller: controller,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground,
        ),
        decoration: InputDecoration(
          prefixIcon: icon,
          prefixIconColor: Theme.of(context).colorScheme.onBackground,
          labelText: hintText,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(.3),
          ),
          border: InputBorder.none,
        ),
        cursorColor: Theme.of(context).colorScheme.onBackground,
      ),
    );
  }
}
