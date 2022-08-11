part of 'controllers.dart';

class CartController extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  CartService service = CartService();
  Future<Cart>? userCart;

  int _totalPrice = 0;
  int _totalProduk = 0;
  get totalPrice => _totalPrice;

  set totalPrice(value) => _totalPrice = value;

  get totalProduk => _totalProduk;

  set totalProduk(value) => _totalProduk = value;

  bool _isLoading = false;

  get isLoading => _isLoading;

  setIsLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  Cart? cart;
  List<Product?> retrievedproductsList = [];

  Future<void> initData() async {
    userCart = null;
    _totalPrice = 0;
    _totalProduk = 0;
    retrievedproductsList = [];
    notifyListeners();
    await getCarts();
  }

  Future<void> addCart(Product product, int numOfProducts) async {
    final User? user = auth.currentUser;
    final uid = user?.uid ?? "";

    Cart? userCart = await service.isUserAlreadyExist(uid);

    if (userCart != null) {
      List<Items> items = userCart.items ?? [];

      bool isAlreadyExistItems = false;

      for (int i = 0; i < (items.length); i++) {
        if (items[i].productId == product.productId) {
          isAlreadyExistItems = true;
          items[i].numOfProducts += numOfProducts;
        }
      }

      if (!isAlreadyExistItems) {
        items.add(
            Items(numOfProducts: numOfProducts, productId: product.productId));
      }

      Cart cart = Cart(id: userCart.id, userId: uid, items: items);
      await service.updateCart(cart);
      Get.off(const CartPage());
    } else {
      List<Items> items = [];
      items.add(
          Items(numOfProducts: numOfProducts, productId: product.productId));
      Cart cart = Cart(userId: uid, items: items);
      await service.addCart(cart);
      Get.off(const CartPage());
    }
  }

  Future deleteCartItem(Product? product) async {
    final User? user = auth.currentUser;
    final uid = user?.uid ?? "";

    Cart? userCart = await service.isUserAlreadyExist(uid);

    if (userCart != null) {
      List<Items> items = userCart.items ?? [];
      for (int i = 0; i < (items.length); i++) {
        if (items[i].productId == product?.productId) {
          items.remove(items[i]);
        }
      }

      Cart cart = Cart(id: userCart.id, userId: uid, items: items);
      await service.updateCart(cart);

      getCarts();
    }
  }

  Future<void> getCarts() async {
    _totalPrice = 0;
    _totalProduk = 0;
    final User? user = auth.currentUser;
    final uid = user?.uid ?? "";

    Cart? userCart = await service.isUserAlreadyExist(uid);
    userCart = userCart;
    if (userCart != null) {
      cart = userCart;
      List<Product?> listProduct = [];
      for (int i = 0; i < (userCart.items?.length ?? 0); i++) {
        Product? product =
            await service.getProduct(userCart.items![i].productId);

        _totalProduk += 1;
        _totalPrice +=
            userCart.items![i].numOfProducts * (product?.itemPrice ?? 0);
        listProduct.add(product);
      }
      retrievedproductsList = listProduct;
    } else {
      userCart = null;
    }
    notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    setIsLoading(true);
    final InvoiceService invoiceService = InvoiceService();
    final ProductService productService = ProductService();
    final User? user = auth.currentUser;

    try {
      String now = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
      String formatted =
          now.replaceAll("-", "").replaceAll(":", "").replaceAll(" ", "");
      var rng = Random();
      String randomNumber = rng.nextInt(999).toString().padLeft(3, '0');
      final uid = user?.uid ?? "";
      String invoiceNo = "INV/$formatted/$randomNumber";
      List<ProductItems> listProduct = [];

      for (int i = 0; i < _totalProduk; i++) {
        ProductItems item = ProductItems(
            quantity: cart?.items![i].numOfProducts ?? 0,
            productId: retrievedproductsList[i]?.productId ?? "",
            productPrice: retrievedproductsList[i]?.itemPrice ?? 0,
            productName: retrievedproductsList[i]?.itemName ?? "");
        listProduct.add(item);

        Product? productUpdate = retrievedproductsList[i];
        productUpdate?.itemStock =
            (productUpdate.itemStock - (cart?.items?[i].numOfProducts ?? 0));
        await productService.updateProduct(productUpdate);
      }

      Invoice invoice = Invoice(
          userId: uid,
          invoiceNo: invoiceNo,
          totalPrice: _totalPrice,
          totalProduk: _totalProduk,
          trasactionDate: now,
          items: listProduct);

      await invoiceService.addIvoice(invoice);
      await service.deleteCart(cart?.id);
      await Future.delayed(const Duration(seconds: 1));
      await GlobalFuntion.alert(
          context: context,
          message: "Transaksi Berhasil",
          titleButton: "OK",
          onTap: () async {
            Get.offAll(const InvoicePage());
            var provider =
                Provider.of<InvoiceController>(context, listen: false);
            final pdfFile = await provider.generate(invoice);
            provider.openFile(pdfFile);
          });
      setIsLoading(false);
    } catch (e) {
      setIsLoading(false);
    }
  }
}
