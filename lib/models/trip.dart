import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:unlimited_heap_ap401/models/ticket.dart';

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
  Ticket? departTicket;
  Ticket? returnTicket;
  Map<String, int> passengers = {
    'adult': 0,
    'child': 0,
    'infant': 0,
  };

  int get sumPassengers {
    return passengers['adult']! + passengers['child']! + passengers['infant']!;
  }

  String get title => '$from به $to';

  String get goDate {
    return convertEnToFa(
        "${dateRange?.start.formatter.wN} ${dateRange?.start.formatter.dd} ${dateRange?.start.formatter.mN}");
  }

  String get backDate {
    return convertEnToFa(
        "${dateRange?.end.formatter.wN} ${dateRange?.end.formatter.dd} ${dateRange?.end.formatter.mN}");
  }

  String get dateString {
    if (type == 'رفت و برگشت') {
      return '$goDate » $backDate';
    } else {
      return convertEnToFa(
          "${date?.formatter.wN} ${date?.formatter.dd} ${date?.formatter.mN}");
    }
  }
  // convert dateString getter to method with a parameter
  String dateStringWithParam(String selectTicketFor) {
    if (type == 'رفت و برگشت') {
      if (selectTicketFor == 'depart') {
        return 'رفت » $goDate';
      } else {
        return 'برگشت » $backDate';
      }
    } else {
      return convertEnToFa(
          "${date?.formatter.wN} ${date?.formatter.dd} ${date?.formatter.mN}");
    }
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
