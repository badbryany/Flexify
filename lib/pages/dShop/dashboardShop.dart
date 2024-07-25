import 'package:flexify/pages/dShop/data/shopData.dart' as shopData;
import 'package:flexify/pages/dShop/pages/productPage/productPage.dart';
import 'package:flexify/pages/dShop/widgets/ShopBody.dart';
import 'package:flexify/pages/dShop/widgets/ShopSearch.dart';
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class DashboardShop extends StatefulWidget {
  const DashboardShop({super.key});

  @override
  State<DashboardShop> createState() => _DashboardShopState();
}

class _DashboardShopState extends State<DashboardShop> {
  bool expanded = false;
  final _shopSearchController = TextEditingController();

  toggleExpanded() {
    expanded = !expanded;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _shopSearchController.addListener(() {
      setState(() {});
    });
  }

  isShopSearchFilled() => _shopSearchController.text != '' && !expanded;

  List<Widget> elements(BuildContext context) => [
        Positioned(
          top: expanded
              ? global.height(context) * .475 * (3/4)
              : global.height(context) * .15,
          child: const ShopBody(),
        ),
        ShopSearch(
          callback: toggleExpanded,
          shopSearchController: _shopSearchController,
        ),
        Positioned(
          top: global.height(context) * .125,
          left: global.width(context) * .05,
          child: Visibility(
            visible: !expanded,
            child: AnimatedOpacity(
              duration: expanded
                  ? global.standardAnimationDuration * .3
                  : global.standardAnimationDuration * 2,
              curve: Curves.easeInQuint,
              opacity: expanded ? 0 : 1,
              child: AnimatedContainer(
                duration: global.standardAnimationDuration,
                curve: Curves.easeInOut,
                height: isShopSearchFilled() ? global.height(context) * .2 : 0,
                width:
                    global.containerWidth(context) - global.width(context) * .1,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  border: Border(
                    left: BorderSide(
                      color: Colors.black,
                    ),
                    right: BorderSide(
                      color: Colors.black,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                child: ListView.builder(
                    itemCount: shopData.dummyItems.length,
                    itemBuilder: (context, idx) {
                      return BounceElement(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductPage(
                                item: shopData.dummyItems[idx],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: global.height(context) * .1,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(global.width(context) * .02),
                          decoration: BoxDecoration(
                              border: idx != 0
                                  ? const Border(
                                      top: BorderSide(color: Colors.black),
                                    )
                                  : null),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                  height: global.height(context) * .8,
                                  width: global.width(context) * .3,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(
                                    left: global.width(context) * .075,
                                  ),
                                  child: Text(
                                    '${shopData.dummyItems[idx].itemBrand}\n${shopData.dummyItems[idx].itemName}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: global.width(context) * .04),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ),
        ),
        SizedBox(
          height: global.height(context) * .02,
        )
      ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: expanded
            ? global.height(context) * 1.485
            : global.height(context) * 1.16,
        width: global.containerWidth(context),
        child: Stack(children: elements(context)),
      ),
    );
  }
}
