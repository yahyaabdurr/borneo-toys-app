part of 'widgets.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  Product? product;
  ProductCard({Key? key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> showMyDialog(BuildContext context) async {
      final formKey = GlobalKey<FormState>();
      TextEditingController number = TextEditingController();
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext secondContext) {
          return Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.always,
            child: AlertDialog(
              title: const Text('Tambah Keranjang'),
              insetPadding: const EdgeInsets.all(5),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    TextFormField(
                      controller: number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: greyWhiteColor,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.all(10),
                        hintText: 'Masukan jumlah barang',
                        hintStyle: GoogleFonts.nunitoSans()
                            .copyWith(color: Colors.grey, fontSize: 12),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return "Tidak boleh kosong";
                        } else if (int.parse(value!) < 1) {
                          return "Jumlah barang minimal 1";
                        } else if (int.parse(value) >
                            (product?.itemStock ?? 0)) {
                          return "Jumlah barang tidak boleh lebih dari ${product?.itemStock.toString() ?? "0"} ";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Kode : ${product?.productId}",
                      style: nunitoTextFont.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Nama : ${product?.itemName}",
                      style: nunitoTextFont.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Harga : ${product?.itemPrice.toString()}",
                      style: nunitoTextFont.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Sisa :  ${product?.itemStock.toString()}",
                      style: nunitoTextFont.copyWith(fontSize: 16),
                    )
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
                    Get.back();
                  },
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    child: Text(
                      'Tambah',
                      style: nunitoTextFont.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        var cartController =
                            Provider.of<CartController>(context, listen: false);

                        await cartController.addCart(
                            product!, int.parse(number.text));
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return InkWell(
      onTap: () {
        showMyDialog(context);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: pinkColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all()),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product?.itemName ?? "KOSONG",
                  style: nunitoTextFont.copyWith(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Rp  ${product?.itemPrice.toString()}",
                  style: nunitoTextFont.copyWith(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "Kode Product : ${product?.productId} ",
                  style: nunitoTextFont.copyWith(
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Sisa product : ${product?.itemStock.toString()}",
                  style: nunitoTextFont.copyWith(
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
