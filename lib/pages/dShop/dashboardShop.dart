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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const ShopSearch(),
          const ShopBody(),
          SizedBox(
            height: global.height(context) * .02,
          ),
        ],
      ),
    );
  }
}

