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

  updateProduct(Product productData) async {
    await _db
        .collection("products")
        .doc(productData.id)
        .update(productData.toJson());
  }

  Future<Product> getProduct(String docId) async {
    DocumentSnapshot query = await FirebaseFirestore.instance.doc(docId).get();

    final data = query.data() as Map<String, dynamic>;

    return Product(
        id: docId,
        itemName: data['itemName'],
        itemPrice: data['itemPrice'],
        itemStock: data['itemName'],
        productId: data['itemName']);
  }
}
