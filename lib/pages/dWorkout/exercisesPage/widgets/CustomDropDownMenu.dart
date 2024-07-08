import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class CustomDropDownMenu extends StatefulWidget {
  const CustomDropDownMenu({
    super.key,
    required this.initialValue,
    required this.values,
    required this.onChange,
  });

  final String initialValue;
  final List<String> values;
  final void Function(String) onChange;

  @override
  State<CustomDropDownMenu> createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  String value = '';

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: global.standardAnimationDuration * 2,
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);

    value = widget.initialValue;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool open = false;

  toggleOpen() {
    setState(() => open = !open);
    if (open)
      controller.forward();
    else
      controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: toggleOpen,
        child: AnimatedContainer(
          curve: Curves.easeInOut,
          duration: global.standardAnimationDuration,
          width: global.containerWidth(context),
          height: global.height(context) * .075 +
              (open ? global.height(context) * .042 * widget.values.length : 0),
          padding: EdgeInsets.symmetric(
            horizontal: global.width(context) * .1,
            vertical: global.width(context) * .05,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(global.borderRadius - 5),
          ),
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    global.gradient(AnimatedSwitcher(
                      duration: global.standardAnimationDuration,
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: animation.drive(
                            Tween(
                              begin: const Offset(1, 0),
                              end: const Offset(0, 0),
                            ),
                          ),
                          child: child,
                        ),
                      ),
                      child: Text(
                        value,
                        key: ValueKey(value),
                        style: TextStyle(
                          fontSize: global.width(context) * .05,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    )),
                    AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      progress: animation,
                      size: global.width(context) * .07,
                    ),
                  ],
                ),
                global.mediumHeight(context),
                AnimatedOpacity(
                  opacity: open ? 1 : 0,
                  duration: global.standardAnimationDuration,
                  child: SizedBox(
                    height: global.height(context) * .1 * widget.values.length,
                    child: GridView.count(
                      childAspectRatio: 2.25,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: global.width(context) * .02,
                      mainAxisSpacing: global.width(context) * .02,
                      crossAxisCount: 2,
                      children: [
                        for (String elem in widget.values)
                          if (elem != value)
                            GestureDetector(
                              onTap: () {
                                setState(() => value = elem);
                                widget.onChange(elem);
                                toggleOpen();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                  horizontal: global.width(context) * .05,
                                  vertical: global.width(context) * .025,
                                ),
                                margin: EdgeInsets.symmetric(
                                  vertical: global.width(context) * .0125,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      global.borderRadius - 5),
                                  color: Colors.black.withOpacity(.5),
                                ),
                                child: Text(
                                  elem,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: global.width(context) * .04,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                                ),
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
