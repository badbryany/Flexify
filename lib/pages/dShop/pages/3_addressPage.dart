import 'package:flexify/pages/dShop/data/shopData.dart' as shopData;
import 'package:flexify/pages/dShop/pages/widgets/EntryWidget.dart';
import 'package:flexify/pages/dShop/pages/widgets/ShopNavbar.dart';
import 'package:flexify/data/globalVariables.dart' as global;
import 'package:flexify/pages/dShop/pages/widgets/SubmitButton.dart';
import 'package:flutter/material.dart';

class AddressesPage extends StatefulWidget {
  final List<shopData.Address> addresses;

  const AddressesPage({super.key, required this.addresses});

  @override
  State<AddressesPage> createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ShopNavbar(
              title: 'Addresses',
              titleSize: global.width(context) * .07,
            ),
            const AddNewAdressWidget(),
            global.mediumHeight(context),
            SizedBox(
              height: global.height(context) * .6,
              width: global.containerWidth(context),
              child: ListView(
                children: widget.addresses
                    .map((address) => AddressWidget(address: address))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressWidget extends StatelessWidget {
  final shopData.Address address;

  const AddressWidget({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    TextStyle greyText = TextStyle(
      color: Colors.white.withOpacity(.5),
      fontSize: global.width(context) * .04,
    );

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(
            global.width(context) * .055,
          ),
          height: global.height(context) * .175,
          width: global.containerWidth(context),
          decoration: global.boxDecoration(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: global.height(context) * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  global.gradient(
                    Text(
                      address.addressName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: global.width(context) * .06),
                    ),
                  ),
                  SizedBox(
                    width: global.width(context) * .025,
                  ),
                  global.gradient(
                    Icon(
                      Icons.location_on_outlined,
                      size: global.width(context) * .05,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: global.height(context) * .015,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      '${address.streetName} ${address.streetNumber.toString()}',
                      style: greyText),
                  Text('${address.city}, ${address.state}, ${address.postcode}',
                      style: greyText),
                  Text(address.country, style: greyText)
                ],
              )
            ],
          ),
        ),
        SizedBox(height: global.height(context) * .02)
      ],
    );
  }
}

class AddNewAdressWidget extends StatelessWidget {
  const AddNewAdressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddAddressPage()));
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
              'Add new address',
              style: TextStyle(
                  color: Colors.white, fontSize: global.width(context) * .05),
            ),
          ],
        ),
      ),
    );
  }
}

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ShopNavbar(
              title: 'Add Address',
            ),
            SizedBox(
              height: global.height(context) * .7,
              width: global.containerWidth(context),
              child: ListView(
                children: [
                  const AddressForm(),
                  global.mediumHeight(context),
                  const SubmitButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressForm extends StatefulWidget {
  const AddressForm({
    super.key,
  });

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: global.width(context) * .05,
          vertical: global.height(context) * .02,
          ),
      height: global.height(context) * .55,
      width: global.containerWidth(context),
      decoration: global.boxDecoration(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EntryWidget(
            title: 'Nickname',
            entryController: shopData.Address.addressNameController,
          ),
          global.mediumHeight(context),
          Row(
            children: [
              EntryWidget(
                title: 'Street Name',
                width: global.width(context) * .5,
                entryController: shopData.Address.streetNameController,
              ),
              SizedBox(
                width: global.width(context) * .05,
              ),
              EntryWidget(
                title: 'Number',
                width: global.width(context) * .3,
                entryController: shopData.Address.streetNumberController,
              ),
            ],
          ),
          global.mediumHeight(context),
          Row(
            children: [
              EntryWidget(
                title: 'City',
                width: global.width(context) * .4,
                entryController: shopData.Address.cityController,
              ),
              SizedBox(
                width: global.width(context) * .05,
              ),
              EntryWidget(
                title: 'State',
                width: global.width(context) * .4,
                entryController: shopData.Address.stateController,
              ),
            ],
          ),
          global.mediumHeight(context),
          Row(
            children: [
              EntryWidget(
                title: 'Postcode',
                width: global.width(context) * .3,
                entryController: shopData.Address.postcodeController,
              ),
              SizedBox(
                width: global.width(context) * .05,
              ),
              EntryWidget(
                title: 'Country',
                width: global.width(context) * .5,
                entryController: shopData.Address.countryController,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
