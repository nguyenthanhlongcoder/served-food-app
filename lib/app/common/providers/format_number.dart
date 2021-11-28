import 'package:intl/intl.dart';

String formatNumber(int number) {
  var formatter = NumberFormat.decimalPattern('loc');
  return formatter.format(number).toString();
}

String reduceNumber(int number, int afterDot) {
  if (number == null) {
    return '...';
  }
  var formatNumber = number / 1000000;
  return formatNumber.toStringAsFixed(afterDot) + 'tr';
}

String reduceNumber2(double number, int afterDot) {
  if (number == null) {
    return '...';
  }
  var formatNumber = number / 1000000;
  return formatNumber.toStringAsFixed(afterDot) + 'tr';
}
