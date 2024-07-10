import 'package:flexify/pages/dWorkout/lockernumber/widgets/Numberfield.dart';
import 'package:flexify/widgets/Navbar.dart';
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
    if (lockerNumber == '0') lockerNumber = '';
    if (lockerNumber.length == 5) return;

    lockerNumber += digit.toString();
    setState(() {});

    saveLocker();
  }

  deleteDigit() {
    lockerNumber = lockerNumber.substring(0, lockerNumber.length - 1);
    if (lockerNumber.isEmpty) {
      lockerNumber = '0';
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
        child: Column(
          children: [
            Navbar(
              title: 'Locker',
              titleSize: global.width(context) * .1,
            ),
            global.largeHeight(context),
            global.largeHeight(context),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal:
                    (global.width(context) + global.height(context)) * .02275,
              ),
              width: global.containerWidth(context),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(global.borderRadius - 10),
                color: Theme.of(context).colorScheme.background,
              ),
              child: global.gradient(
                Text(
                  lockerNumber,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).focusColor,
                    fontSize: global.width(context) * .2,
                  ),
                ),
              ),
            ),
            global.mediumHeight(context),
            Numberfield(
              onEnter: setLocker,
              onDelete: deleteDigit,
            ),
          ],
        ),
      ),
    );
  }
}
