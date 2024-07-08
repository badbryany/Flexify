import 'package:carousel_slider/carousel_slider.dart';
import 'package:flexify/pages/dShop/data/shopData.dart';
import 'package:flexify/pages/dShop/pages/productPage/reviewsPage.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flexify/widgets/ModalBottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductPage extends StatefulWidget {
  final Item item;

  const ProductPage({super.key, required this.item});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  CarouselController carouselController = CarouselController();
  List<Widget> carouselItems = [
    const Center(
      child: Text(
        'Product Pic 1',
        style: TextStyle(color: Colors.white),
      ),
    ),
    const Center(
      child: Text(
        'Product Pic 2',
        style: TextStyle(color: Colors.white),
      ),
    ),
    const Center(
      child: Text(
        'Product Pic 3',
        style: TextStyle(color: Colors.white),
      ),
    )
  ];
  PageController pageController = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            global.width(context) * .025,
          ),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              ProductNavbar(
                item: widget.item,
              ),
              global.mediumHeight(context),
              Container(
                clipBehavior: Clip.hardEdge,
                padding: EdgeInsets.all(global.width(context) * .1),
                width: global.containerWidth(context),
                height: global.height(context) * .4,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 26, 26, 29),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CarouselSlider(
                      items: carouselItems,
                      carouselController: carouselController,
                      options: CarouselOptions(
                        onPageChanged: (index, reason) =>
                            setState(() => pageIndex = index),
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
                    Container(
                      width: 60,
                      height: 25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 26, 26, 29),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: AnimatedSmoothIndicator(
                        count: carouselItems.length,
                        activeIndex: pageIndex,
                        onDotClicked: (int index) =>
                            carouselController.animateToPage(
                          index,
                          duration: global.standardAnimationDuration,
                        ),
                        effect: WormEffect(
                          dotColor: Colors.white.withOpacity(.2),
                          activeDotColor: Theme.of(context).colorScheme.primary,
                          spacing: 5,
                          dotHeight: global.width(context) * .025,
                          dotWidth: global.width(context) * .025,
                          type: WormType.thin,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              global.mediumHeight(context),
              ProductInfo(
                item: widget.item,
              ),
              SizedBox(
                height: global.height(context) * .02,
              ),
              Container(
                height: global.height(context) * .3,
                width: global.containerWidth(context),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 26, 26, 29),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    const ProductDetailsWidget(),
                    GestureDetector(
                      onTap: () {
                        showCustomModalBottomSheet(
                          context,
                          ModalBottomSheet(
                            onPop: () => Navigator.pop(context),
                            title: 'Shipping Information',
                            titleSize: global.width(context) * .08,
                            height: global.height(context) * .8,
                            submitButtonText: "Enter",
                            content: Container(
                              padding: EdgeInsets.only(
                                  top: global.height(context) * .04),
                              width: global.width(context) * .9,
                              height: global.height(context) * .5,
                              child: const ShippingTiles(),
                            ),
                          ),
                        );
                      },
                      child: const PageButton(
                        title: 'Shipping Information',
                        icon: Icons.add_road_rounded,
                        border: true,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showCustomModalBottomSheet(
                          context,
                          ModalBottomSheet(
                            onPop: () => Navigator.pop(context),
                            title: 'Returns',
                            titleSize: global.width(context) * .08,
                            height: global.height(context) * .5,
                            submitButtonText: "Close",
                            content: Container(
                              alignment: Alignment.centerLeft,
                              height: global.height(context) * .2,
                              width: global.width(context) * .8,
                              child: Text(
                                'Free pre-paid returns and exchanges for orders shipped to the US. Get refunded faster with easy online returns and a print a FREE pre-paid return SmartLabel@ online! Return or exchange any unused or defective merchandise by mail or at one of our US or Canada store locations. Made to order items cannot be cancelled exchanged or returned.',
                                style: TextStyle(
                                  fontSize: global.width(context) * .04,
                                  color: Colors.white.withOpacity(.5),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: const PageButton(
                        title: 'Returns',
                        icon: Icons.shopping_cart_outlined,
                        border: false,
                      ),
                    ),
                  ],
                ),
              ),
              global.mediumHeight(context),
              ReviewsBig(reviews: widget.item.itemReviews),
              global.mediumHeight(context),
              Container(
                height: global.height(context) * .1,
                width: global.containerWidth(context),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 26, 26, 29),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) {
                              return ReviewsPage(
                                  reviews: widget.item.itemReviews);
                            }),
                          ),
                        );
                      },
                      child: const PageButton(
                        title: 'Reviews',
                        icon: CupertinoIcons.chat_bubble_text,
                        border: false,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductNavbar extends StatefulWidget {
  final Item item;

  const ProductNavbar({
    super.key,
    required this.item,
  });

  @override
  State<ProductNavbar> createState() => _ProductNavbarState();
}

class _ProductNavbarState extends State<ProductNavbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: global.width(context) * .05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BounceElement(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(global.width(context) * 0.005),
              width: global.width(context) * 0.15,
              height: global.width(context) * 0.15,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(100),
                boxShadow: global.isDarkMode(context)
                    ? [global.darkShadow(context)]
                    : [global.lightShadow(context)],
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
                iconSize: global.width(context) * 0.05,
              ),
            ),
          ),
          BounceElement(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(global.width(context) * 0.005),
              width: global.width(context) * 0.15,
              height: global.width(context) * 0.15,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(100),
                boxShadow: global.isDarkMode(context)
                    ? [global.darkShadow(context)]
                    : [global.lightShadow(context)],
              ),
              child: IconButton(
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  widget.item.itemSaved = !widget.item.itemSaved;
                  setState(() {});
                },
                color: Theme.of(context).colorScheme.onBackground,
                icon: Icon(widget.item.itemSaved
                    ? CupertinoIcons.bookmark_fill
                    : CupertinoIcons.bookmark),
                iconSize: global.width(context) * 0.05,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductInfo extends StatelessWidget {
  final Item item;

  const ProductInfo({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: global.height(context) * .25,
      width: global.containerWidth(context),
      padding: EdgeInsets.all(global.width(context) * .05),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 26, 26, 29),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.itemBrand,
            style: TextStyle(
                color: Colors.white.withOpacity(.8),
                fontSize: global.width(context) * .07),
          ),
          SizedBox(
            height: global.height(context) * .005,
          ),
          Text(
            item.itemName,
            style: TextStyle(
              color: Colors.white,
              fontSize: global.width(context) * .09,
            ),
          ),
          SizedBox(
            height: global.height(context) * .005,
          ),
          Text(
            item.itemDescription,
            style: TextStyle(
                color: Colors.white.withOpacity(.8),
                fontSize: global.width(context) * .035),
          ),
          SizedBox(
            height: global.height(context) * .02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: global.height(context) * .05,
                width: global.width(context) * .4,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: global.linearGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Available in stock',
                  style: TextStyle(
                    fontSize: global.width(context) * .04,
                    color: Colors.black,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.star_rate_rounded,
                    color: Colors.amber[300],
                  ),
                  Text(
                    (item.itemReviews.fold(
                              0,
                              (previousValue, element) {
                                return previousValue += element.stars;
                              },
                            ) /
                            item.itemReviews.length)
                        .toStringAsFixed(1),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: global.width(context) * .01,
                  ),
                  Text(
                    item.itemReviews.length == 1
                        ? '(${item.itemReviews.length} Review)'
                        : '(${item.itemReviews.length} Reviews)',
                    style: TextStyle(
                      color: Colors.white.withOpacity(.8),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PageButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool border;

  const PageButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: global.height(context) * .1,
      padding: EdgeInsets.symmetric(
        horizontal: global.width(context) * .05,
      ),
      decoration: BoxDecoration(
          border: border
              ? Border(
                  bottom: BorderSide(
                    color: Colors.white.withOpacity(.5),
                  ),
                )
              : null),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              global.gradient(
                Icon(
                  icon,
                  color: Colors.white,
                  size: global.width(context) * .1,
                ),
              ),
              SizedBox(
                width: global.width(context) * .05,
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: global.width(context) * .05,
                ),
              ),
            ],
          ),
          global.gradient(
            Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: global.width(context) * .075,
            ),
          )
        ],
      ),
    );
  }
}

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCustomModalBottomSheet(
          context,
          ModalBottomSheet(
            onPop: () => Navigator.pop(context),
            title: 'Product Details',
            titleSize: global.width(context) * .08,
            height: global.height(context) * .7,
            submitButtonText: "Close",
            content: Container(
              padding: EdgeInsets.only(
                  left: global.width(context) * .1,
                  right: global.width(context) * .1,
                  top: global.height(context) * .02),
              height: global.height(context) * .4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sizing:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: global.width(context) * .05,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: global.width(context) * .1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'A cool gray cap in soft corduroy. Watch me. By',
                          style: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontSize: global.width(context) * .04),
                        ),
                        Text(
                          'buying cotton products from gucci, you\'re',
                          style: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontSize: global.width(context) * .04),
                        ),
                        Text(
                          'supporting more responsibly',
                          style: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontSize: global.width(context) * .04),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Details:',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: global.width(context) * .05),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: global.width(context) * .1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '• Materials: 100% cotton, and lining Structured',
                          style: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontSize: global.width(context) * .04),
                        ),
                        Text(
                          '• Adjustable cotton strap closure',
                          style: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontSize: global.width(context) * .04),
                        ),
                        Text(
                          '• High-quality embroidery stitching',
                          style: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontSize: global.width(context) * .04),
                        ),
                        Text(
                          '• Head circumference: 21" - 24" / 54-62',
                          style: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontSize: global.width(context) * .04),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Design:',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: global.width(context) * .05),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: global.width(context) * .1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dominant eagle pictured on the front of the sweater',
                          style: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontSize: global.width(context) * .04),
                        ),
                        Text(
                          'on a beige background. Detailed embroidery and',
                          style: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontSize: global.width(context) * .04),
                        ),
                        Text(
                          'artistic prowess.',
                          style: TextStyle(
                              color: Colors.white.withOpacity(.5),
                              fontSize: global.width(context) * .04),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: const PageButton(
        title: 'Product Details',
        icon: Icons.article_outlined,
        border: true,
      ),
    );
  }
}

