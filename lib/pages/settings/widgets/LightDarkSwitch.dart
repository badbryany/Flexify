import 'package:flexify/themeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LightDarkSwitch extends StatefulWidget {
  const LightDarkSwitch({super.key});

  @override
  State<LightDarkSwitch> createState() => _LightDarkSwitchState();
}

class _LightDarkSwitchState extends State<LightDarkSwitch> {
  List<ThemeMode> modes = [ThemeMode.dark, ThemeMode.light, ThemeMode.system];

  int themeModeIndex = -1;

  changeThemeMode() async {
    setState(() {
      themeModeIndex++;
      themeModeIndex = themeModeIndex % modes.length;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String modeString = 'dark';
    if (modes[themeModeIndex] == ThemeMode.light) {
      modeString = 'light';
    }
    if (modes[themeModeIndex] == ThemeMode.system) {
      modeString = 'system';
    }

    prefs.setString('themeMode', modeString);
    Provider.of<ThemeProvider>(
      context,
      listen: false,
    ).toggleTheme(modes[themeModeIndex]);
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    switch (prefs.getString('themeMode')) {
      case 'dark':
        themeModeIndex = 0;
        break;
      case 'light':
        themeModeIndex = 1;
        break;
      default:
        themeModeIndex = 2;
        break;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double totalWidth = global.width(context) * .2125;

    return GestureDetector(
      onTap: changeThemeMode,
      child: Stack(
        children: [
          Container(
            width: totalWidth,
            height: global.height(context) * .05,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).colorScheme.background,
              boxShadow: [global.darkShadow(context)],
            ),
          ),
          themeModeIndex == -1
              ? Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: global.loadingWidget(context, .4),
                )
              : AnimatedPositioned(
                  top: 0,
                  bottom: 0,
                  left: (totalWidth / modes.length * .6) * themeModeIndex,
                  duration: global.standardAnimationDuration * .75,
                  child: AnimatedSwitcher(
                    duration: global.standardAnimationDuration * .75,
                    child: Container(
                      key: ValueKey(themeModeIndex),
                      height: global.height(context) * .05,
                      width: totalWidth * .6,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(30),
                        border: Border.all(
                          width: 2,
                          color: Theme.of(context).colorScheme.background,
                        ),
                        color: global.darken(
                          Theme.of(context).colorScheme.onBackground,
                          .89,
                        ),
                      ),
                      child: Icon(
                        modes[themeModeIndex] == ThemeMode.dark
                            ? CupertinoIcons.moon
                            : (modes[themeModeIndex] == ThemeMode.light
                                ? CupertinoIcons.sun_max
                                : CupertinoIcons.settings),
                        color: Theme.of(context).colorScheme.onBackground,
                        size: global.width(context) * .05,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
