import 'package:intl/intl.dart';

class MethodsClassUTls {
  //

  static String formatNumber({required double number, int? numberAfterdot}) {
    String formattedString = number.toStringAsFixed(
        number.truncateToDouble() == number ? 0 : numberAfterdot ?? 2);
    formattedString.endsWith(numberAfterdot != null ? ".0" : ".00")
        ? formattedString.split(".")[0]
        : formattedString;

    //
    // Create a NumberFormat instance for formatting numbers with commas
    final formatter = NumberFormat('#,##0', 'en_US');

    // Format the number with commas
    return formatter.format(number);
  }
}
