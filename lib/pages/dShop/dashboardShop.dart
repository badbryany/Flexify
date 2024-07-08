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
  toggleExpanded() {
    expanded = !expanded;
    setState(() {});
  }

  List<Widget> elements(BuildContext context) => [
        Positioned(
          top: expanded
              ? global.height(context) * .475
              : global.height(context) * .15,
          child: const ShopBody(),
        ),
        ShopSearch(
          callback: toggleExpanded,
        ),
        SizedBox(
          height: global.height(context) * .02,
        )
      ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: global.height(context) * 1.19,
        width: global.containerWidth(context),
        child: Stack(children: elements(context)),
      ),
    );
  }
}
