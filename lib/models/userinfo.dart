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
}