class ShippingTiles extends StatefulWidget {
  const ShippingTiles({super.key});

  @override
  State<ShippingTiles> createState() => _ShippingTilesState();
}

class _ShippingTilesState extends State<ShippingTiles> {
  bool selected = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selected = true;
            });
          },
          child: Container(
            padding: EdgeInsets.only(
              top: global.width(context) * .01,
              left: global.width(context) * .01,
              right: global.width(context) * .01,
              bottom: global.width(context) * .1,
            ),
            width: global.width(context) * .8,
            height: global.height(context) * .175,
            decoration: selected
                ? BoxDecoration(
                    gradient: global.linearGradient,
                    borderRadius: BorderRadius.circular(30),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
            child: Container(
              padding: EdgeInsets.all(
                global.width(context) * .05,
              ),
              width: global.width(context) * .4,
              height: global.height(context) * 02,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 26, 26, 29),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      selected
                          ? global.gradient(
                              Icon(
                                Icons.diamond_outlined,
                                size: global.width(context) * .1,
                              ),
                            )
                          : Icon(
                              Icons.diamond_outlined,
                              color: Colors.white,
                              size: global.width(context) * .1,
                            ),
                      SizedBox(
                        width: global.width(context) * .02,
                      ),
                      selected
                          ? global.gradient(
                              Text(
                                'Express',
                                style: TextStyle(
                                    fontSize: global.width(context) * .05),
                              ),
                            )
                          : Text(
                              'Express',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: global.width(context) * .05),
                            )
                    ],
                  ),
                  SizedBox(
                    height: global.height(context) * .005,
                  ),
                  Text(
                    'Arrives in 2-3 business days',
                    style: TextStyle(
                      color: Colors.white.withOpacity(.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: global.height(context) * .025,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selected = false;
            });
          },
          child: Container(
            padding: EdgeInsets.only(
              top: global.width(context) * .01,
              left: global.width(context) * .01,
              right: global.width(context) * .01,
              bottom: global.width(context) * .1,
            ),
            width: global.width(context) * .8,
            height: global.height(context) * .24,
            decoration: !selected
                ? BoxDecoration(
                    gradient: global.linearGradient,
                    borderRadius: BorderRadius.circular(30),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
            child: Container(
              padding: EdgeInsets.all(
                global.width(context) * .05,
              ),
              width: global.width(context) * .4,
              height: global.height(context) * 03,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 26, 26, 29),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      !selected
                          ? global.gradient(
                              Icon(
                                Icons.safety_check_rounded,
                                size: global.width(context) * .1,
                              ),
                            )
                          : Icon(
                              Icons.safety_check_rounded,
                              color: Colors.white,
                              size: global.width(context) * .1,
                            ),
                      SizedBox(
                        width: global.width(context) * .02,
                      ),
                      !selected
                          ? global.gradient(
                              Text(
                                'Standard',
                                style: TextStyle(
                                  fontSize: global.width(context) * .05,
                                ),
                              ),
                            )
                          : Text(
                              'Standard',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: global.width(context) * .05),
                            )
                    ],
                  ),
                  SizedBox(
                    height: global.height(context) * .005,
                  ),
                  Text(
                    'Arrives in 5-8 business days',
                    style: TextStyle(
                      color: Colors.white.withOpacity(.5),
                    ),
                  ),
                  SizedBox(
                    height: global.height(context) * .03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order up to €49.99:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: global.width(context) * .04),
                      ),
                      Text(
                        '€4.95',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: global.width(context) * .04),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order €50 and over:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: global.width(context) * .04),
                      ),
                      Text(
                        'Free',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: global.width(context) * .04,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
