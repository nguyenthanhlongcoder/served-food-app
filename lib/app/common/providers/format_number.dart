import 'package:intl/intl.dart';

String formatNumber(int number) {
  var formatter = NumberFormat.decimalPattern('loc');
  return formatter.format(number).toString();
}
