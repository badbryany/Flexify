import 'package:carousel_slider/carousel_slider.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/pages/dProfile/widgets/PRTimeline.dart';
import 'package:flexify/pages/dProfile/widgets/Photos.dart';
import 'package:flexify/pages/dProfile/widgets/UserInfo.dart';
import 'package:flexify/pages/dProfile/widgets/Activity.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DashboardProfile extends StatefulWidget {
  const DashboardProfile({super.key});

  @override
  State<DashboardProfile> createState() => _DashboardProfileState();
}

class _DashboardProfileState extends State<DashboardProfile> {
  CarouselController carouselController = CarouselController();
  List<Widget> carouselItems = [
    const Activity(),
    const Photos(),
    PRTimeline(
      tileHeightFactor: .1,
      tileWidthFactor: global.containerWidthFactor / 8,
    ),
  ];
  PageController pageController = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const UserInfo(),
        SizedBox(
          height: global.height(context) * .02,
        ),
        CarouselSlider(
          items: carouselItems,
          carouselController: carouselController,
          options: CarouselOptions(
            onPageChanged: (index, reason) => setState(() => pageIndex = index),
            viewportFraction: 1,
            height: global.height(context) * .42,
            enlargeCenterPage: true,
            enlargeFactor: .25,
            initialPage: pageIndex,
            padEnds: true,
            enableInfiniteScroll: false,
            scrollPhysics: const BouncingScrollPhysics(),
          ),
        ),
        AnimatedSmoothIndicator(
          count: carouselItems.length,
          activeIndex: pageIndex,
          onDotClicked: (int index) => carouselController.animateToPage(
            index,
            duration: global.standardAnimationDuration,
          ),
          effect: WormEffect(
            dotColor: Theme.of(context).focusColor.withOpacity(.8),
            activeDotColor: Theme.of(context).colorScheme.primary,
            spacing: 5,
            dotHeight: global.width(context) * .025,
            dotWidth: global.width(context) * .025,
            type: WormType.thin,
          ),
        )
      ],
    );
  }
}
