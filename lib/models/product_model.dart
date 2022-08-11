// ignore_for_file: empty_constructor_bodies

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String? id;
  final String productId;
  final String itemName;
  int itemStock;
  final int itemPrice;

  Product(
      {required this.productId,
      this.id,
      required this.itemStock,
      required this.itemPrice,
      required this.itemName});

  Product.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        productId = doc.data()!["productId"],
        itemName = doc.data()!["itemName"],
        itemStock = doc.data()!["itemStock"],
        itemPrice = doc.data()!["itemPrice"];

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'itemName': itemName,
      'itemPrice': itemPrice,
      'itemStock': itemStock,
    };
  }
}
