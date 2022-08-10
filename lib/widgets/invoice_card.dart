part of 'widgets.dart';

class InvoiceCard extends StatelessWidget {
  final Invoice invoice;
  const InvoiceCard({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: pinkColor,
          border: Border.all(),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            invoice.invoiceNo,
          ),
          SizedBox(
            height: 35,
            width: 100,
            child: ElevatedButton(
              onPressed: () async {
                var provider =
                    Provider.of<InvoiceController>(context, listen: false);
                final pdfFile = await provider.generate(invoice);
                provider.openFile(pdfFile);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                    width: 25,
                    child: Image(
                      image: AssetImage('assets/icons/print.png'),
                    ),
                  ),
                  Text(
                    "Cetak",
                    style: nunitoTextFont.copyWith(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
