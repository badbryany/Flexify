import 'package:flexify/pages/dProfile/pages/QRScanner.dart';
import 'package:flexify/pages/dShop/pages/widgets/ShopNavbar.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:page_transition/page_transition.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRShow extends StatefulWidget {
  const QRShow({super.key});

  @override
  State<QRShow> createState() => _QRShowState();
}

class _QRShowState extends State<QRShow> {
  @override
  Widget build(BuildContext context) {
    BounceElement scanButton = BounceElement(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              child: const QRScanner(),
              type: PageTransitionType.fade,
            ),
          );
        },
        child: Container(
          alignment: Alignment.center,
          height: global.height(context) * .1,
          width: global.width(context),
          decoration: BoxDecoration(
            gradient: global.linearGradient,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [global.darkShadow(context)],
          ),
          child: Text(
            'Scan',
            style: TextStyle(
              fontSize: global.width(context) * .12,
              letterSpacing: -3,
              color: Colors.black.withOpacity(.8),
            ),
          ),
        ),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ShopNavbar(
              title: 'Your QR Code',
              titleSize: global.width(context) * .07,
            ),
            Container(
              width: global.width(context) * global.containerWidthFactor,
              height: global.height(context) * .7,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(50),
                boxShadow: global.shadow(context),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(
                      global.width(context) * .1,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: global.height(context) * .1,
                          height: global.height(context) * .1,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [global.darkShadow(context)]),
                        ),
                        SizedBox(
                          height: global.height(context) * .02,
                        ),
                        SizedBox(
                          height: global.height(context) * .05,
                          child: Column(
                            children: [
                              Text(
                                "Profile Name",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: global.width(context) * .04,
                                ),
                              ),
                              SizedBox(
                                height: global.height(context) * .002,
                              ),
                              global.gradient(
                                Text(
                                  "@username",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: global.height(context) * .0075,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              global.lightShadow(context),
                            ],
                          ),
                          child: QrImageView(
                            size: global.height(context) * .3,
                            data: 'This QR code has an embedded image as well',
                            foregroundColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: global.height(context) * .0225,
                        ),
                        scanButton
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
