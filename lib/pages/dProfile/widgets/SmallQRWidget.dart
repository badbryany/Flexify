import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SmallQRWidget extends StatelessWidget {
  const SmallQRWidget({
    super.key,
    required this.data,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [global.lightShadow(context)],
      ),
      child: QrImageView(
        size: global.height(context) * .25,
        data: data,
        embeddedImage: AssetImage('assets/logo/darklogoBG.png'),
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        version: QrVersions.auto,
      ),
    );
  }
}
