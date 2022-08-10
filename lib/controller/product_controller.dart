part of 'controllers.dart';

class ProductController extends ChangeNotifier {
  TextEditingController searchQuery = TextEditingController();
  ProductService service = ProductService();
  Future<List<Product>>? productsList;
  List<Product> retrievedproductsList = [];
  List<Product> tempProductList = [];

  List<String> poolSearch = [];

  void initData() async {
    searchQuery.clear();
    await initProducts();
    searchData();
  }

  Future<void> initProducts() async {
    productsList = service.retrieveProducts();
    tempProductList = await service.retrieveProducts();
    await addToPoolSearch();
  }

  Future<void> addToPoolSearch() async {
    poolSearch = [];

    for (Product value in tempProductList) {
      poolSearch.add(
          "${value.itemName.toLowerCase()} ${value.productId.toLowerCase()}");
    }
    notifyListeners();
  }

  void searchData() {
    List<Product> productAfterSearch = [];
    if (searchQuery.text.isEmpty) {
      retrievedproductsList = tempProductList;
    } else {
      List<String> listSearch =
          searchQuery.text.trim().toLowerCase().split(" ");
      int index = 0;
      for (String value in poolSearch) {
        for (int i = 0; i < listSearch.length; i++) {
          if (value.contains(listSearch[i])) {
            if (!productAfterSearch.any((element) =>
                element.itemName.toLowerCase().contains(listSearch[i]))) {
              productAfterSearch.add(tempProductList.elementAt(index));
            }
          }
        }
        index++;
      }

      retrievedproductsList = productAfterSearch;
      notifyListeners();
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   _initRetrieval();
  // }

  // Future<void> _initRetrieval() async {
  //   productsList = service.retrieveProducts();
  //   retrievedproductsList = await service.retrieveProducts();
  // }
}
