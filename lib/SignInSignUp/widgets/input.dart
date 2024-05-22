import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart';
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
  final IconButton? icon;
  final bool password;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7.5),
      height: global.height(context) * 0.1,
      width: global.width(context) * 0.9,
      child: Stack(
        children: [
          TextField(
            keyboardType: textInputType,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.surface,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius * 0.4),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius * 0.4),
              ),
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.onSurface,
              hintText: hintText,
              border: InputBorder.none,
            ),
            textInputAction: TextInputAction.next,
            obscureText: password,
            cursorColor: Theme.of(context).colorScheme.surface,
            controller: controller,
            style: TextStyle(
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          Visibility(
            visible: icon != null,
            child: Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(right: 20, bottom: 18),
              child: icon ?? const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
