import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    required this.hintText,
    required this.textInputType,
    required this.controller,
    this.icon,
  });
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController controller;
  final IconButton? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7.5),
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Stack(
        children: [
          TextField(
            keyboardType: textInputType,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
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
            cursorColor: Theme.of(context).colorScheme.onBackground,
            controller: controller,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          
        ],
      ),
    );
  }
}
