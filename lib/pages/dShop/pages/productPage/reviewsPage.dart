import 'package:flexify/pages/dShop/data/shopData.dart' as shopData;
import 'package:flexify/pages/dShop/pages/widgets/ShopNavbar.dart';
import 'package:flexify/pages/dShop/pages/productPage/productPage.dart';
import 'package:flexify/pages/dShop/pages/widgets/SubmitButton.dart';
import 'package:flexify/widgets/ModalBottomSheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:image/image.dart';

class ReviewsPage extends StatefulWidget {
  final List<shopData.Review> reviews;

  const ReviewsPage({super.key, required this.reviews});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  List<String> reviewComparators = ['Most Useful', 'Most Recent'];
  String reviewComparator = 'Most Useful';

  @override
  void initState() {
    widget.reviews
        .sort((reviewA, reviewB) => reviewB.stars.compareTo(reviewA.stars));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ShopNavbar(
              title: 'Reviews',
            ),
            ReviewsBig(reviews: widget.reviews),
            SizedBox(
              height: global.height(context) * .02,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const AddReviewPage();
                    },
                  ),
                );
              },
              child: Container(
                height: global.height(context) * .1,
                width: global.containerWidth(context),
                decoration: BoxDecoration(
                  color: global.darkGrey,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const PageButton(
                    title: 'Add Review',
                    icon: CupertinoIcons.chat_bubble_2,
                    border: false),
              ),
            ),
            SizedBox(
              height: global.height(context) * .025,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: global.width(context) * .045),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'User reviews',
                    style: TextStyle(fontSize: global.width(context) * .07),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                        canvasColor: global.darkGrey,
                        focusColor: global.darkGrey),
                    child: DropdownButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: global.width(context) * .03),
                      value: reviewComparator,
                      items: [
                        ...reviewComparators.map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: global.width(context) * .01),
                              child: Text(
                                e,
                                style: TextStyle(
                                  fontFamily: 'KronaOne',
                                  color: Colors.white,
                                  fontSize: global.width(context) * .04,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                      alignment: AlignmentDirectional.center,
                      borderRadius: BorderRadius.circular(30),
                      autofocus: true,
                      iconEnabledColor: Colors.white,
                      underline: const SizedBox(),
                      onChanged: (String? value) {
                        if (value is String) {
                          if (value != reviewComparator) {
                            String tmp = reviewComparators[0];
                            reviewComparators[0] = reviewComparators[1];
                            reviewComparators[1] = tmp;
                          }
                          reviewComparator = value;
                          if (reviewComparator == 'Most Useful') {
                            widget.reviews.sort((reviewA, reviewB) =>
                                reviewB.stars.compareTo(reviewA.stars));
                          } else {
                            widget.reviews.sort((reviewA, reviewB) =>
                                reviewA.date.isAfter(reviewB.date) ? 1 : 0);
                          }
                          setState(() {});
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: global.height(context) * .025,
            ),
            SizedBox(
              width: global.containerWidth(context),
              height: global.height(context) * .3,
              child: ListView(
                children: widget.reviews
                    .map((review) => ReviewWidget(review: review))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReviewsBig extends StatelessWidget {
  final List<shopData.Review> reviews;

  const ReviewsBig({
    required this.reviews,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: global.width(context) * .035),
      height: global.height(context) * .2,
      width: global.containerWidth(context),
      decoration: BoxDecoration(
        color: global.darkGrey,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(global.width(context) * .05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${(reviews.map((review) => review.stars).reduce((sum, x) => sum + x) / reviews.length).toStringAsFixed(1)} / 5',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: global.width(context) * .1),
                ),
                Text(
                  'Based on ${reviews.length} reviews',
                  style: TextStyle(
                      color: Colors.white.withOpacity(.5),
                      fontSize: global.width(context) * .03),
                ),
                SizedBox(
                  height: global.height(context) * .01,
                ),
                Row(
                  children: [0, 1, 2, 3, 4]
                      .map(
                        (index) =>
                            ReviewsBigStar(reviews: reviews, index: index),
                      )
                      .toList(),
                )
              ],
            ),
          ),
          SizedBox(
            width: global.width(context) * .01,
          ),
          SizedBox(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [5, 4, 3, 2, 1]
                    .map(
                      (index) => Column(
                        children: [
                          ReviewsBigBar(index: index, reviews: reviews),
                          SizedBox(height: global.height(context) * .01),
                        ],
                      ),
                    )
                    .toList()),
          )
        ],
      ),
    );
  }
}

