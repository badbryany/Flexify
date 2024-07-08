import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SmallQRWidget extends StatelessWidget {
  const SmallQRWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [global.lightShadow(context)],
        color: Colors.black,
      ),
      child: QrImageView(
        size: global.height(context) * .3,
        data: 'This QR code has an embedded image as well',
        foregroundColor: Colors.white,
        version: QrVersions.auto,
      ),
    );
  }
}
