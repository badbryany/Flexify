import 'package:flutter/material.dart';

List<String> orderStatusTypes = [
  'Ordered',
  'Processing',
  'Packed',
  'Shipped',
  'Delivered'
];

List<Address> dummyAddresses = [
  Address(
      addressName: 'My Home',
      streetName: 'Figgle Street',
      streetNumber: 7,
      city: 'Ottawa',
      state: 'Ontario',
      postcode: 'Z023 2EZ',
      country: 'United States'),
  Address(
      addressName: 'Office',
      streetName: 'Big Dame Lane',
      streetNumber: 2,
      city: 'Ottawa',
      state: 'Ontario',
      postcode: 'Z021 2EZ',
      country: 'United States')
];

List<Review> dummyReviews1 = [
  Review(
      username: 'Bruder1',
      stars: 4,
      title: 'title',
      description:
          'This is a review about this product that I don\'t really care to properly write because it\'s not real anyway',
      date: DateTime.now()),
  Review(
      username: 'Bruder1',
      stars: 3,
      title: 'title',
      description:
          'This is a review about this product that I don\'t really care to properly write because it\'s not real anyway',
      date: DateTime.now().subtract(const Duration(days: 1))),
  Review(
      username: 'Bruder1',
      stars: 2,
      title: 'title',
      description:
          'This is a review about this product that I don\'t really care to properly write because it\'s not real anyway',
      date: DateTime.now().subtract(const Duration(days: 2))),
  Review(
      username: 'Bruder1',
      stars: 1,
      title: 'title',
      description:
          'This is a review about this product that I don\'t really care to properly write because it\'s not real anyway',
      date: DateTime.now().subtract(const Duration(days: 1))),
  Review(
      username: 'Bruder1',
      stars: 5,
      title: 'title',
      description:
          'This is a review about this product that I don\'t really care to properly write because it\'s not real anyway',
      date: DateTime.now().subtract(const Duration(days: 1))),
  Review(
      username: 'Bruder1',
      stars: 4,
      title: 'title',
      description:
          'This is a review about this product that I don\'t really care to properly write because it\'s not real anyway',
      date: DateTime.now().subtract(const Duration(days: 1))),
];

List<Item> dummyItems = [
  Item(
    itemBrand: 'Gucci',
    itemName: 'Knitted Sweater',
    itemOriginalCost: 520,
    itemDiscountCost: 420,
    itemReviews: dummyReviews1,
    itemDescription: 'description that just does what a description I guess',
    itemDetails: 'wow',
    itemSaved: false,
    itemCart: false,
  ),
  Item(
    itemBrand: 'Prada',
    itemName: 'Knitted Trousers',
    itemOriginalCost: 320,
    itemDiscountCost: 420,
    itemReviews: dummyReviews1,
    itemDescription: 'description that just does what a description I guess',
    itemDetails: 'wow',
    itemSaved: true,
    itemCart: true,
  ),
  Item(
    itemBrand: 'Louis Vuitton',
    itemName: 'Baggy Pants',
    itemOriginalCost: 120,
    itemDiscountCost: 310,
    itemReviews: dummyReviews1,
    itemDescription: 'description that just does what a description I guess',
    itemDetails: 'wow',
    itemSaved: true,
    itemCart: true,
  ),
  Item(
    itemBrand: 'Louis Vuitton',
    itemName: 'Baggy Pants',
    itemOriginalCost: 120,
    itemDiscountCost: 310,
    itemReviews: dummyReviews1,
    itemDescription: 'description that just does what a description I guess',
    itemDetails: 'wow',
    itemSaved: false,
    itemCart: false,
  ),
  Item(
    itemBrand: 'Gucci',
    itemName: 'Knitted Sweater',
    itemOriginalCost: 520,
    itemDiscountCost: 420,
    itemReviews: dummyReviews1,
    itemDescription: 'description that just does what a description I guess',
    itemDetails: 'wow',
    itemSaved: false,
    itemCart: false,
  ),
  Item(
    itemBrand: 'Prada',
    itemName: 'Knitted Trousers',
    itemOriginalCost: 320,
    itemDiscountCost: 420,
    itemReviews: dummyReviews1,
    itemDescription: 'description that just does what a description I guess',
    itemDetails: 'wow',
    itemSaved: true,
    itemCart: false,
  ),
];

