import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

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

    if (num != null && num <= 1) {
      return num.toString().replaceAll(regex, '');
    }

    num ??= 8;
    String outputString = (num - calcInterval).toString();

    return outputString.replaceAll(regex, '');
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: Theme.of(context).focusColor,
      fontSize: MediaQuery.of(context).size.width * 0.1,
    );
    return Container(
      width: MediaQuery.of(context).size.width *
                        global.containerWidthFactor,
      decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(global.borderRadius),
                      boxShadow: [global.lightShadow],
                    ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
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
              Center(
                child: GestureDetector(
                  onTap: () => controller.text = subtract(controller.text),
                  child: Container(
                    margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.001),
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.height * 0.04,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      '-',
                      style: textStyle,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.42,
                  height: MediaQuery.of(context).size.height * 0.1,
                  alignment: Alignment.center,
                  child: TextFormField(
                    style: TextStyle(
                      color: Theme.of(context).focusColor,
                      fontSize: MediaQuery.of(context).size.width * 0.1,
                    ),
                    textAlign: TextAlign.center,
                    controller: controller,
                    cursorRadius: const Radius.circular(100),
                    cursorColor: Theme.of(context).focusColor,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => controller.text = add(controller.text),
                child: Container(
                  margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.001),
                  height: MediaQuery.of(context).size.height * 0.06,
                  width: MediaQuery.of(context).size.height * 0.04,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    '+',
                    style: textStyle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
