import 'package:flexify/pages/dShop/widgets/ShopBody.dart';
import 'package:flexify/pages/dShop/widgets/ShopSearch.dart';
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
              ? global.height(context) * .475
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
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
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
