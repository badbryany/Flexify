import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/pages/dProfile/pages/AddFriends.dart';
import 'package:flexify/pages/dProfile/pages/QRScanner.dart';
import 'package:flexify/pages/dProfile/widgets/SmallQRWidget.dart';
import 'package:flexify/widgets/ModalBottomSheet.dart';
import 'package:flutter/material.dart';

ModalBottomSheet modalBottomSheet(BuildContext context, String data) =>
    ModalBottomSheet(
      title: 'Connect with Friends',
      titleSize: global.width(context) * .075,
      height: global.height(context) * .525,
      content: SmallQRWidget(data: data),
      submitButtonText: 'manual',
      onPop: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddFriends()),
      ),
      extraButtonTitle: 'Scan QR-Code',
      extraButtonOnTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const QRScanner(),
        ),
      ),
    );
