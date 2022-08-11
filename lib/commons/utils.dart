import 'package:intl/intl.dart';

class Utils {
  static formatPrice(int? price) => '\$ ${price?.toStringAsFixed(2)}';
  static formatDate(String date) {
    DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
    return DateFormat('d MMMM yyyy').format(parseDate);
  }

  static formatCurrency(int value) {
    final formatter =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    return formatter.format(value);
  }
}