class ReviewsBigStar extends StatelessWidget {
  final List<shopData.Review> reviews;
  final int index;

  const ReviewsBigStar({
    required this.reviews,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double starColor = index -
        ((reviews
                .map((review) => review.stars)
                .reduce((sum, stars) => sum += stars)) /
            reviews.length);
    return (starColor > 0)
        ? Icon(
            Icons.star_rate_rounded,
            color: Theme.of(context).colorScheme.background,
            size: global.width(context) * .075,
          )
        : (starColor < 1)
            ? Icon(
                Icons.star_rounded,
                size: global.width(context) * .075,
                color: Colors.amber[300],
              )
            : Icon(Icons.star_half_rounded,
                size: global.width(context) * .075, color: Colors.amber[300]);
  }
}

class ReviewsBigBar extends StatefulWidget {
  final int index;
  final List<shopData.Review> reviews;

  const ReviewsBigBar({super.key, required this.index, required this.reviews});

  @override
  State<ReviewsBigBar> createState() => _ReviewsBigBarState();
}

class _ReviewsBigBarState extends State<ReviewsBigBar> {
  late double percentage;

  @override
  void initState() {
    percentage =
        widget.reviews.where((review) => review.stars == widget.index).length /
            widget.reviews.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: global.width(context) * .4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: global.width(context) * .03,
            child: Text(
              widget.index.toString(),
              style: TextStyle(color: Colors.white.withOpacity(.5)),
            ),
          ),
          SizedBox(
            width: global.width(context) * .01,
          ),
          SizedBox(
            child: Text(
              ' Star',
              style: TextStyle(color: Colors.white.withOpacity(.5)),
            ),
          ),
          SizedBox(
            width: global.width(context) * .03,
          ),
          Stack(
            children: [
              Container(
                height: global.height(context) * .01,
                width: (global.containerWidth(context) / 4.5),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.5),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              Container(
                height: global.height(context) * .01,
                width: (global.containerWidth(context) / 4.5) * percentage,
                decoration: BoxDecoration(
                  color: Colors.amber[300],
                  borderRadius: BorderRadius.circular(30),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ReviewWidget extends StatelessWidget {
  final shopData.Review review;

  const ReviewWidget({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.all(
            global.width(context) * .05,
          ),
          width: global.containerWidth(context),
          height: global.height(context) * .2,
          decoration: BoxDecoration(
            color: global.darkGrey,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: global.height(context) * .05,
                        width: global.height(context) * .05,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      SizedBox(
                        width: global.width(context) * .02,
                      ),
                      Text(
                        review.username,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: global.width(context) * .05),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ReviewStar(
                        index: 0,
                        review: review,
                      ),
                      ReviewStar(
                        index: 1,
                        review: review,
                      ),
                      ReviewStar(
                        index: 2,
                        review: review,
                      ),
                      ReviewStar(
                        index: 3,
                        review: review,
                      ),
                      ReviewStar(
                        index: 4,
                        review: review,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: global.height(context) * .03,
              ),
              Text(
                review.description,
                style: TextStyle(
                    color: Colors.white.withOpacity(.5),
                    fontSize: global.width(context) * .04),
              ),
            ],
          ),
        ),
        SizedBox(
          height: global.height(context) * .01,
        ),
      ],
    );
  }
}

class ReviewStar extends StatelessWidget {
  final int index;
  final shopData.Review review;

  const ReviewStar({
    super.key,
    required this.index,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star_rate_rounded,
      color: (index < review.stars)
          ? Colors.amber[300]
          : Theme.of(context).colorScheme.background,
    );
  }
}

class AddReviewPage extends StatefulWidget {
  const AddReviewPage({super.key});

  @override
  State<AddReviewPage> createState() => _AddReviewPageState();
}

class _AddReviewPageState extends State<AddReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ShopNavbar(title: 'Add Review'),
            const ProductInfo(),
            global.mediumHeight(context),
            const ReviewBody(),
            global.mediumHeight(context),
            const SubmitButton()
          ],
        ),
      ),
    );
  }
}

