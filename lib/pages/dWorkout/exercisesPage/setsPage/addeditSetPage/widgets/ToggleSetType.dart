import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class ToggleSetType extends StatefulWidget {
  const ToggleSetType({
    super.key,
    required this.types,
    required this.onChange,
    required this.activeIndex,
  });

  final List<Map<String, dynamic>> types;
  final Function(int) onChange;
  final int activeIndex;

  @override
  State<ToggleSetType> createState() => _ToggleSetTypeState();
}

class _ToggleSetTypeState extends State<ToggleSetType> {
  int activeIndex = 0;

  toggleIndex(int newIndex) {
    widget.onChange(newIndex);
    setState(() => activeIndex = newIndex);
  }

  List<Widget> typeWidgets() {
    List<Widget> returnWidgets = [];

    for (int i = 0; i < widget.types.length; i++) {
      returnWidgets.add(
        GestureDetector(
          onTap: () => toggleIndex(i),
          child: SizedBox(
            width: (global.containerWidth(context) / widget.types.length),
            height: global.height(context) * .055,
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(
                horizontal: global.width(context) * .075,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    widget.types[i]['icon'],
                    size: global.width(context) * .05,
                    color: activeIndex == i
                        ? Colors.black
                        : Colors.white.withOpacity(.5),
                  ),
                  Text(
                    widget.types[i]['title'],
                    style: TextStyle(
                      fontSize: global.width(context) * .0375,
                      color: activeIndex == i
                          ? Colors.black
                          : Colors.white.withOpacity(.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return returnWidgets;
  }

  @override
  Widget build(BuildContext context) {
    activeIndex = widget.activeIndex;
    return Container(
      width: global.containerWidth(context),
      height: global.height(context) * .055,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Theme.of(context).colorScheme.background,
      ),
      child: Stack(
        children: [
          AnimatedPositioned(
            curve: Curves.easeInOutCirc,
            left: (global.containerWidth(context) / widget.types.length) *
                activeIndex,
            duration: global.standardAnimationDuration,
            child: Container(
              width: (global.containerWidth(context) / widget.types.length),
              height: global.height(context) * .055,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: global.linearGradient
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: typeWidgets(),
          ),
        ],
      ),
    );
  }
}
