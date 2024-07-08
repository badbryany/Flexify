import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class Numberfield extends StatelessWidget {
  const Numberfield({
    super.key,
    required this.onEnter,
    required this.onDelete,
  });

  final void Function(int) onEnter;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: global.height(context) * .5,
      margin: EdgeInsets.symmetric(horizontal: global.width(context) * .05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...[
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9]
          ].map(
            (e) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: (e as List)
                  .map((el) => NumberButton(number: el, onTap: onEnter))
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NumberButton(
                number: 0,
                onTap: (foo) {},
                delete: true,
                deleteDigit: onDelete,
              ),
              NumberButton(number: 0, onTap: onEnter),
              NumberButton(
                number: 0,
                onTap: (foo) {},
                save: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NumberButton extends StatelessWidget {
  const NumberButton({
    super.key,
    required this.number,
    required this.onTap,
    this.delete,
    this.deleteDigit,
    this.save,
  });

  final Function(int) onTap;
  final int number;
  final bool? delete;
  final bool? save;
  final void Function()? deleteDigit;

  @override
  Widget build(BuildContext context) {
    return BounceElement(
        onTap: (delete == true || save == true)
            ? (save == true ? () => Navigator.pop(context) : deleteDigit)
            : () => onTap(number),
      child: Container(
        alignment: Alignment.center,
        height: global.width(context) * .25,
        width: global.width(context) * .25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(global.borderRadius + 10),
          color: Theme.of(context).colorScheme.background,
        ),
        child: delete == true || save == true
            ? global.gradient(Icon(
                save == true
                    ? CupertinoIcons.checkmark_alt
                    : CupertinoIcons.delete_left,
                size: global.width(context) * .075,
                color: Theme.of(context).colorScheme.onBackground,
              ))
            : Text(
                '$number',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: global.width(context) * .1,
                ),
              ),
      ),
    );
  }
}
