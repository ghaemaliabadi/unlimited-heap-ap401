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