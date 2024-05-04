import 'package:flexify/pages/profile/widgets/QRScanner.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/cupertino.dart';
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(children: [
          SizedBox(
            height: global.height(context) * .03,
          ),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: global.width(context) * .05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: global.standardAnimationDuration,
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.005),
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
                AnimatedContainer(
                  duration: global.standardAnimationDuration,
                  width: global.width(context) * .6,
                  child: Text(
                    'Your QR Code',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: TextStyle(
                      color: Theme.of(context).focusColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                      fontSize: global.width(context) * 0.075,
                    ),
                  ),
                ),
                SizedBox(
                  width: global.width(context) * .14,
                )
              ],
            ),
          ),
          SizedBox(
            height: global.height(context) * .02,
          ),
          Container(
            width: global.width(context) * global.containerWidthFactor,
            height:
                global.width(context) * 1.35 + global.height(context) * 0.175,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(50),
              boxShadow: global.isDarkMode(context)
                  ? [global.darkShadow(context)]
                  : [global.lightShadow(context)],
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
                                fontSize:
                                    MediaQuery.of(context).size.width * .04,
                              ),
                            ),
                            SizedBox(
                              height: global.height(context) * .002,
                            ),
                            Text(
                              "@username",
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: global.height(context) * .02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            global.lightShadow(context),
                          ],
                        ),
                        child: QrImageView(
                          data: 'This QR code has an embedded image as well',
                          foregroundColor: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: global.height(context) * .05,
                      ),
                      BounceElement(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                  child: const QRScanner(),
                                  type: PageTransitionType.fade),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: global.height(context) * .1,
                            width: global.width(context),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(.7),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [global.darkShadow(context)]),
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
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

// CarouselSlider(
//                                 items: pannels,
//                                 carouselController: carouselController,
//                                 options: CarouselOptions(
//                                   onPageChanged: (index, reason) =>
//                                       setState(() => pageIndex = index),
//                                   viewportFraction: 1,
//                                   height: global.height(context) * .5,
//                                   enlargeCenterPage: true,
//                                   enlargeFactor: .25,
//                                   initialPage: pageIndex,
//                                   padEnds: true,
//                                   enableInfiniteScroll: false,
//                                   scrollPhysics: const BouncingScrollPhysics(),
//                                 ),
//                               ),
//                               AnimatedSmoothIndicator(
//                                 count: pannels.length,
//                                 activeIndex: pageIndex,
//                                 onDotClicked: (int index) =>
//                                     carouselController.animateToPage(
//                                   index,
//                                   duration: global.standardAnimationDuration,
//                                 ),
//                                 effect: WormEffect(
//                                   dotColor:
//                                       Theme.of(context).colorScheme.background,
//                                   activeDotColor:
//                                       Theme.of(context).colorScheme.primary,
//                                   spacing: 5,
//                                   dotHeight: global.width(context) * .025,
//                                   dotWidth: global.width(context) * .025,
//                                   type: WormType.thin,
//                                 ),
//                               ),
//                               SizedBox(height: global.height(context) * .005),
//                               ...setWidgetsBySetList(sets, context),
//                             ]