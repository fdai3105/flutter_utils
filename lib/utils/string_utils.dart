import 'package:intl/intl.dart';

class StringUtils {
  const StringUtils._();

  static String formatCurrency(num currency) {
    return NumberFormat().format(currency);
  }

  static String sub(int length, String string) {
    if (string.length > length) return '${string.substring(0, length)}...';
    return string;
  }
}
