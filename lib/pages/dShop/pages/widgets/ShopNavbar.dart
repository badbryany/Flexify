import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/pages/dShop/data/shopData.dart' as shopData;
import 'package:flexify/widgets/BounceElement.dart';
import 'package:flutter/material.dart';

class ShopNavbar extends StatelessWidget {
  final String title;
  final double? titleSize;
  final Function? onTap;

  const ShopNavbar({
    super.key,
    required this.title,
    this.titleSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(global.width(context) * .05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BounceElement(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(global.width(context) * 0.005),
              width: global.width(context) * 0.15,
              height: global.width(context) * 0.15,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: global.shadow(context)),
              child: IconButton(
                highlightColor: Colors.transparent,
                onPressed: () {
                  // if (onTap != null) {onTap;}
                  shopData.Address.clearControllers();
                  shopData.Card.clearControllers();
                  Navigator.pop(context);
                },
                color: Theme.of(context).colorScheme.onBackground,
                icon: const Icon(
                  Icons.arrow_back_rounded,
                ),
                iconSize: global.width(context) * 0.05,
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Theme.of(context).focusColor,
              fontSize: titleSize ?? global.width(context) * .06,
            ),
          ),
          SizedBox(
            width: global.width(context) * .155,
          )
        ],
      ),
    );
  }
}
