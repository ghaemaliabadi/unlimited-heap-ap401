import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:unlimited_heap_ap401/screens/PassengersDataPage.dart';

import 'company.dart';

class TakenTrip {
  TakenTrip({
    required this.id,
    required this.transportType,
    required this.date,
    required this.price,
    required this.status,
    required this.company,
    required this.reservationNumber,
    required this.from,
    required this.to,
  });

  String id;
  String transportType;
  Jalali date;
  String price;
  Status status;
  Company company;
  String reservationNumber;
  String from;
  String to;

  String getDate() {
    return convertEnToFa("${date.year}/${date.month}/${date.day}");
  }

  String getID() {
    return convertEnToFa(
        "${(id)} "
    );
  }

  String getPrice() {
    return convertEnToFa(
        numberFormat.format(int.parse(price))
    );
  }

  String getStatus() {
    switch (status) {
      case Status.done:
        return 'نهایی شده';
      case Status.canceled:
        return 'لغو شده';
      case Status.ongoing:
        return 'در حال انجام';
    }
  }

  String getReservationNumber() {
    return convertEnToFa(
        reservationNumber
    );
  }

  Company getCompany() {
    return company;
  }

  String getRoute() {
    return "$from - $to";
  }

  String getHour() {
    return convertEnToFa(
        "${date.hour}:${date.minute}"
    );
  }
}

enum Status {
  done,
  canceled,
  ongoing,
}