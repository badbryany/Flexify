import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/pages/dProfile/pages/QRScanner.dart';
import 'package:flexify/pages/dProfile/widgets/SmallQRWidget.dart';
import 'package:flexify/widgets/ModalBottomSheet.dart';
import 'package:flutter/material.dart';

ModalBottomSheet modalBottomSheet(BuildContext context, String data) =>
    ModalBottomSheet(
      title: 'Connect',
      titleSize: global.width(context) * .08,
      height: global.height(context) * .55,
      content: SmallQRWidget(data: data),
      submitButtonText: 'Scan',
      onPop: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const QRScanner()),
      ),
    );
