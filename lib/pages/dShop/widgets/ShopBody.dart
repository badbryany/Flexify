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
          height: global.height(context) * .02,
        ),
        SizedBox(
          height: global.height(context) * 0.325,
          width: global.containerWidth(context),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: shopData.dummyItems.length,
            itemBuilder: (context, index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: shopData.dummyItems
                    .map(
                      (item) => Row(
                        children: [
                          ProductWidget(
                            item: item,
                          ),
                          SizedBox(
                            width: global.width(context) * .03,
                          )
                        ],
                      ),
                    )
                    .toList(),
              );
            },
          ),
        )
      ],
    );
  }
}

class ProductWidget extends StatelessWidget {
  final shopData.Item item;

  const ProductWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return BounceElement(
      child: GestureDetector(
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
              SizedBox(
                height: global.height(context) * .01,
              ),
              Row(
                children: [
                  SizedBox(
                    width: global.width(context) * .03,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.itemBrand,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white.withOpacity(.7),
                          fontSize: global.width(context) * .06,
                        ),
                      ),
                      SizedBox(
                        height: global.height(context) * .01,
                      ),
                      Text(
                        item.itemName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: global.width(context) * .05,
                        ),
                      ),
                      SizedBox(
                        height: global.height(context) * .01,
                      ),
                      Row(
                        children: [
                          global.gradient(
                            Text(
                              '\$${item.itemDiscountCost.toString()}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: global.width(context) * .02,
                          ),
                          Text(
                            '\$${item.itemOriginalCost.toString()}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(.7),
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.white.withOpacity(.7),
                              decorationThickness: 1.5,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
