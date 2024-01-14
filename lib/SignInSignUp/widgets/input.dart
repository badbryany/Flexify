import 'package:flexify/data/globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:flexify/SignInSignUp/models/shadow.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.hidden,
    required this.controller,
    required this.icon,
    required this.onTap,
    required this.onTapOutside,
  });
  final String labelText;
  final String hintText;
  final bool hidden;
  final TextEditingController controller;
  final Icon icon;
  final Function() onTap;
  final Function(PointerDownEvent) onTapOutside;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: containerPadding * 0.05,
        right: containerPadding * 0.05,
      ),
      child: Stack(
        children: [
          Shadow(
            borderRadius: borderRadius,
            child: TextFormField(
              onTap: onTap,
              onTapOutside: onTapOutside,
              cursorColor: Theme.of(context).colorScheme.background,
              style: TextStyle(
                color: Theme.of(context).colorScheme.background,
              ),
              controller: controller,
              obscureText: hidden,
              decoration: InputDecoration(
                suffixIcon: icon,
                hintText: hintText,
                border: InputBorder.none,
                labelText: labelText,
                contentPadding: const EdgeInsets.only(
                  left: 15,
                ),
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
