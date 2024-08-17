import 'package:flexify/pages/dShop/pages/widgets/ShopNavbar.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:shared_preferences/shared_preferences.dart';

class LockerNumberPage extends StatefulWidget {
  const LockerNumberPage({
    super.key,
    required this.setLockerNumber,
  });

  final Function setLockerNumber;

  @override
  State<LockerNumberPage> createState() => _LockerNumberPageState();
}

class _LockerNumberPageState extends State<LockerNumberPage> {
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

  getNumberButton(int number) {
    return Container(
      decoration: BoxDecoration(
        color: global.darkGrey,
        borderRadius: BorderRadius.circular(1000),
      ),
      child: Text(
        number.toString(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    getNumberButton(int number) {
      return BounceElement(
        onTap: () => setLocker(number),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: global.darkGrey,
            borderRadius: BorderRadius.circular(30),
            boxShadow: global.shadow(context),
          ),
          child: Text(
            '$number',
            style: TextStyle(
              color: Colors.white,
              fontSize: global.width(context) * .15,
            ),
          ),
        ),
      );
    }

    getNumberRow(List<int> numbers) {
      return SizedBox(
        height:
            (global.containerWidth(context) - global.height(context) * .05) *
                (1 / 3),
        width: global.containerWidth(context),
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: getNumberButton(numbers.elementAt(0)),
            ),
            SizedBox(
              width: global.height(context) * .025,
            ),
            Flexible(
              flex: 1,
              child: getNumberButton(numbers.elementAt(1)),
            ),
            SizedBox(
              width: global.height(context) * .025,
            ),
            Flexible(
              flex: 1,
              child: getNumberButton(numbers.elementAt(2)),
            )
          ],
        ),
      );
    }

    SizedBox bottomRow = SizedBox(
      height: (global.containerWidth(context) - global.height(context) * .05) *
          (1 / 3),
      width: global.containerWidth(context),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: BounceElement(
              onTap: () {
                widget.setLockerNumber(int.parse(lockerNumber));
                Navigator.pop(context);
              },
              child: Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: global.darkGrey,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: global.shadow(context),
                ),
                child: global.gradient(
                  Icon(
                    CupertinoIcons.checkmark_alt,
                    size: global.width(context) * .1,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: global.height(context) * .025,
          ),
          Flexible(
            flex: 1,
            child: getNumberButton(0),
          ),
          SizedBox(
            width: global.height(context) * .025,
          ),
          Flexible(
            flex: 1,
            child: BounceElement(
              onTap: () => deleteDigit(),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: global.darkGrey,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: global.shadow(context),
                ),
                child: global.gradient(
                  Icon(
                    CupertinoIcons.delete_left,
                    size: global.width(context) * .1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ShopNavbar(
              title: 'Locker',
              titleSize: global.width(context) * .1,
              alignmentWidth: global.width(context) * .125,
            ),
            global.largeHeight(context),
            Container(
              width: global.containerWidth(context),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: global.darkGrey,
                borderRadius: BorderRadius.circular(global.borderRadius - 10),
                boxShadow: global.shadow(context),
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
            global.largeHeight(context),
            Flexible(flex: 1, child: getNumberRow([1, 2, 3])),
            SizedBox(
              height: global.height(context) * .025,
            ),
            Flexible(flex: 1, child: getNumberRow([4, 5, 6])),
            SizedBox(
              height: global.height(context) * .025,
            ),
            Flexible(flex: 1, child: getNumberRow([7, 8, 9])),
            SizedBox(
              height: global.height(context) * .025,
            ),
            Flexible(flex: 1, child: bottomRow),
            SizedBox(
              height: global.height(context) * .025,
            ),
          ],
        ),
      ),
    );
  }
}
