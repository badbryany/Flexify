import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter/material.dart';

class SetInput extends StatelessWidget {
  SetInput({
    super.key,
    required this.title,
    required this.controller,
    required this.calcInterval,
  });

  final String title;
  final TextEditingController controller;
  final double calcInterval;

  final RegExp regex = RegExp(r'([.]*0)(?!.*\d)');

  String add(String text) {
    double? num = double.tryParse(text.replaceAll(',', '.'));

    num ??= 8;
    String outputString = (num + calcInterval).toString();

    return outputString.replaceAll(regex, '');
  }

  String subtract(String text) {
    double? num = double.tryParse(text.replaceAll(',', '.'));

    if (num! <= 1) {
      return num.toString().replaceAll(regex, '');
    }

    String outputString = (num - calcInterval).toString();

    return outputString.replaceAll(regex, '');
  }

  Widget setButton(BuildContext context, Function() onTap, String text) {
    bool continueCount = true;
    return BounceElement(
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
          margin: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.09,
          width: MediaQuery.of(context).size.height * 0.09,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              width: 2,
              color: Theme.of(context).colorScheme.primary,
            ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.018),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(global.borderRadius),
        color: Theme.of(context).colorScheme.background,
        boxShadow: [global.darkShadow(context)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.width * 0.025,
            ),
            child: Text(
              '$title:',
              style: TextStyle(
                color: Theme.of(context).focusColor,
              ),
            ),
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
                width: MediaQuery.of(context).size.width * 0.35,
                // height: MediaQuery.of(context).size.height * 0.1,
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
