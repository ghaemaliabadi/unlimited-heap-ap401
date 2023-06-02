import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'company.dart';

class Ticket {
  Ticket({
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
  Company company;
  int price;
  int remainingSeats;
  String description;
  List<String> tags;
}
