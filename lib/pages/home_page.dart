part of 'pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    showMyDialog(BuildContext context) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext secondContext) {
          return AlertDialog(
            title: const Text('Konfirmasi Keluar'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text(
                    'Apakah Anda yakin ingin keluar ?',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Tidak',
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
                    'Ya, Lanjutkan',
                    style: nunitoTextFont.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  onPressed: () async {
                    FlutterSecureStorage storage = const FlutterSecureStorage();
                    await storage.write(key: "isAlreadyLogin", value: "false");
                    Get.offAll(const LoginPage());
                  },
                ),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: const <Widget>[],
        title: const Text('Borneo Toys'),
        automaticallyImplyLeading: false,
        titleTextStyle:
            nunitoTextFont.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 150,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFFD8D6D6)),
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Selamat Data User",
                      textAlign: TextAlign.center,
                      style: nunitoTextFont.copyWith(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(const InvoicePage());
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(pinkColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 35,
                            ),
                            const SizedBox(
                              height: 25,
                              width: 25,
                              child: Image(
                                image: AssetImage('assets/icons/invoice.png'),
                              ),
                            ),
                            const SizedBox(
                              width: 35,
                            ),
                            Text(
                              "Invoice",
                              style: nunitoTextFont.copyWith(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(const CartPage());
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(pinkColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 35,
                            ),
                            const SizedBox(
                              height: 25,
                              width: 25,
                              child: Image(
                                image: AssetImage('assets/icons/cart.png'),
                              ),
                            ),
                            const SizedBox(
                              width: 35,
                            ),
                            Text(
                              "Keranjang",
                              style: nunitoTextFont.copyWith(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(const ProductPage());
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(pinkColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 35,
                            ),
                            const SizedBox(
                              height: 25,
                              width: 25,
                              child: Image(
                                image: AssetImage('assets/icons/products.png'),
                              ),
                            ),
                            const SizedBox(
                              width: 35,
                            ),
                            Text(
                              "Product",
                              style: nunitoTextFont.copyWith(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        showMyDialog(context);
                      },
                      child: Text(
                        "Keluar",
                        style: nunitoTextFont.copyWith(
                            fontSize: 18, color: blueColor),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
