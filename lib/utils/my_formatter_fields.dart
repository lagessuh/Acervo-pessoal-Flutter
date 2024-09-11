import 'package:intl/intl.dart';

class MyFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(amount);
  }

  static String formatPhone(String phone) {
    if (phone.length == 10) {
      return '(${phone.substring(0, 3)}) ${phone.substring(3, 6)} ${phone.substring(6)}';
    } else if (phone.length == 11) {
      return '(${phone.substring(0, 4)}) ${phone.substring(4, 7)} ${phone.substring(7)}';
    }
    return phone;
  }
}
