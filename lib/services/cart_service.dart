part of 'services.dart';

class CartService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addCart(Cart cart) async {
    await _db.collection("carts").add(cart.toMap());
  }

  updateCart(Cart cart) async {
    await _db.collection("carts").doc(cart.id).update(cart.toMap());
  }

  Future<Cart?> isUserAlreadyExist(String userId) async {
    QuerySnapshot<Map<String, dynamic>> query = await FirebaseFirestore.instance
        .collection('carts')
        .where('userId', isEqualTo: userId)
        .get();
    return query.docs.isNotEmpty
        ? Cart.fromDocumentSnapshot(query.docs.first)
        : null;
  }

  Future<void> deleteCart(String? documentId) async {
    await _db.collection("carts").doc(documentId).delete();
  }

  Future<Product?> getProduct(String productId) async {
    QuerySnapshot<Map<String, dynamic>> query = await FirebaseFirestore.instance
        .collection('products')
        .where('productId', isEqualTo: productId)
        .get();
    return query.docs.isNotEmpty
        ? Product.fromDocumentSnapshot(query.docs.first)
        : null;
  }
}
