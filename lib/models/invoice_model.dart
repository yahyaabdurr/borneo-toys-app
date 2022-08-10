import 'package:cloud_firestore/cloud_firestore.dart';

class Invoice {
  final String? id;
  final String userId;
  final String invoiceNo;
  final String trasactionDate;
  final int totalPrice;
  final int totalProduk;
  final List<ProductItems>? items;

  Invoice(
      {this.id,
      required this.userId,
      this.items,
      required this.invoiceNo,
      required this.totalPrice,
      required this.totalProduk,
      required this.trasactionDate});

  Invoice.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        userId = doc.data()?['userId'],
        totalProduk = doc.data()?['totalProduk'],
        totalPrice = doc.data()?['totalPrice'],
        invoiceNo = doc.data()?['invoiceNo'],
        trasactionDate = doc.data()?['trasactionDate'],
        items = doc.data()?["items"] == null
            ? null
            : List.from(doc.data()?['items'])
                .map((e) => ProductItems.fromJson(e))
                .toList();

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['invoiceNo'] = invoiceNo;
    data['totalProduk'] = totalProduk;
    data['totalPrice'] = totalPrice;
    data['trasactionDate'] = trasactionDate;
    data['items'] = items?.map((e) => e.toJson()).toList();
    return data;
  }
}

class ProductItems {
  ProductItems(
      {required this.quantity,
      required this.productId,
      required this.productName,
      required this.productPrice});

  late final int quantity;
  late final String productName;
  late final String productId;
  late final int productPrice;

  ProductItems.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    productId = json['productId'];
    productName = json['productName'];
    productPrice = json['productPrice'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['productId'] = productId;
    data['productName'] = productName;
    data['productPrice'] = productPrice;
    return data;
  }
}