List<Order> dummyOrders = [
  Order(
    orderItems: [dummyItems[0], dummyItems[1]],
    orderDate: DateTime.now(),
    orderStatusIdx: 3,
  ),
  Order(
    orderItems: [dummyItems[2], dummyItems[3], dummyItems[4]],
    orderDate: DateTime.now(),
    orderStatusIdx: 2,
  ),
];

List<Card> dummyCards = [
  Card(
    cardNumber: "0123 1234 2345 3456",
    cardHolder: "Anna Maier",
    cardExpiry: (11, 12),
    cardCVV: 777,
  ),
  Card(
    cardNumber: "0123 1234 2345 3456",
    cardHolder: "Osama Bin Laden",
    cardExpiry: (9, 11),
    cardCVV: 777,
  )
];

class Review {
  String username;
  int stars;
  String title;
  String description;
  DateTime date;

  Review({
    required this.username,
    required this.stars,
    required this.title,
    required this.description,
    required this.date,
  });

  static final TextEditingController reviewTitleController = TextEditingController();
  static final TextEditingController reviewDescriptionController = TextEditingController();

}

class Item {
  String itemBrand;
  String itemName;
  int itemOriginalCost;
  int itemDiscountCost;
  String itemDetails;
  String itemDescription;
  List<Review> itemReviews;
  bool itemSaved;
  bool itemCart;

  Item({
    required this.itemBrand,
    required this.itemName,
    required this.itemOriginalCost,
    required this.itemDiscountCost,
    required this.itemReviews,
    required this.itemDescription,
    required this.itemDetails,
    required this.itemSaved,
    required this.itemCart,
  });
}

class Order {
  static int counterID = 0;
  List<Item> orderItems;
  int orderStatusIdx;
  DateTime orderDate;
  String orderID;
  String? couponCode;

  Order({
    required this.orderItems,
    required this.orderDate,
    required this.orderStatusIdx,
    this.orderID = '0',
    this.couponCode,
  });

  static final TextEditingController couponController = TextEditingController();

}

class Address {
  String addressName;
  String streetName;
  int streetNumber;
  String city;
  String state;
  String postcode;
  String country;

  static final TextEditingController addressNameController =
      TextEditingController();
  static final TextEditingController streetNameController =
      TextEditingController();
  static final TextEditingController streetNumberController =
      TextEditingController();
  static final TextEditingController cityController = TextEditingController();
  static final TextEditingController stateController = TextEditingController();
  static final TextEditingController postcodeController =
      TextEditingController();
  static final TextEditingController countryController =
      TextEditingController();

  static void clearControllers() {
    addressNameController.clear();
    streetNameController.clear();
    streetNumberController.clear();
    cityController.clear();
    stateController.clear();
    postcodeController.clear();
    countryController.clear();
  }

  Address({
    required this.addressName,
    required this.streetName,
    required this.streetNumber,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
  });
}

class Card {
  String cardNumber;
  String cardHolder;
  (int, int) cardExpiry;
  int cardCVV;

  static final TextEditingController cardHolderController =
      TextEditingController();
  static final TextEditingController cardNumberController =
      TextEditingController();
  static final TextEditingController expiryDateController =
      TextEditingController();
  static final TextEditingController cvvController = TextEditingController();

  static void clearControllers() {
    cardHolderController.clear();
    cardNumberController.clear();
    expiryDateController.clear();
    cvvController.clear();
  }

  Card({
    required this.cardNumber,
    required this.cardHolder,
    required this.cardExpiry,
    required this.cardCVV,
  });
}
