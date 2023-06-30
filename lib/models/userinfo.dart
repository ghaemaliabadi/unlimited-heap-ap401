import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'tripsTaken.dart';

class User {
  User({
    required this.username,
    required this.password,
    required this.email,
    this.balance,
    this.phoneNumber,
    this.birthDate,
    this.firstName,
    this.lastName,
    this.nationalID,
  });

  String username;
  String password;
  String email;
  String? balance;
  String? phoneNumber;
  Jalali? birthDate;
  String? firstName;
  String? lastName;
  String? nationalID;

  String getFullName() {
    return '${firstName ?? '-'} ${lastName ?? ''}';
  }

  String getBirthDateString() {
    return convertEnToFa(
        "${(birthDate != null ? birthDate?.formatter.dd : '-')} "
            "${(birthDate != null ? birthDate?.formatter.mN : '')} "
            "${(birthDate != null ? birthDate?.formatter.yyyy : '')} "
    );
  }

  String getBalance() {
    return convertEnToFa(
        "${(balance ?? '۰')} "
    );
  }

  String getPhoneNumber() {
    return convertEnToFa(
        "${(phoneNumber ?? '-')} "
    );
  }

  String getNationalID() {
    return convertEnToFa(
        "${(nationalID ?? '-')} "
    );
  }

  void setEmail(String text) {
    email = text;
  }

  void setBirthDate(int year, String month, int day) {
    birthDate = Jalali(year, convertMonthToNum(month), day);
  }

  void addBalance(String amount) {
    balance = convertFaToEn(balance ?? '0');
    balance = (int.parse(balance ?? '0') + int.parse(amount)).toString();
  }

  void withdrawBalance(String amount) {
    balance = convertFaToEn(balance ?? '0');
    balance = (int.parse(balance ?? '0') - int.parse(amount)).toString();
  }

  bool checkEnoughBalance(String amount) {
    balance = convertFaToEn(balance ?? '0');
    return int.parse(balance ?? '0') >= int.parse(amount);
  }
}

convertFaToEn(String text) {
  return text
      .replaceAll('۰', '0')
      .replaceAll('۱', '1')
      .replaceAll('۲', '2')
      .replaceAll('۳', '3')
      .replaceAll('۴', '4')
      .replaceAll('۵', '5')
      .replaceAll('۶', '6')
      .replaceAll('۷', '7')
      .replaceAll('۸', '8')
      .replaceAll('۹', '9');
}

int convertMonthToNum(String month) {
  switch (month) {
    case 'فروردین':
      return 1;
    case 'اردیبهشت':
      return 2;
    case 'خرداد':
      return 3;
    case 'تیر':
      return 4;
    case 'مرداد':
      return 5;
    case 'شهریور':
      return 6;
    case 'مهر':
      return 7;
    case 'آبان':
      return 8;
    case 'آذر':
      return 9;
    case 'دی':
      return 10;
    case 'بهمن':
      return 11;
    case 'اسفند':
      return 12;
    default:
      return 1;
  }
}

String convertNumToMonth(int month) {
  switch (month) {
    case 1:
      return 'فروردین';
    case 2:
      return 'اردیبهشت';
    case 3:
      return 'خرداد';
    case 4:
      return 'تیر';
    case 5:
      return 'مرداد';
    case 6:
      return 'شهریور';
    case 7:
      return 'مهر';
    case 8:
      return 'آبان';
    case 9:
      return 'آذر';
    case 10:
      return 'دی';
    case 11:
      return 'بهمن';
    case 12:
      return 'اسفند';
    default:
      return 'فروردین';
  }
}