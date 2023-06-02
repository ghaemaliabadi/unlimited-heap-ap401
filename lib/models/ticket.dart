import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class Trip {
  Trip({
    required this.transportBy,
    required this.from,
    required this.to,
    required this.outboundDate,
    required this.inboundDate,
    required this.company,
    required this.price,
    required this.remainingSeats,
    required this.description,
    required this.tags,
  });

  String transportBy;
  String from;
  String to;
  Jalali? outboundDate;
  Jalali? inboundDate;
  String company;
  int price;
  int remainingSeats;
  String description;
  Map<String, bool> tags;
}
