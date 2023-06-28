import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'company.dart';

class Ticket {
  Ticket({
    required this.ticketID,
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

  int ticketID;
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

  String get outboundTimeString => convertEnToFa("${outboundDate?.hour}:${outboundDate?.minute}");

  String get inboundTimeString => convertEnToFa("${inboundDate?.hour}:${inboundDate?.minute}");
  var numberFormat = NumberFormat("###,###", "en_US");
  String get priceString => convertEnToFa(numberFormat.format(price));
  String get dateString {
    return convertEnToFa(
          "${outboundDate?.formatter.wN} ${outboundDate?.formatter.dd} ${outboundDate?.formatter.mN}");
  }
}

convertEnToFa(String txt) {
  return txt
      .replaceAll('0', '۰')
      .replaceAll('1', '۱')
      .replaceAll('2', '۲')
      .replaceAll('3', '۳')
      .replaceAll('4', '۴')
      .replaceAll('5', '۵')
      .replaceAll('6', '۶')
      .replaceAll('7', '۷')
      .replaceAll('8', '۸')
      .replaceAll('9', '۹');
}