import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String? id;
  final String categoryId;
  final String categoryDesc;
  final String effectiveDate;
  final bool active;

  Category(
      {required this.categoryId,
      this.id,
      required this.categoryDesc,
      required this.effectiveDate,
      required this.active});

  Category.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        categoryId = doc.data()!["categoryId"],
        categoryDesc = doc.data()!["categoryDesc"],
        active = doc.data()?["active"] ?? false,
        effectiveDate = doc.data()!["effectiveDate"];

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'categoryDesc': categoryDesc,
      'effectiveDate': effectiveDate,
      'active': active,
    };
  }
}
