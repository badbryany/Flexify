import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.keaboardType,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputType? keaboardType;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Center(
        child: TextFormField(
          autocorrect: false,
          controller: controller,
          keyboardType: keaboardType,
          style: TextStyle(
            color: Theme.of(context).focusColor,
          ),
          cursorColor: Theme.of(context).focusColor,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              color: Theme.of(context).focusColor.withOpacity(0.4),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
