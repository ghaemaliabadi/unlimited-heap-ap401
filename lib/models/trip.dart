import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class Trip {
  Trip({
    required this.transportBy,
    required this.type,
    required this.from,
    required this.to,
    required this.date,
    required this.dateRange,
    required this.passengers,
  });

  String transportBy;
  String type;
  String from;
  String to;
  Jalali? date;
  JalaliRange? dateRange;
  Map<String, int> passengers = {
    'adult': 0,
    'child': 0,
    'infant': 0,
  };

  String get title => '$from به $to';
  String get dateString {
    if (type == 'رفت و برگشت') {
      var start = dateRange?.start;
      var end = dateRange?.end;
      var departureTypeLabel =
      "${start?.formatter.wN} ${start?.formatter.dd} ${start?.formatter.mN}";
      var returnTypeLabel =
      "${end?.formatter.wN} ${end?.formatter.dd} ${end?.formatter.mN}";
      return '$departureTypeLabel -> $returnTypeLabel';
    } else {
      return "${date?.formatter.wN} ${date?.formatter.dd} ${date?.formatter.mN}";
    }
  }
}
