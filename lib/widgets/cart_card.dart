part of 'widgets.dart';

// ignore: must_be_immutable
class CartCard extends StatelessWidget {
  Product? product;
  int? numOfProducts;
  CartCard({Key? key, this.product, this.numOfProducts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: pinkColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all()),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Text(
                    "X ${numOfProducts.toString()}",
                    style: nunitoTextFont.copyWith(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              Expanded(
                flex: 7,
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
                          Utils.formatCurrency(product?.itemPrice ?? 0),
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
            ],
          )
        ],
      ),
    );
  }
}
