import 'dart:convert' show utf8;
import 'dart:io';

import 'package:flutter/material.dart';

import '../models/userinfo.dart';

// ignore: must_be_immutable
class EditUserInfoPage extends StatefulWidget {
  User? user;

  EditUserInfoPage({Key? key,
    this.user,
  })
      : super(key: key);

  static const String ip = "10.0.2.2";
  static const int port = 1234;

  @override
  State<EditUserInfoPage> createState() => _EditUserInfoPageState();
}

class _EditUserInfoPageState extends State<EditUserInfoPage> {
  // final _formKey = GlobalKey<FormState>();
  int? selectedDay;
  String? selectedMonth;
  int? selectedYear;

  @override
  Widget build(BuildContext context) {
    var pageHeight = MediaQuery.of(context).size.height;
    var pageWidth = MediaQuery.of(context).size.width;

    // TODO: change initial value to hint text
    final firstNameController = TextEditingController(text: widget.user!.firstName);
    final lastNameController = TextEditingController(text: widget.user!.lastName);
    final nationalIdController = TextEditingController(text: widget.user!.nationalID);
    final phoneNumberController = TextEditingController(text: widget.user!.phoneNumber);

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('ویرایش اطلاعات کاربری'),
      ),
      body: InkWell(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Form(
          // key: _formKey,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 35.0),
            child: Column(
              children: [
                SizedBox(
                  width: pageWidth * 0.85,
                  child: TextFormField(
                    controller: firstNameController,
                    style: Theme.of(context).textTheme.displaySmall,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        labelText: 'نام',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                  ),
                ),
                SizedBox(height: pageHeight * 0.03,),
                SizedBox(
                  width: pageWidth * 0.85,
                  child: TextFormField(
                    controller: lastNameController,
                    style: Theme.of(context).textTheme.displaySmall,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'نام خانوادگی',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: pageHeight * 0.03,),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: pageWidth * 0.4,
                      child: TextFormField(
                        controller: nationalIdController,
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.displaySmall,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          labelText: 'کد ملی',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: pageWidth * 0.05,),
                    SizedBox(
                      width: pageWidth * 0.4,
                      child: TextFormField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.displaySmall,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          labelText: 'شماره تماس',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // TODO: add birthdate to db
                SizedBox(height: pageHeight * 0.03,),
                SizedBox(
                  width: pageWidth * 0.85,
                  height: pageHeight * 0.03,
                  child: Text(
                    'تاریخ تولد',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                SizedBox(height: pageHeight * 0.01,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: (pageWidth * 0.85) / 3,
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          labelText: 'روز',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            )
                          ),
                        ),
                      value: selectedDay,
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedDay = newValue!;
                        });
                      },
                      items: <int>[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,
                        16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,
                        31].map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString(),
                            style: Theme.of(context).textTheme.displaySmall,),
                        );
                      }).toList(),
                      ),
                    ),
                    // SizedBox(width: pageWidth * 0.05,),
                    SizedBox(
                      width: (pageWidth * 0.85) / 3,
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          labelText: 'ماه',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                        ),
                        value: selectedMonth,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedMonth = newValue!;
                          });
                        },
                        items: <String>['فروردین', 'اردیبهشت', 'خرداد', 'تیر',
                          'مرداد', 'شهریور', 'مهر', 'آبان', 'آذر',
                          'دی', 'بهمن', 'اسفند'].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                              style: Theme.of(context).textTheme.displaySmall,),
                          );
                        }).toList(),
                      ),
                    ),
                    // SizedBox(width: pageWidth * 0.05,),
                    SizedBox(
                      width: (pageWidth * 0.85) / 3,
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          alignLabelWithHint: true,
                          labelText: 'سال',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                        ),
                        value: selectedYear,
                        onChanged: (int? newValue) {
                          setState(() {
                            selectedYear = newValue!;
                          });
                        },
                        items: <int>[1400,1399,1398,1397,1396,1395,1394,1393,1392,1391,1390,
                          1389,1388,1387,1386,1385,1384,1383,1382,1381,1380,1379,1378,1377,
                          1376,1375,1374,1373,1372,1371,1370,1369,1368,1367,1366,1365,1364,
                          1363,1362,1361,1360,1359,1358,1357,1356,1355,1354,1353,1352,1351,
                          1350,1349,1348,1347,1346,1345,1344,1343,1342,1341,1340,1339,1338,
                          1337,1336,1335,1334,1333,1332,1331,1330,1329,1328,1327,1326,1325,
                          1324,1323,1322,1321,1320,1319,1318,1317,1316,1315,1314,1313,1312]
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString(),
                              style: Theme.of(context).textTheme.displaySmall,),
                          );
                        }
                        ).toList(),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () async {
                        String serverResponse = await _updateUserInfo(
                          widget.user!.username,
                          '${firstNameController.text == '' ? 'null' : firstNameController.text}-'
                              '${lastNameController.text == '' ? 'null' : lastNameController.text}-'
                              '${nationalIdController.text == '' ? 'null' : nationalIdController.text}-'
                              '${phoneNumberController.text == '' ? 'null' : phoneNumberController.text}',
                        );
                        print(serverResponse);
                        if (context.mounted) {
                          if (serverResponse == 'true') {
                            setState(() {
                              widget.user!.firstName = firstNameController.text;
                              widget.user!.lastName = lastNameController.text;
                              widget.user!.nationalID = nationalIdController.text;
                              widget.user!.phoneNumber = phoneNumberController.text;
                            });
                            _showSnackBar(context, 'اطلاعات با موفقیت ثبت شد.', false);
                            Navigator.of(context).pop();
                            // if (_formKey.currentState!.validate()) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(content: Text('در حال ارسال اطلاعات...')),
                            //   );
                            // }
                          } else {
                            _showSnackBar(context, 'خطا در ثبت اطلاعات.', true);
                          }
                        }
                      },
                      style: ButtonStyle(
                        minimumSize:
                        MaterialStateProperty.all(const Size(170.0, 50.0)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1000.0),
                          ),
                        ),
                      ),
                      child: Text('تایید اطلاعات',
                          style: Theme.of(context).textTheme.displayMedium),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ]
            ),
          ),
        ),
      )
    );
  }
}

Future<String> _updateUserInfo(String username, String info) async {
  String response = "false";
  await Socket.connect(EditUserInfoPage.ip, EditUserInfoPage.port).then((serverSocket) {
    print("Connected!");
    serverSocket.write("edit-all-$username-$info*");
    serverSocket.flush();
    print("Sent data!");
    serverSocket.listen((socket) {
      response = utf8.decode(socket);
      print(response);
    });
  }
  );
  return Future.delayed(const Duration(milliseconds: 100), () => response);
}

void _showSnackBar(BuildContext context, String message, bool isError) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: (isError
            ? Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.red)
            : Theme.of(context).textTheme.displaySmall
        ),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ),
  );
}