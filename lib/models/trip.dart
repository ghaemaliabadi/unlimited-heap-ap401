import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class Trip {
  Trip({
    required this.type,
    required this.from,
    required this.to,
    required this.date,
    required this.dateRange,
    required this.passengers,
  });

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
}
