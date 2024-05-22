import 'package:flexify/pages/dShop/data/shopData.dart';
import 'package:flexify/pages/dShop/pages/widgets/ShopNavbar.dart';
import 'package:flexify/pages/dShop/pages/productPage/productPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class SavedPage extends StatefulWidget {
  final List<Item> savedItems;
  
  const SavedPage({super.key, required this.savedItems});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ShopNavbar(
              title: 'Saved',
              titleSize: global.width(context) * .09,
            ),
            SizedBox(
              width: global.containerWidth(context),
              height: global.height(context) * .75,
              child: ListView(
                children: widget.savedItems.map(
                  (item) {
                    return Column(
                      children: [
                        SavedItemWidget(item: item),
                        global.mediumHeight(context),
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
            SizedBox(
              height: global.height(context) * .02,
            ),
          ],
        ),
      ),
    );
  }
}

class SavedItemWidget extends StatefulWidget {
  final Item item;

  const SavedItemWidget({
    super.key,
    required this.item,
  });

  @override
  State<SavedItemWidget> createState() => _SavedItemWidgetState();
}

class _SavedItemWidgetState extends State<SavedItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openSavedItemPage(context);
      },
      child: Container(
        height: global.height(context) * .15,
        decoration: global.boxDecoration(context),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(global.width(context) * .025),
                  child: Container(
                    width: global.height(context) * .125,
                    height: global.height(context) * .125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white.withOpacity(.5),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: global.width(context) * .05),
                  alignment: Alignment.center,
                  width: global.width(context) * .425,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.item.itemBrand,
                        softWrap: true,
                        style: TextStyle(
                          color: Colors.white.withOpacity(.5),
                          fontSize: global.width(context) * .06,
                        ),
                      ),
                      Text(
                        widget.item.itemName,
                        softWrap: true,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: global.width(context) * .055),
                      ),
                      SizedBox(
                        height: global.height(context) * .01,
                      ),
                      Row(
                        children: [
                          global.gradient(
                            Text(
                              '\$${widget.item.itemDiscountCost.toString()}',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: global.width(context) * .04),
                            ),
                          ),
                          SizedBox(
                            width: global.width(context) * .02,
                          ),
                          Text(
                            '\$${widget.item.itemOriginalCost.toString()}',
                            style: TextStyle(
                              color: Colors.white.withOpacity(.7),
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.white.withOpacity(.7),
                              decorationThickness: 1.5,
                              fontSize: global.width(context) * .04,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                savedSwitch();
              },
              child: Padding(
                padding: EdgeInsets.all(global.width(context) * .025),
                child: Container(
                  alignment: Alignment.center,
                  height: global.height(context) * .07,
                  width: global.height(context) * .07,
                  decoration: BoxDecoration(
                    color: global.darkGrey,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: global.gradient(
                    Icon(
                      widget.item.itemSaved
                          ? CupertinoIcons.bookmark_fill
                          : CupertinoIcons.bookmark,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void openSavedItemPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductPage(item: widget.item),
      ),
    );
  }

  void savedSwitch() {
    setState(() {
      widget.item.itemSaved = !widget.item.itemSaved;
    });
  }
}
