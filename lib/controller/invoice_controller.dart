part of 'controllers.dart';

class InvoiceController extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  InvoiceService service = InvoiceService();
  Future<List<Invoice>>? invoiceList;
  List<Invoice> retrievedInvoiceList = [];

  List<String> poolSearch = [];

  Future<void> initData() async {
    invoiceList = null;
    retrievedInvoiceList = [];
    notifyListeners();
    final User? user = auth.currentUser;
    final uid = user?.uid ?? "";
    invoiceList = service.getInvoiceList(uid);
    retrievedInvoiceList = await service.getInvoiceList(uid);
    notifyListeners();
  }

  Future generate(Invoice invoice) async {
    File file = await InvoiceService.generate(invoice);

    return file;
  }

  Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
