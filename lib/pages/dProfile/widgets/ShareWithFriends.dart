import 'package:flexify/pages/dProfile/pages/QRScanner.dart';
import 'package:flexify/pages/dProfile/widgets/SmallQRWidget.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/widgets/ModalBottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class ShareWithFriends extends StatelessWidget {
  const ShareWithFriends({
    super.key,
    required this.username,
  });

  final String username;

  @override
  Widget build(BuildContext context) {
    return BounceElement(
      onTap: () => showCustomModalBottomSheet(
        context,
        ModalBottomSheet(
          title: 'Connect with Friends',
          titleSize: global.width(context) * .075,
          height: global.height(context) * .6,
          content: SmallQRWidget(data: username),
          submitButtonText: 'done',
          extraButtonTitle: 'Scan QR-Code',
          extraButtonOnTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const QRScanner(),
            ),
          ),
        ),
      ),
      child: Center(
        child: Container(
          width: global.width(context) * .75,
          height: global.height(context) * .075,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(global.borderRadius - 10),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.onPrimary,
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Connect with Friends',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: global.width(context) * .05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                CupertinoIcons.share,
                color: Colors.black,
                size: global.width(context) * .06,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
