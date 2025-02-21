import 'package:intl/intl.dart';

class MethodsClassUTls {
  //

  // static String formatNumber({required double number, int? numberAfterdot}) {
  //   String formattedString = number.toStringAsFixed(
  //       number.truncateToDouble() == number ? 0 : numberAfterdot ?? 2);
  //   formattedString.endsWith(numberAfterdot != null ? ".0" : ".00")
  //       ? formattedString.split(".")[0]
  //       : formattedString;

  //   //
  //   // Create a NumberFormat instance for formatting numbers with commas
  //   final formatter = NumberFormat('#,##0', 'en_US');

  //   // Format the number with commas
  //   return formatter.format(number);
  // }

  static String formatNumber({required double number, int? numberAfterdot}) {
    // Use the provided decimal precision (or default to 2)
    int decimals = numberAfterdot ?? 2;

    // Convert the number to a string with a fixed number of decimals.
    String fixedStr = number.toStringAsFixed(decimals);

    // If there's a decimal point, remove trailing zeros and the decimal point if necessary.
    if (fixedStr.contains('.')) {
      fixedStr = fixedStr.replaceAll(RegExp(r'0*$'), '');
      fixedStr = fixedStr.replaceAll(RegExp(r'\.$'), '');
    }

    // Split the number into integer and fractional parts.
    List<String> parts = fixedStr.split('.');
    String intPart = parts[0];
    String fracPart = parts.length > 1 ? parts[1] : '';

    // Format the integer part with thousand separators.
    final formattedIntPart =
        NumberFormat('#,##0', 'en_US').format(int.tryParse(intPart) ?? 0);

    // Return the combined formatted result.
    return fracPart.isEmpty ? formattedIntPart : '$formattedIntPart.$fracPart';
  }

  // end Class
}
