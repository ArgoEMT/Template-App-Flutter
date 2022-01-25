import 'package:intl/intl.dart';

/// Extension on DateTime.
extension DateExtension on DateTime {
  /// Return a string formated to dd/MM/yyyyy.
  String toFrenchDate() {
    var frenchFormat = DateFormat('dd/MM/yyyy');
    return frenchFormat.format(this);
  }
}
