import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

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
      child: PrettyQr(
        data: data,
        size: global.width(context) * .6,
        roundEdges: true,
        elementColor: Theme.of(context).colorScheme.onBackground,
        image: const AssetImage('assets/logo/darklogo.png'),
        // decoration: PrettyQrDecoration(
        //   image: const PrettyQrDecorationImage(
        //     image: AssetImage('assets/logo/darklogo.png'),
        //   ),
        //   // background: Theme.of(context).colorScheme.onBackground,
        // ((conte))),
      ),
    );
  }
}

/*QrImageView(
        size: global.height(context) * .25,
        data: data,
        embeddedImage: AssetImage('assets/logo/darklogoBG.png'),
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        version: QrVersions.auto,
      ),
    ) */