import 'package:collection/collection.dart';
import 'package:flexify/data/dateUtils.dart';
import 'package:flexify/pages/dShop/data/shopData.dart' as shopData;
import 'package:flexify/pages/dShop/pages/widgets/ShopNavbar.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/pages/dShop/pages/productPage/productPage.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  final List<shopData.Order> orders;

  const OrdersPage({super.key, required this.orders});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            ShopNavbar(
              title: 'Orders',
              titleSize: global.width(context) * .09,
            ),
            SizedBox(
              height: global.height(context) * .75,
              width: global.containerWidth(context),
              child: ListView(
                children: widget.orders
                    .map(
                      (order) => Column(
                        children: [
                          OrderWidget(order: order),
                          global.mediumHeight(context),
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrderWidget extends StatelessWidget {
  final shopData.Order order;

  const OrderWidget({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    Container divider = Container(
      width: global.containerWidth(context),
      height: 1,
      color: Colors.white.withOpacity(.5),
    );
    return Container(
      padding: EdgeInsets.only(
        top: global.width(context) * .05,
        left: global.width(context) * .05,
        right: global.width(context) * .05,
        bottom: global.width(context) * .025,
      ),
      width: global.containerWidth(context),
      decoration: global.boxDecoration(context),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'OrderID: ${order.orderID}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(.5),
                      fontSize: global.width(context) * .03,
                    ),
                  ),
                  SizedBox(
                    height: global.height(context) * .005,
                  ),
                  Text(
                    'Ordered:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: global.width(context) * .045,
                    ),
                  ),
                  Text(
                    dateString(order.orderDate),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: global.width(context) * .05,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: global.width(context) * .1,
              ),
              Container(
                alignment: Alignment.center,
                width: global.width(context) * .3,
                padding: EdgeInsets.all(global.width(context) * .05),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: global.gradient(
                  Text(
                    shopData.orderStatusTypes[order.orderStatusIdx],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: global.width(context) * .035,
                    ),
                  ),
                ),
              ),
            ],
          ),
          global.mediumHeight(context),
          divider,
          global.mediumHeight(context),
          OrderStatusWidget(order: order),
          global.mediumHeight(context),
          SizedBox(
            height: global.height(context) * .12 * order.orderItems.length,
            width: global.containerWidth(context),
            child: Column(
              children: order.orderItems
                  .map(
                    (item) => Column(
                      children: [
                        OrderItemWidget(orderItem: item),
                        SizedBox(height: global.height(context) * .02)
                      ],
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    super.key,
    required this.order,
  });

  final shopData.Order order;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: shopData.orderStatusTypes
          .mapIndexed(
            (index, element) => OrderStatusTile(
                title: shopData.orderStatusTypes[index],
                left: index != 0,
                right: index != 4,
                fulfilled: index <= order.orderStatusIdx),
          )
          .toList(),
    );
  }
}

class OrderStatusTile extends StatelessWidget {
  final bool left;
  final bool right;
  final bool fulfilled;
  final String title;

  const OrderStatusTile({
    super.key,
    required this.title,
    required this.left,
    required this.right,
    required this.fulfilled,
  });

  @override
  Widget build(BuildContext context) {
    Text statusTitle = Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: global.width(context) * .03,
      ),
    );
    Container statusBar = Container(
      height: global.height(context) * .0075,
      width: global.width(context) * .0475,
      color: fulfilled
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.background,
    );
    Container statusCircle = Container(
      height: global.width(context) * .075,
      width: global.width(context) * .075,
      decoration: BoxDecoration(
        color: fulfilled
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(100),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        fulfilled ? global.gradient(statusTitle) : statusTitle,
        SizedBox(
          height: global.height(context) * .02,
        ),
        Row(
          children: [
            left ? statusBar : SizedBox(width: global.width(context) * .0475),
            fulfilled ? global.gradient(statusCircle) : statusCircle,
            right ? statusBar : SizedBox(width: global.width(context) * .0475)
          ],
        )
      ],
    );
  }
}

class OrderItemWidget extends StatelessWidget {
  final shopData.Item orderItem;

  const OrderItemWidget({
    super.key,
    required this.orderItem,
  });

  openOrderItemPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductPage(item: orderItem),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openOrderItemPage(context);
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: global.height(context) * .1,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white.withOpacity(.8),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              width: global.height(context) * .1,
              height: global.height(context) * .1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(.8),
              ),
            ),
            SizedBox(
              width: global.width(context) * .05,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  orderItem.itemBrand,
                  style: TextStyle(
                      color: Colors.white.withOpacity(.5),
                      fontSize: global.width(context) * .04),
                ),
                Text(
                  orderItem.itemName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: global.width(context) * .04),
                ),
                SizedBox(
                  height: global.height(context) * .01,
                ),
                Row(
                  children: [
                    global.gradient(
                      Text(
                        '\$${orderItem.itemDiscountCost.toString()}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: global.width(context) * .02,
                    ),
                    Text(
                      '\$${orderItem.itemOriginalCost.toString()}',
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
        ),
      ),
    );
  }
}
