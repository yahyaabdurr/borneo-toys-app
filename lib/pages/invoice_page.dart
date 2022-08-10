part of 'pages.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({Key? key}) : super(key: key);

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<InvoiceController>(context, listen: false).initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<InvoiceController>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Invoice"),
          titleTextStyle: nunitoTextFont.copyWith(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          backgroundColor: primaryColor,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const SizedBox(
              height: 24,
              width: 24,
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: FutureBuilder(
              future: provider.invoiceList,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Invoice>> snapshot) {
                if (snapshot.hasData && (snapshot.data?.isNotEmpty ?? false)) {
                  return ListView.separated(
                      shrinkWrap: true,
                      itemCount: provider.retrievedInvoiceList.length,
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemBuilder: (context, index) {
                        return InvoiceCard(
                            invoice: provider.retrievedInvoiceList[index]);
                      });
                } else if (snapshot.connectionState == ConnectionState.done &&
                    provider.retrievedInvoiceList.isEmpty) {
                  return SizedBox(
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
                            child: Lottie.asset('assets/lotties/empty.json')),
                        Text(
                          "Invoice tidak ditemukan",
                          style: nunitoTextFont.copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Silahkan melakukukan transaksi terlebih dahulu",
                          style: nunitoTextFont.copyWith(
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        )),
      );
    });
  }
}
