import 'package:collection/collection.dart';
import 'package:flexify/pages/dShop/pages/3_addressPage.dart';
import 'package:flexify/pages/dShop/pages/1_ordersPage.dart';
import 'package:flexify/pages/dShop/pages/4_walletPage.dart';
import 'package:flexify/pages/dShop/pages/cartPage.dart';
import 'package:flexify/pages/dShop/pages/productPage/productPage.dart';
import 'package:flexify/pages/dShop/pages/2_savedPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/pages/dShop/data/shopData.dart' as shopData;

class ShopSearch extends StatefulWidget {
  const ShopSearch({super.key, required this.callback});

  final Function callback;

  @override
  State<ShopSearch> createState() => _ShopSearchState();
}

class _ShopSearchState extends State<ShopSearch> {
  bool expanded = false;

  List<List> sections = [
    [
      'Orders',
      OrdersPage(
        orders: shopData.dummyOrders,
      ),
      Icons.list_alt_rounded
    ],
    [
      'Saved',
      SavedPage(
        savedItems:
            shopData.dummyItems.where((item) => item.itemSaved).toList(),
      ),
      CupertinoIcons.bookmark
    ],
    [
      'Addresses',
      AddressesPage(
        addresses: shopData.dummyAddresses,
      ),
      CupertinoIcons.home
    ],
    [
      'Wallet',
      WalletPage(
        cards: shopData.dummyCards,
      ),
      CupertinoIcons.money_euro
    ]
  ];

  final _shopSearchController = TextEditingController();
  bool selected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedContainer(
          alignment: Alignment.center,
          curve: Curves.easeInOutCirc,
          clipBehavior: Clip.hardEdge,
          duration: global.standardAnimationDuration,
          padding: EdgeInsets.only(
              left: global.width(context) * .05,
              right: global.width(context) * .05,
              top: global.height(context) * .02),
          height: expanded
              ? global.height(context) * .475
              : global.height(context) * .15,
          width: global.containerWidth(context),
          decoration: global.boxDecoration(context),
        ),
        Positioned(
          top: global.height(context) * .02,
          left: global.width(context) * .05,
          right: global.width(context) * .05,
          child: SizedBox(
            width: global.containerWidth(context) - global.width(context) * .05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    expanded = !expanded;
                    widget.callback();
                    selected = false;
                    setState(() {});
                  },
                  child: Icon(
                    CupertinoIcons.text_justifyleft,
                    color: Colors.white,
                    size: global.height(context) * .035,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    openCart(context);
                  },
                  child: Icon(
                    Icons.shopping_bag_rounded,
                    color: Colors.white,
                    size: global.height(context) * .035,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: global.height(context) * .075,
          child: expanded
              ? Column(
                  children: [
                    SizedBox(
                      height: global.height(context) * .4,
                      width: global.containerWidth(context),
                      child: Column(
                        children: sections.mapIndexed(
                          (idx, e) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return sections[idx][1];
                                    },
                                  ),
                                );
                              },
                              child: PageButton(
                                  icon: sections[idx][2],
                                  title: sections[idx][0],
                                  border: idx != 3 ? true : false),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                )
              : AnimatedContainer(
                duration: global.standardAnimationDuration,
                height: selected ? global.height(context) * .1 : global.height(context) * .05,
                width: (global.containerWidth(context) - global.width(context) * .1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: global.width(context) * .03,
                        right: global.width(context) * .02,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.black,
                                size: global.height(context) * .02,
                              ),
                              SizedBox(
                                width: global.width(context) * .02,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: global.width(context) * .7 -
                                    global.height(context) * .04,
                                height: global.height(context) * .05,
                                child: TextField(
                                  textAlignVertical: TextAlignVertical.top,
                                  controller: _shopSearchController,
                                  autofocus: false,
                                  onTap: () => selected = !selected,
                                  onSubmitted: (value) {
                                    selected = !selected;
                                  },
                                  onTapOutside: (event) {
                                    selected = !selected;
                                  },
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Search',
                                    hintStyle:
                                        TextStyle(color: Colors.black),
                                    isCollapsed: true,
                                  ),
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  cursorColor: Colors.black.withOpacity(.7),
                                  cursorOpacityAnimates: true,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            highlightColor: Colors.transparent,
                            icon: Icon(
                              Icons.clear_rounded,
                              color: Colors.black,
                              size: global.height(context) * .02,
                            ),
                            onPressed: () {
                              clearSuffixOnTap(context);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
        ),
      ],
    );
  }

  void clearSuffixOnTap(BuildContext context) {
    setState(() {
      _shopSearchController.clear();
      FocusScope.of(context).unfocus();
    });
  }

  void openCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(
          cartItems:
              shopData.dummyItems.where((item) => item.itemCart).toList(),
        ),
      ),
    );
  }
}
