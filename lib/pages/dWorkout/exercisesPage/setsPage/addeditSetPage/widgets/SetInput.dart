import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter/material.dart';

class SetInput extends StatelessWidget {
  SetInput({
    super.key,
    required this.title,
    required this.controller,
    required this.calcInterval,
    this.canBeNegative,
  });

  final String title;
  final TextEditingController controller;
  final double calcInterval;
  final bool? canBeNegative;

  final RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

  String add(String text) {
    double? num = double.tryParse(text.replaceAll(',', '.'));

    num ??= 8;
    String outputString = (num + calcInterval).toString();

    return outputString.replaceAll(regex, '');
  }

  String subtract(String text) {
    double? num = double.tryParse(text.replaceAll(',', '.'));

    if (num! <= 1 && (canBeNegative == false || canBeNegative == null)) {
      return num.toString().replaceAll(regex, '');
    }

    String outputString = (num - calcInterval).toString();

    return outputString.replaceAll(regex, '');
  }

  Widget setButton(BuildContext context, Function() onTap, String text) {
    bool continueCount = true;
    return BounceElement(
      onTap: () {},
      child: GestureDetector(
        onTapDown: (details) async {
          continueCount = true;
          while (continueCount) {
            onTap();
            await Future.delayed(const Duration(milliseconds: 100));
          }
        },
        onTapUp: (details) => continueCount = false,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            gradient: global.linearGradient,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Container(
            height: global.height(context) * 0.09,
            width: global.height(context) * 0.09,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: global.darkGrey,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(global.width(context) * 0.02),
      padding: EdgeInsets.symmetric(
          horizontal: global.width(context) * 0.025,
          vertical: global.height(context) * .02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(global.borderRadius),
        color: global.darkGrey,
        boxShadow: [global.darkShadow(context)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: global.height(context) * .01),
            decoration: BoxDecoration(
              color: global.lightGrey,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: global.width(context) * .05,
              ),
            ),
          ),
          SizedBox(
            height: global.height(context) * .02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              setButton(
                context,
                () => controller.text = subtract(controller.text),
                '-',
              ),
              SizedBox(
                width: global.width(context) * 0.35,
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 60,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  textAlign: TextAlign.center,
                  controller: controller,
                  cursorRadius: const Radius.circular(100),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              setButton(
                context,
                () => controller.text = add(controller.text),
                '+',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
