import 'package:flexify/pages/dWorkout/lockernumber/widgets/Numberfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:shared_preferences/shared_preferences.dart';

class Lockernumber extends StatefulWidget {
  const Lockernumber({super.key});

  @override
  State<Lockernumber> createState() => _LockernumberState();
}

class _LockernumberState extends State<Lockernumber> {
  String lockerNumber = '1';

  saveLocker() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lockerNumber', lockerNumber);
  }

  getLocker() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('lockerNumber') == null) {
      prefs.setString('lockerNumber', '1');
    }
    lockerNumber = prefs.getString('lockerNumber')!;
    setState(() {});
  }

  setLocker(int digit) {
    if (lockerNumber.length == 5) return;

    lockerNumber += digit.toString();
    setState(() {});

    saveLocker();
  }

  deleteDigit() {
    lockerNumber = lockerNumber.substring(0, lockerNumber.length - 1);
    if (lockerNumber.isEmpty) {
      lockerNumber = '1';
    }
    setState(() {});
    saveLocker();
  }

  @override
  void initState() {
    getLocker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: global.width(context) * .05,
              left: global.width(context) * .05,
              child: IconButton(
                icon: Icon(
                  CupertinoIcons.arrow_left,
                  color: Theme.of(context).focusColor,
                  size: global.width(context) * .07,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: global.height(context) * .125,
              child: Center(
                child: Text(
                  'Note your locker number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).focusColor.withOpacity(.5),
                    fontSize: global.width(context) * .06,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: (global.height(context) + global.width(context)) * .03,
              left: 0,
              right: 0,
              child: Numberfield(
                onEnter: setLocker,
                onDelete: deleteDigit,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: global.height(context) * .225,
              child: Column(
                children: [
                  Container(
                    width: global.width(context) * .75,
                    padding: !global.isDarkMode(context)
                        ? const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10)
                        : null,
                    decoration: !global.isDarkMode(context)
                        ? BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(global.borderRadius - 10),
                            color: Theme.of(context).colorScheme.background,
                          )
                        : null,
                    child: global.gradient(Text(
                      lockerNumber,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).focusColor,
                        fontSize: global.width(context) * .2,
                      ),
                    )),
                  ),
                  Visibility(
                    visible: global.isDarkMode(context),
                    child: Container(
                      height: 2,
                      width: global.width(context) * .75,
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