class ProductInfo extends StatelessWidget {
  const ProductInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(global.width(context) * .025),
      alignment: Alignment.center,
      width: global.containerWidth(context),
      height: global.height(context) * .125,
      decoration: BoxDecoration(
        color: global.darkGrey,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          global.darkShadow(context),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: global.height(context) * .1,
            width: global.height(context) * .1,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          SizedBox(
            width: global.width(context) * .05,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Gucci',
                style: TextStyle(
                    color: Colors.white.withOpacity(.8),
                    fontSize: global.width(context) * .045),
              ),
              Text(
                'Knitted Sweater',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: global.width(context) * .055),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ReviewBody extends StatelessWidget {
  const ReviewBody({
    super.key,
  });

  Widget reviewEntry(BuildContext context, String title, int maxChars,
      TextEditingController controller) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: global.width(context) * .02,
            ),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: global.width(context) * .055,
              ),
            ),
          ],
        ),
        SizedBox(height: global.height(context) * .01),
        GestureDetector(
          onTap: () {
            showCustomModalBottomSheet(
              context,
              ModalBottomSheet(
                title: title,
                height: global.height(context) * .8,
                topPadding: 0,
                titleSize: global.width(context) * .08,
                submitButtonText: "Close",
                content: Container(
                  padding: EdgeInsets.only(bottom: global.height(context) * .3),
                  height: global.height(context) * .5,
                  width: global.width(context) * .8,
                  child: global.gradient(
                    Container(
                      padding: EdgeInsets.only(
                        top: global.height(context) * .01,
                        bottom: global.height(context) * .02,
                      ),
                      width: global.containerWidth(context),
                      height: global.height(context) * .2,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        autofocus: true,
                        maxLines: 10,
                        onSubmitted: (value) {
                          Navigator.pop(context);
                        },
                        controller: controller,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            top: global.height(context) * .02,
                            left: global.width(context) * .05,
                          ),
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: global.width(context) * .04,
                          ),
                          suffixIcon: IconButton(
                            highlightColor: Colors.transparent,
                            icon: const Icon(
                              Icons.clear_rounded,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              controller.clear();
                            },
                          ),
                        ),
                        cursorColor: Colors.black.withOpacity(.7),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(global.height(context) * .01),
            height: global.height(context) * .1,
            width: global.containerWidth(context),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              controller.text,
              softWrap: true,
              style: TextStyle(
                color: Colors.white,
                fontSize: global.width(context) * .03,
              ),
            ),
          ),
        ),
        SizedBox(height: global.height(context) * .005),
        Row(
          children: [
            SizedBox(width: global.width(context) * .02),
            Text(
              '${maxChars.toString()} Character max',
              style: TextStyle(
                color: Colors.white.withOpacity(.5),
                fontSize: global.width(context) * .03,
              ),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: global.width(context) * .05,
        vertical: global.width(context) * .1,
      ),
      height: global.height(context) * .55,
      width: global.containerWidth(context),
      decoration: BoxDecoration(
          color: global.darkGrey,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [global.darkShadow(context)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ReviewStarEntry(),
          SizedBox(height: global.height(context) * .015),
          reviewEntry(
              context, 'Title', 100, shopData.Review.reviewTitleController),
          SizedBox(height: global.height(context) * .03),
          reviewEntry(context, 'Description', 3000,
              shopData.Review.reviewDescriptionController)
        ],
      ),
    );
  }
}

class ReviewStarEntry extends StatefulWidget {
  const ReviewStarEntry({
    super.key,
  });

  @override
  State<ReviewStarEntry> createState() => _ReviewStarEntryState();
}

class _ReviewStarEntryState extends State<ReviewStarEntry> {
  int stars = 5;

  GestureDetector addReviewStar(int index) {
    return GestureDetector(
      onTap: () {
        stars = index;
        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.all(global.width(context) * .02),
        width: global.width(context) * .16,
        child: Icon(
          Icons.star_rate_rounded,
          color: stars >= index
              ? Colors.amber[300]
              : Theme.of(context).colorScheme.background,
          size: global.width(context) * .125,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: global.height(context) * .1,
      width: global.containerWidth(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Your overall rating of this product',
            style: TextStyle(
                color: Colors.white, fontSize: global.width(context) * .045),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [1, 2, 3, 4, 5]
                .map(
                  (index) => addReviewStar(index),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
