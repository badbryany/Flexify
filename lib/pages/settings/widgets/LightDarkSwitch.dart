import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LightDarkSwitch extends StatefulWidget {
  const LightDarkSwitch({super.key});

  @override
  State<LightDarkSwitch> createState() => _LightDarkSwitchState();
}

class _LightDarkSwitchState extends State<LightDarkSwitch> {
  bool darkMode = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(
          () {
            darkMode ? darkMode = false : darkMode = true;
          },
        );
      },
      child: Row(
        children: [
          Stack(
            alignment: darkMode ? Alignment.centerLeft : Alignment.centerRight,
            children: [
              Container(
                height: MediaQuery.of(context).size.width * 0.08,
                width: MediaQuery.of(context).size.width * 0.18,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  border: Border.all(
                      color: Theme.of(context).colorScheme.background,
                      width: 2,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(1000),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.08,
                width: MediaQuery.of(context).size.width * 0.12,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  border: Border.all(
                      width: 2,
                      color: Theme.of(context).colorScheme.background),
                  borderRadius:
                      BorderRadius.circular(MediaQuery.of(context).size.width),
                ),
                child: Center(
                  child: darkMode
                      ? Icon(
                          CupertinoIcons.moon_zzz,
                          color: Theme.of(context).colorScheme.background,
                          size: MediaQuery.of(context).size.width * 0.035,
                        )
                      : Icon(
                          CupertinoIcons.sun_haze_fill,
                          color: Theme.of(context).colorScheme.background,
                          size: MediaQuery.of(context).size.width * 0.035,
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
