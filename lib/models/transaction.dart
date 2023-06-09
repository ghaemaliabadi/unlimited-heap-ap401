import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../screens/PassengersDataPage.dart';

class Transaction {
  Transaction({
    required this.date,
    required this.amount,
    required this.type,
    required this.description,
  });

  Jalali date;
  String amount;
  TransactionType type;
  String description;

  String getDate() {
    return convertEnToFa("${date.year}/${date.month}/${date.day}");
  }

  String getAmount() {
    return convertEnToFa(
        numberFormat.format(int.parse(amount))
    );
  }

  String getType() {
    switch (type) {
      case TransactionType.increase:
        return 'افزایش شارژ';
      case TransactionType.decrease:
        return 'کاهش شارژ';
    }
  }

  String getDescription() {
    return description;
  }
}

enum TransactionType {
  increase,
  decrease,
}