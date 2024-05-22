import 'package:flexify/pages/dShop/pages/widgets/EntryWidget.dart';
import 'package:flexify/pages/dShop/pages/widgets/ShopNavbar.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/pages/dShop/pages/widgets/SubmitButton.dart';
import 'package:flutter/material.dart';
import 'package:flexify/pages/dShop/data/shopData.dart' as shopData;
import 'package:flutter_svg/flutter_svg.dart';

class WalletPage extends StatefulWidget {
  final List<shopData.Card> cards;

  const WalletPage({super.key, required this.cards});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ShopNavbar(
              title: 'Wallet',
              titleSize: global.width(context) * .09,
            ),
            const AddCardWidget(),
            global.mediumHeight(context),
            SizedBox(
              height: global.height(context) * .65,
              width: global.containerWidth(context),
              child: ListView(
                children:
                    widget.cards.map((card) => CardWidget(card: card)).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final shopData.Card card;

  const CardWidget({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: global.width(context) * .05,
          ),
          height: global.height(context) * .23,
          width: global.containerWidth(context),
          decoration: BoxDecoration(
              color: global.darkGrey,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [global.darkShadow(context)]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: global.height(context) * .1,
                width: global.containerWidth(context),
                child: Padding(
                  padding: EdgeInsets.only(right: global.width(context) * .02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: global.height(context) * .03),
                        child: const CardChip(),
                      ),
                      SvgPicture.asset(
                        'assets/icon/visa.svg',
                        height: global.width(context) * .2,
                        width: global.width(context) * .2,
                        color: Colors.white,
                        semanticsLabel: 'Your Image',
                      ),
                    ],
                  ),
                ),
              ),
              global.gradient(
                Text(
                  card.cardNumber,
                  style: TextStyle(
                    fontSize: global.width(context) * .07,
                  ),
                ),
              ),
              SizedBox(
                height: global.height(context) * .02,
              ),
              Text(
                card.cardHolder,
                style: TextStyle(
                  fontSize: global.width(context) * .05,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: global.height(context) * .01,
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: global.width(context) * .03,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Expiry ${card.cardExpiry.$1}/${card.cardExpiry.$2}',
                      style: TextStyle(
                          fontSize: global.width(context) * .04,
                          color: Colors.white.withOpacity(.7)),
                    ),
                    Text(
                      'CVV',
                      style: TextStyle(
                          fontSize: global.width(context) * .04,
                          color: Colors.white.withOpacity(.5)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: global.height(context) * .02)
      ],
    );
  }
}

class CardChip extends StatelessWidget {
  const CardChip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: global.width(context) * .2,
      width: global.width(context) * .42,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          global.gradient(
            Row(
              children: [
                Container(
                  height: global.width(context) * .0225,
                  width: global.width(context) * .0225,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(5))),
                ),
                SizedBox(width: global.width(context) * .01),
                Container(
                  height: global.width(context) * .0225,
                  width: global.width(context) * .0225,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: global.width(context) * .01),
                Container(
                  height: global.width(context) * .0225,
                  width: global.width(context) * .0225,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topRight: Radius.circular(5))),
                ),
              ],
            ),
          ),
          SizedBox(height: global.width(context) * .01),
          global.gradient(
            Container(
              height: global.width(context) * .0225,
              width: global.width(context) * .0875,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: global.width(context) * .01),
          global.gradient(
            Row(
              children: [
                Container(
                  height: global.width(context) * .0225,
                  width: global.width(context) * .0225,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(5))),
                ),
                SizedBox(width: global.width(context) * .01),
                Container(
                  height: global.width(context) * .0225,
                  width: global.width(context) * .0225,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: global.width(context) * .01),
                Container(
                  height: global.width(context) * .0225,
                  width: global.width(context) * .0225,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(5))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddCardWidget extends StatelessWidget {
  const AddCardWidget({
    super.key,
  });

  void openAddCardPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddCardPage()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openAddCardPage(context);
      },
      child: Container(
        height: global.height(context) * .075,
        width: global.containerWidth(context),
        decoration: BoxDecoration(
            color: global.darkGrey,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [global.darkShadow(context)]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_rounded,
              size: global.width(context) * .075,
              color: Colors.white,
            ),
            SizedBox(
              width: global.width(context) * .02,
            ),
            Text(
              'Add new card',
              style: TextStyle(
                  color: Colors.white, fontSize: global.width(context) * .05),
            ),
          ],
        ),
      ),
    );
  }
}

class AddCardPage extends StatefulWidget {
  const AddCardPage({
    super.key,
  });

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ShopNavbar(
              title: 'Add Card',
              onTap: shopData.Card.clearControllers,
            ),
            const CardForm(),
            global.mediumHeight(context),
            const SubmitButton(),
          ],
        ),
      ),
    );
  }
}

class CardForm extends StatelessWidget {
  const CardForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: global.width(context) * .05,
          vertical: global.height(context) * .02,
          ),
      height: global.height(context) * .45,
      width: global.containerWidth(context),
      decoration: global.boxDecoration(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EntryWidget(
            title: 'Card Holder',
            entryController: shopData.Card.cardHolderController,
          ),
          global.mediumHeight(context),
          EntryWidget(
            title: 'Card Number',
            entryController: shopData.Card.cardNumberController,
          ),
          global.mediumHeight(context),
          Row(
            children: [
              EntryWidget(
                title: 'Expiry Date',
                width: global.width(context) * .4,
                entryController: shopData.Card.expiryDateController,
              ),
              SizedBox(
                width: global.width(context) * .05,
              ),
              EntryWidget(
                title: 'CVV',
                width: global.width(context) * .4,
                entryController: shopData.Card.cvvController,
              )
            ],
          )
        ],
      ),
    );
  }
}
