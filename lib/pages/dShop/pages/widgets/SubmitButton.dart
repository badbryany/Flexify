import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(global.width(context) * .005),
      alignment: Alignment.center,
      width: global.containerWidth(context),
      height: global.height(context) * .075,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 26, 26, 29),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [global.darkShadow(context)]
      ),
      child: global.gradient(
        Text(
          'Submit',
          style: TextStyle(
            fontSize: global.width(context) * .07,
          ),
        ),
      ),
    );
  }
}
