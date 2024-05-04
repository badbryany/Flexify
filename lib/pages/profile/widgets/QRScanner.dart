import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      // overlay: QrScannerOverlayShape(
      //     cutOutSize: global.width(context) * .8,
      //     borderWidth: 10,
      //     borderLength: 20,
      //     borderRadius: 30,
      //     borderColor: Theme.of(context).colorScheme.primary),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen(
      (barcode) {
        setState(
          () {
            this.barcode = barcode;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: global.height(context) * .03,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: global.width(context) * 0.05,
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: global.standardAnimationDuration,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.005),
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.width * 0.15,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [global.darkShadow(context)],
                    ),
                    child: IconButton(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Theme.of(context).colorScheme.onBackground,
                      icon: const Icon(Icons.arrow_back_rounded),
                      iconSize: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: global.height(context) * .02,
            ),
            buildQrView(context)
          ],
        ),
      ),
    );
  }
}
