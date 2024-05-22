import 'package:flexify/pages/dShop/data/shopData.dart' as shopData;
import 'package:flexify/pages/dShop/pages/1_ordersPage.dart';
import 'package:flexify/pages/dShop/pages/widgets/EntryWidget.dart';
import 'package:flexify/pages/dShop/pages/widgets/ShopNavbar.dart';
import 'package:flexify/pages/dShop/pages/widgets/SubmitButton.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class CartPage extends StatefulWidget {
  final List<shopData.Item> cartItems;
  const CartPage({super.key, required this.cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          width: global.containerWidth(context),
          child: Column(
            children: [
              ShopNavbar(
                title: 'Cart',
                titleSize: global.width(context) * .09,
              ),
              Container(
                height: global.height(context) * .7,
                width: global.containerWidth(context),
                padding: EdgeInsets.only(left: global.width(context) * .025),
                child: ListView(
                  children: [
                    SizedBox(
                      width: global.containerWidth(context),
                      child: Column(
                        children: [
                          CartOrderWidget(order: shopData.dummyOrders[0]),
                          global.mediumHeight(context),
                        ],
                      ),
                    ),
                    const CouponWidget(),
                    global.mediumHeight(context),
                    Summary(widget: widget),
                    global.mediumHeight(context),
                    const SubmitButton(),
                    global.mediumHeight(context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Summary extends StatelessWidget {
  const Summary({
    super.key,
    required this.widget,
  });

  final CartPage widget;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleOpacity = TextStyle(
        color: Colors.white.withOpacity(.5),
        fontSize: global.width(context) * .045);
    TextStyle textStyleStandard =
        TextStyle(color: Colors.white, fontSize: global.width(context) * .045);

    return Container(
      padding: EdgeInsets.all(global.width(context) * .05),
      height: global.height(context) * .225,
      width: global.containerWidth(context),
      decoration: global.boxDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: TextStyle(
                color: Colors.white, fontSize: global.width(context) * .06),
          ),
          SizedBox(height: global.height(context) * .015),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: textStyleOpacity,
              ),
              Text(
                  '€${widget.cartItems.fold(0, (sum, item) => sum += item.itemOriginalCost)}',
                  style: textStyleStandard)
            ],
          ),
          SizedBox(height: global.height(context) * .01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Shipping Fee', style: textStyleOpacity),
              global.gradient(
                Text('Free', style: textStyleStandard),
              )
            ],
          ),
          SizedBox(height: global.height(context) * .01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Discount', style: textStyleOpacity),
              Text(
                  '€${widget.cartItems.map((item) => item.itemDiscountCost - item.itemOriginalCost).reduce((sum, x) => sum += x).abs()}',
                  style: textStyleStandard)
            ],
          ),
          SizedBox(
            height: global.height(context) * .01,
          ),
          Container(
            height: 1.5,
            width: global.containerWidth(context),
            color: Colors.white.withOpacity(.5),
          ),
          SizedBox(
            height: global.height(context) * .01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: textStyleOpacity),
              Text(
                  '€${widget.cartItems.map((item) => item.itemDiscountCost).reduce((sum, x) => sum += x)}',
                  style: textStyleStandard)
            ],
          )
        ],
      ),
    );
  }
}

class CartOrderWidget extends StatelessWidget {
  final shopData.Order order;

  const CartOrderWidget({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: global.width(context) * .02,
          ),
          global.gradient(
            Text(
              'Review your order:',
              style: TextStyle(
                color: Colors.white,
                fontSize: global.width(context) * .045,
              ),
            ),
          ),
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

class CouponWidget extends StatelessWidget {
  const CouponWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        top: global.width(context) * .06,
        left: global.width(context) * .05,
        right: global.width(context) * .05,
        bottom: global.width(context) * .025,
      ),
      width: global.containerWidth(context),
      height: global.height(context) * .175,
      decoration: global.boxDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: global.height(context) * .08,
            width: global.containerWidth(context),
            decoration: BoxDecoration(
              color: global.darkGrey,
              borderRadius: BorderRadius.circular(30),
              boxShadow: global.shadow(context),
            ),
            child: EntryWidget(
              title: 'Coupon Code',
              entryController: shopData.Order.couponController,
            ),
          )
        ],
      ),
    );
  }
}
