import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class TakenTrip {
  TakenTrip({
    required this.id,
    required this.transportType,
    required this.date,
    required this.price,
    required this.status,
  });

  String id;
  String transportType;
  Jalali date;
  String price;
  Status status;
}

enum Status {
  done,
  canceled,
  ongoing,
}