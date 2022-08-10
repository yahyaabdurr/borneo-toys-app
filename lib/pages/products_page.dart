part of 'pages.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductService service = ProductService();
  Future<List<Product>>? productsList;
  List<Product>? retrievedproductsList;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<ProductController>(context, listen: false).initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Daftar Produk"),
        titleTextStyle: nunitoTextFont.copyWith(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: primaryColor,
        leading: GestureDetector(
          onTap: () {
            Get.off(const HomePage());
          },
          child: const SizedBox(
            height: 24,
            width: 24,
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Consumer<ProductController>(builder: (context, provider, _) {
          return Column(
            children: [
              SizedBox(
                height: 45,
                child: TextField(
                  onEditingComplete: () {
                    provider.searchData();
                    FocusScopeNode currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  controller: provider.searchQuery,
                  keyboardType: TextInputType.text,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                      hintText: 'Cari Product',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      suffixIcon: const Icon(Icons.search)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: provider.productsList,
                builder: (BuildContext context,
                    AsyncSnapshot<List<Product>> snapshot) {
                  if (snapshot.hasData &&
                      (snapshot.data?.isNotEmpty ?? false)) {
                    return ListView.separated(
                        shrinkWrap: true,
                        itemCount: provider.retrievedproductsList.length,
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: provider.retrievedproductsList[index],
                          );
                        });
                  } else if (snapshot.connectionState == ConnectionState.done &&
                      provider.retrievedproductsList.isEmpty) {
                    return Center(
                      child: ListView(
                        children: const <Widget>[
                          Align(
                              alignment: AlignmentDirectional.center,
                              child: Text('No data available')),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          );
        }),
      )),
    ));
  }
}
