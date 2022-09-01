part of 'services.dart';

class ProductService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Product>> retrieveProducts() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("products").get();
    return snapshot.docs
        .map((docSnapshot) => Product.fromDocumentSnapshot(docSnapshot))
        .toList();
  }

  Future<void> updateProduct(Product? productData) async {
    if (productData != null) {
      await _db
          .collection("products")
          .doc(productData.id)
          .update(productData.toJson());
    }
  }

  Future<Product> getProduct(String docId) async {
    DocumentSnapshot query = await FirebaseFirestore.instance.doc(docId).get();

    final data = query.data() as Map<String, dynamic>;

    return Product(
        id: docId,
        itemName: data['itemName'],
        itemCategory: data['itemCategory'],
        itemPrice: data['itemPrice'],
        itemStock: data['itemName'],
        productId: data['itemName']);
  }
}
