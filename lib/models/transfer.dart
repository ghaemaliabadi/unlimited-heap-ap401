import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../screens/PassengersDataPage.dart';

class Transfer{
  Transfer({
    required this.date,
    required this.amount,
    required this.id
  });

  Jalali date;
  String amount;
  String id;

  String getDate() {
    return convertEnToFa("${date.year}/${date.month}/${date.day}");
  }

  String getAmount() {
    return convertEnToFa(
        numberFormat.format(int.parse(amount))
    );
  }

  String getID() {
    return convertEnToFa(
        "${(id)} "
    );
  }

}