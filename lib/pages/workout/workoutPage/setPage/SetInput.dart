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
      color: Theme.of(context).scaffoldBackgroundColor,
      fontSize: 60,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
          child: Text(
            '$title:',
            style: TextStyle(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => controller.text = subtract(controller.text),
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
                  '-',
                  style: textStyle,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.42,
              height: MediaQuery.of(context).size.height * 0.1,
              child: TextFormField(
                style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontSize: 60,
                ),
                textAlign: TextAlign.center,
                controller: controller,
                cursorRadius: const Radius.circular(100),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            GestureDetector(
              onTap: () => controller.text = add(controller.text),
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
                  '+',
                  style: textStyle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
