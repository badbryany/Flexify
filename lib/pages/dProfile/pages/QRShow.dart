import 'package:flexify/pages/dProfile/pages/QRScanner.dart';
import 'package:flexify/pages/dShop/pages/widgets/ShopNavbar.dart';
import 'package:flexify/widgets/LoadingImage.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:page_transition/page_transition.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRShow extends StatefulWidget {
  const QRShow({super.key});

  @override
  State<QRShow> createState() => _QRShowState();
}

class _QRShowState extends State<QRShow> {
  String username = '';

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    username = prefs.getString('username')!;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ShopNavbar(
              title: 'Your QR Code',
              titleSize: global.width(context) * .07,
              actionButton: ActionButton(
                iconData: Icons.qr_code_scanner_rounded,
                action: () => Navigator.push(
                  context,
                  PageTransition(
                    child: const QRScanner(),
                    type: PageTransitionType.fade,
                  ),
                ),
              ),
            ),
            Container(
              width: global.width(context) * global.containerWidthFactor,
              height: global.height(context) * .625,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(30),
                boxShadow: global.shadow(context),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(global.width(context) * .1),
                    child: Column(
                      children: [
                        Container(
                          height: global.height(context) * .1,
                          width: global.height(context) * .1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [global.darkShadow(context)],
                          ),
                          child: LoadingImage(
                            url:
                                'https://flexify.kellermann.team/api/getProfilePicture?username=${username.isNotEmpty ? username : '---'}',
                            width: global.height(context) * .1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(global.width(context) * .05),
                          child: global.gradient(
                            Text(
                              username,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: global.width(context) * .075,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: global.height(context) * .0075,
                        ),
                        Container(
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
                        ),
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
