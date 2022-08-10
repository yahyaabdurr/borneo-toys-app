import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  final String? id;
  final String userId;
  final List<Items>? items;

  Cart({this.id, required this.userId, this.items});

  Cart.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        userId = doc.data()?['userId'],
        items = doc.data()?["items"] == null
            ? null
            : List.from(doc.data()?['items'])
                .map((e) => Items.fromJson(e))
                .toList();

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['items'] = items?.map((e) => e.toJson()).toList();
    return data;
  }
}

class Items {
  Items({
    required this.numOfProducts,
    required this.productId,
  });
  late int numOfProducts;
  late String productId;

  Items.fromJson(Map<String, dynamic> json) {
    numOfProducts = json['numOfProducts'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['numOfProducts'] = numOfProducts;
    data['productId'] = productId;
    return data;
  }
}
