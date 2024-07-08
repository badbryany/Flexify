import 'package:flexify/pages/dShop/data/shopData.dart' as shopData;
import 'package:flexify/pages/dShop/pages/productPage/productPage.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class ShopBody extends StatefulWidget {
  const ShopBody({super.key});

  @override
  State<ShopBody> createState() => _ShopBodyState();
}

class _ShopBodyState extends State<ShopBody> {
  int selectedCategoryIdx = 0;
  List<String> selectedCategoryName = [
    "All Categories",
    "On Sale",
    "Clothing",
    "Equipment",
    "Bottles",
    "Lifestyle",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: global.height(context) * .025,
        ),
        Text(
          "Categories",
          style: TextStyle(
            fontSize: global.width(context) * .15,
            color: Theme.of(context).focusColor,
          ),
        ),
        SizedBox(
          height: global.height(context) * .025,
        ),
        SizedBox(
          width: global.containerWidth(context),
          height: global.height(context) * .05,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(
                    () {
                      selectedCategoryIdx = index;
                    },
                  );
                },
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      alignment: Alignment.center,
                      width: global.width(context) * 0.375,
                      decoration: BoxDecoration(
                        color: selectedCategoryIdx == index
                            ? Colors.white
                            : Colors.transparent,
                        gradient: global.linearGradient,
                        borderRadius: BorderRadius.circular(30),
                        border: (selectedCategoryIdx == index &&
                                global.isDarkMode(context))
                            ? const Border.fromBorderSide(BorderSide.none)
                            : Border.all(color: Theme.of(context).focusColor),
                      ),
                      child: Text(
                        selectedCategoryName[index],
                        style: TextStyle(
                            color: selectedCategoryIdx == index
                                ? Colors.black
                                : Theme.of(context).focusColor,
                            fontSize: global.width(context) * 0.04,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                    SizedBox(
                      width: global.width(context) * 0.05,
                    )
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: global.height(context) * .025,
        ),
        const ProductRow(),
        SizedBox(
          height: global.height(context) * .01,
        ),
        const ProductWidgetWide(),
        SizedBox(
          height: global.height(context) * .01,
        ),
        const ProductRow(),
      ],
    );
  }
}

class ProductRow extends StatelessWidget {
  const ProductRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: global.height(context) * .3,
      width: global.containerWidth(context),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: shopData.dummyItems.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: shopData.dummyItems
                    .map(
                      (item) => Row(
                        children: [
                          ProductWidgetTall(
                            item: item,
                          ),
                          SizedBox(
                            width: global.width(context) * .03,
                          )
                        ],
                      ),
                    )
                    .toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ProductWidgetTall extends StatelessWidget {
  final shopData.Item item;

  const ProductWidgetTall({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return BounceElement(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(
              item: item,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(
          global.width(context) * .02,
        ),
        height: global.height(context) * .3,
        width: global.width(context) * .5,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 26, 26, 29),
          borderRadius: BorderRadius.circular(global.width(context) * 0.0375),
          boxShadow: global.isDarkMode(context)
              ? [global.darkShadow(context)]
              : [global.lightShadow(context)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: global.height(context) * .2,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(
                  global.width(context) * 0.0375,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: global.height(context) * .015,),
                Text(
                  item.itemBrand,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.7),
                    fontSize: global.height(context) * .018,
                  ),
                ),
                Text(
                  item.itemName,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: global.height(context) * .0175,
                  ),
                ),
                Row(
                  children: [
                    global.gradient(
                      Text(
                        '\$${item.itemDiscountCost.toString()}',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: global.height(context) * .015),
                      ),
                    ),
                    SizedBox(
                      width: global.width(context) * .02,
                    ),
                    Text(
                      '\$${item.itemOriginalCost.toString()}',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.white.withOpacity(.7),
                          decoration: TextDecoration.lineThrough,
                          decorationColor: Colors.white.withOpacity(.7),
                          decorationThickness: 1.5,
                          fontSize: global.height(context) * .015),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProductWidgetWide extends StatefulWidget {
  const ProductWidgetWide({super.key});

  @override
  State<ProductWidgetWide> createState() => _ProductWidgetWideState();
}

class _ProductWidgetWideState extends State<ProductWidgetWide> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(global.width(context) * .025),
      width: global.containerWidth(context),
      height: global.height(context) * .2,
      decoration: BoxDecoration(
          color: global.darkGrey,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).colorScheme.background),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(global.width(context) * .03),
              alignment: Alignment.centerLeft,
              width: global.containerWidth(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: global.height(context) * .02 +
                          global.width(context) * .035,
                      color: Colors.white,
                    ),
                  ),
                  global.gradient(
                    Text(
                      'Marketing',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: global.height(context) * .02 +
                            global.width(context) * .035,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                  Text(
                    'Things',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: global.height(context) * .02 +
                          global.width(context) * .035,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
