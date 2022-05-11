import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///
/// Retourne une date formaté au format jj/MM/yy. Prend un [String]
///
/// Prend une date au format yyyy-MM-dd et un bool [includeHours].
String helperFormatDateToFr(
  String? dateToFormat, {
  bool includeHours = false,
}) {
  if (dateToFormat == null || dateToFormat.isEmpty) {
    return '';
  }
  var tempDate = '';
  if (!includeHours) {
    var tempDateTime = DateFormat('yyyy-MM-dd').parse(dateToFormat).toLocal();
    tempDate = DateFormat('dd/MM/yy').format(tempDateTime);
  } else {
    var tempDateTime =
        DateFormat('yyyy-MM-ddTHH:mm:ssZ').parse(dateToFormat).toLocal();
    tempDate = DateFormat('dd/MM/yy HH:mm').format(tempDateTime);
  }
  return tempDate;
}

///
/// Retourne une date formaté au format jj/MM/yy. Prend un [String]
///
/// Prend une date au format yyyy-MM-dd et un bool [includeHours].
String helperFormatDateToBD(
  DateTime? dateToFormat, {
  bool includeHours = false,
}) {
  if (dateToFormat == null) {
    return '';
  }
  var tempDate = '';
  if (!includeHours) {
    tempDate = DateFormat('yyyy-MM-dd').format(dateToFormat);
  } else {
    tempDate = DateFormat('yyyy-MM-ddTHH:mm:ssZ').format(dateToFormat);
  }
  return tempDate;
}

///
/// Retourne une date formatée au format jj/MM/yy. Prend un [DateTime]
///
/// Prend une date et un bool [includeHours].
String dateTimeToFrDate(
  DateTime? dateToFormat, {
  bool includeHours = false,
}) {
  if (dateToFormat == null) {
    return '';
  }
  var tempDate = '';
  if (!includeHours) {
    tempDate = DateFormat('dd/MM/yy').format(dateToFormat);
  } else {
    tempDate = DateFormat('dd/MM/yy HH:mm').format(dateToFormat);
  }
  return tempDate;
}

///
/// Retourne une date formatée au format jj/MM/yy. Prend un String
///
/// Prend une date et un bool [includeHours].
String dateTimeStringToFrDate(String? dateToFormat) {
  if (dateToFormat == null) {
    return '';
  }
  return DateFormat('dd/MM/yy')
      .format(DateFormat('dd/MM/yy HH:mm').parse(dateToFormat).toLocal());
}

///
/// Retourne une heure. Prend un [DateTime]
String dateTimeToTime(DateTime? dateToFormat) {
  if (dateToFormat == null) {
    return '';
  }
  var tempDate = DateFormat('HH:mm').format(dateToFormat);
  return tempDate;
}

///
/// Retourne un DateTime d'une date formatée au format jj/MM/yy.
///
/// Prend une date au format dd/MM/yy (ou dd/MM/yy HH:mm) et un bool [includeHours].
/// Retourne La date actuelle si [dateToFormat] est null
DateTime frDateToDateTime(
  String? dateToFormat, {
  bool includeHours = false,
}) {
  if (dateToFormat == null || dateToFormat.isEmpty) {
    return DateTime.now();
  }
  DateTime dateResult;
  if (!includeHours) {
    dateResult = DateFormat('dd/MM/yy').parse(dateToFormat);
  } else {
    dateResult = DateFormat('dd/MM/yy HH:mm').parse(dateToFormat);
  }
  return dateResult;
}

///
/// Retourne une date fromaté au format yyyy-MM-dd.
///
/// Prend une date au format jj/MM/yy et un bool [includeHours].
String helperFormatDateToEn(String? dateToFormat, {bool includeHours = false}) {
  if (dateToFormat == null || dateToFormat.isEmpty || dateToFormat == '-') {
    return '';
  }
  var tempDate = '';
  if (!includeHours) {
    var tempDateTime = DateFormat('dd/MM/yy').parse(dateToFormat).toLocal();
    tempDate = DateFormat('yyyy-MM-dd').format(tempDateTime);
  } else {
    var tempDateTime =
        DateFormat('dd/MM/yy HH:mm').parse(dateToFormat).toLocal();
    tempDate = DateFormat('yyyy-MM-ddTHH:mm').format(tempDateTime);
  }
  return tempDate;
}

/// Affiche un DatePicker customisé
Future showCustomDatePicker({
  required BuildContext context,
  required Function(DateTime newDate) onChange,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  bool showHours = false,
}) async {
  var now = DateTime.now();
  var firstDateIsInitialDate =
      firstDate != null && firstDate.compareTo(now) > 0;
  var date = await showDatePicker(
    context: context,
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    helpText: 'Date',
    initialDate: initialDate ?? (firstDateIsInitialDate ? firstDate : now),
    builder: (context, child) {
      return child!;
    },
    firstDate: firstDate ?? DateTime(1900),
    lastDate: lastDate ?? DateTime(2500),
  );
  if (date != null) {
    onChange(date);
  }
}
