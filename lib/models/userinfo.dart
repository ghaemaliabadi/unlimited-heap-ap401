import 'package:persian_datetime_picker/persian_datetime_picker.dart';

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
  JalaliDate? birthDate;
  String? firstName;
  String? lastName;
  String? nationalID;

  String getFullName() {
    return '${firstName ?? '-'} ${lastName ?? ''}';
  }
}
