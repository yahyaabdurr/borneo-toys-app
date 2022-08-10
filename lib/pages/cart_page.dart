part of 'pages.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<CartController>(context, listen: false).initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> showMyDialog(BuildContext context) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext secondContext) {
          return AlertDialog(
            title: const Text('Konfirmasi Belanja'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text(
                    'Apakah Anda yakin ingin proses transaksi sudah benar ?',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Batal',
                    style: nunitoTextFont.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: blueColor)),
                onPressed: () {
                  Navigator.of(secondContext).pop();
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  child: Text(
                    'Konfirmasi',
                    style: nunitoTextFont.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  onPressed: () async {
                    var controller =
                        Provider.of<CartController>(context, listen: false);
                    Get.back();
                    await controller.submit(context);
                  },
                ),
              ),
            ],
          );
        },
      );
    }

    final formatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);
    return Consumer<CartController>(
      builder: (context, provider, _) {
        return LoadingOverlay(
          isLoading: provider.isLoading,
          color: Colors.black,
          opacity: 0.65,
          progressIndicator: Shimmer.fromColors(
            baseColor: Colors.white,
            highlightColor: Colors.grey,
            child: Text(
              "Sedang menyimpan data",
              textAlign: TextAlign.center,
              style: nunitoTextFont.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("Keranjang"),
                titleTextStyle: nunitoTextFont.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    provider.retrievedproductsList.isNotEmpty
                        ? ListView.separated(
                            shrinkWrap: true,
                            itemCount: provider.retrievedproductsList.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 5,
                                ),
                            itemBuilder: (context, index) {
                              return Dismissible(
                                onDismissed: (direction) {
                                  // await service.deleteEmployee(
                                  //     retrievedEmployeeList![index]
                                  //         .id
                                  //         .toString());
                                  // _dismiss();
                                },
                                background: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                          BorderRadius.circular(16.0)),
                                  padding: const EdgeInsets.only(right: 28.0),
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: const Text(
                                    "DELETE",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                direction: DismissDirection.endToStart,
                                resizeDuration:
                                    const Duration(milliseconds: 200),
                                key: UniqueKey(),
                                child: CartCard(
                                  product:
                                      provider.retrievedproductsList[index],
                                  numOfProducts: provider
                                          .cart?.items?[index].numOfProducts ??
                                      1,
                                ),
                              );
                            })
                        : SizedBox(
                            height: (MediaQuery.of(context).size.height -
                                AppBar().preferredSize.height -
                                70),
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Lottie.asset(
                                        'assets/lotties/empty.json')),
                                Text(
                                  "Product pada keranjang belum tersedia",
                                  style: nunitoTextFont.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Silahkan tambahkan product terlebih dahulu",
                                  style: nunitoTextFont.copyWith(
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          )
                  ],
                ),
              )),
              bottomNavigationBar: provider.retrievedproductsList.isNotEmpty
                  ? Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 5.0,
                            spreadRadius: -2.0,
                            offset: Offset(-3.0, 0.0),
                          )
                        ],
                      ),
                      height: 50,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Total Harga : ${formatter.format(provider.totalPrice)}",
                                      style: nunitoTextFont.copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      "Total Barang : ${provider.totalProduk.toString()} ",
                                      style: nunitoTextFont.copyWith(
                                        fontSize: 15,
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 35,
                                width: 110,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    showMyDialog(context);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(primaryColor),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    "Berikutnya",
                                    style: nunitoTextFont.copyWith(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ))
                  : const SizedBox(),
            ),
          ),
        );
      },
    );
  }
}
