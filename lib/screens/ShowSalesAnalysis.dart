import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../models/userinfo.dart';
import 'SellerPage.dart';
import 'dart:convert' show utf8;

// ignore: must_be_immutable
class ShowSalesAnalysis extends StatefulWidget {
  User user;
  bool? lastMonth;
  bool? last3Month;
  bool? last6Month;
  bool? lastYear;

  ShowSalesAnalysis({
    Key? key,
    required this.user,
    this.lastMonth,
    this.last3Month,
    this.last6Month,
    this.lastYear,
  }) : super(key: key);
  final String title = 'آنالیز فروش';
  static const String ip = "127.0.0.1";
  static const int port = 1234;

  @override
  State<ShowSalesAnalysis> createState() => _ShowSalesAnalysisState();
}

var numberFormat = NumberFormat("###,###", "en_US");

class _ShowSalesAnalysisState extends State<ShowSalesAnalysis> {
  int countAll = 0;
  int totalIncome = 0;
  int averageIncome = 0;
  String mostRepeatedDestination = "";
  String mostRepeatedOrigin = "";

  @override
  void initState() {
    widget.lastMonth ??= true;
    widget.last3Month ??= false;
    widget.last6Month ??= false;
    widget.lastYear ??= false;
    _getTakenTripsForCompany(
        context, widget.user.firstName).then((value) => updateAnalysisByStats(value));
    super.initState();
  }

  updateAnalysisByStats(String response) {
    countAll = 0;
    totalIncome = 0;
    averageIncome = 0;
    mostRepeatedDestination = "";
    mostRepeatedOrigin = "";
    //String username, String id, String transportType, String Year, String Month, String Day, String Hour, String Minute, String price, String status, String company, String reservationNumber, String from, String to
    HashMap<String, int> mostRepeatedDestinationMap = HashMap();
    HashMap<String, int> mostRepeatedOriginMap = HashMap();
    for (String element in response.split('*')) {
      Jalali tempDate = Jalali(int.parse(element.split('-')[3]),
          int.parse(element.split('-')[4]), int.parse(element.split('-')[5]));
      if (widget.lastMonth ?? true) {
        if (tempDate.addMonths(1).isAfter(Jalali.now())) {
          countAll++;
          totalIncome += int.parse(element.split('-')[8]);
          if (mostRepeatedDestinationMap.containsKey(element.split('-')[13])) {
            mostRepeatedDestinationMap[element.split('-')[13]] =
                mostRepeatedDestinationMap[element.split('-')[13]]! + 1;
          } else {
            mostRepeatedDestinationMap[element.split('-')[13]] = 1;
          }
          if (mostRepeatedOriginMap.containsKey(element.split('-')[12])) {
            mostRepeatedOriginMap[element.split('-')[12]] =
                mostRepeatedOriginMap[element.split('-')[12]]! + 1;
          } else {
            mostRepeatedOriginMap[element.split('-')[12]] = 1;
          }
        }
      } else if (widget.last3Month ?? true) {
        if (tempDate.addMonths(3).isAfter(Jalali.now())) {
          countAll++;
          totalIncome += int.parse(element.split('-')[8]);
          if (mostRepeatedDestinationMap.containsKey(element.split('-')[13])) {
            mostRepeatedDestinationMap[element.split('-')[13]] =
                mostRepeatedDestinationMap[element.split('-')[13]]! + 1;
          } else {
            mostRepeatedDestinationMap[element.split('-')[13]] = 1;
          }
          if (mostRepeatedOriginMap.containsKey(element.split('-')[12])) {
            mostRepeatedOriginMap[element.split('-')[12]] =
                mostRepeatedOriginMap[element.split('-')[12]]! + 1;
          } else {
            mostRepeatedOriginMap[element.split('-')[12]] = 1;
          }
        }
      } else if (widget.last6Month ?? true) {
        if (tempDate.addMonths(6).isAfter(Jalali.now())) {
          countAll++;
          totalIncome += int.parse(element.split('-')[8]);
          if (mostRepeatedDestinationMap.containsKey(element.split('-')[13])) {
            mostRepeatedDestinationMap[element.split('-')[13]] =
                mostRepeatedDestinationMap[element.split('-')[13]]! + 1;
          } else {
            mostRepeatedDestinationMap[element.split('-')[13]] = 1;
          }
          if (mostRepeatedOriginMap.containsKey(element.split('-')[12])) {
            mostRepeatedOriginMap[element.split('-')[12]] =
                mostRepeatedOriginMap[element.split('-')[12]]! + 1;
          } else {
            mostRepeatedOriginMap[element.split('-')[12]] = 1;
          }
        }
      } else if (widget.lastYear ?? true) {
        if (tempDate.addMonths(12).isAfter(Jalali.now())) {
          countAll++;
          totalIncome += int.parse(element.split('-')[8]);
          if (mostRepeatedDestinationMap.containsKey(element.split('-')[13])) {
            mostRepeatedDestinationMap[element.split('-')[13]] =
                mostRepeatedDestinationMap[element.split('-')[13]]! + 1;
          } else {
            mostRepeatedDestinationMap[element.split('-')[13]] = 1;
          }
          if (mostRepeatedOriginMap.containsKey(element.split('-')[12])) {
            mostRepeatedOriginMap[element.split('-')[12]] =
                mostRepeatedOriginMap[element.split('-')[12]]! + 1;
          } else {
            mostRepeatedOriginMap[element.split('-')[12]] = 1;
          }
        }
      }
    }
    averageIncome = totalIncome ~/ (widget.lastMonth ?? true
        ? 1
        : widget.last3Month ?? true
            ? 3
            : widget.last6Month ?? true
                ? 6
                : 12);
    int max = 0;
    for (String key in mostRepeatedDestinationMap.keys) {
      if (mostRepeatedDestinationMap[key]! > max) {
        max = mostRepeatedDestinationMap[key]!;
        mostRepeatedDestination = key;
      }
    }
    max = 0;
    for (String key in mostRepeatedOriginMap.keys) {
      if (mostRepeatedOriginMap[key]! > max) {
        max = mostRepeatedOriginMap[key]!;
        mostRepeatedOrigin = key;
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.5,
        title: Text(widget.title + ' - ' + widget.user.firstName!,
            style: Theme.of(context).textTheme.displayMedium),
      ),
      body: InkWell(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 16.0, top: 16.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'تعداد کل تراکنش: ',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Text(
                            convertEnToFa(countAll),
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Text(
                            'میانگین درآمد در هر تراکنش: ',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Text(
                            convertEnToFa(numberFormat.format(averageIncome)) + ' تومان',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Text(
                            'مجموع درآمد: ',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Text(
                            convertEnToFa(numberFormat.format(totalIncome)) + ' تومان',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Text(
                            'مقصد پرتکرار: ',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Text(
                            mostRepeatedDestination,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Text(
                            'مبدا پرتکرار: ',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Text(
                            mostRepeatedOrigin,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          setState(() {
                            widget.lastMonth = true;
                            widget.last3Month = false;
                            widget.last6Month = false;
                            widget.lastYear = false;
                            _getTakenTripsForCompany(
                                context, widget.user.firstName).then((value) => updateAnalysisByStats(value));
                          });
                        },
                        child: buildButton('ماه گذشته', widget.lastMonth)),
                    GestureDetector(
                        onTap: () async {
                          setState(() {
                            widget.lastMonth = false;
                            widget.last3Month = true;
                            widget.last6Month = false;
                            widget.lastYear = false;
                            _getTakenTripsForCompany(
                                context, widget.user.firstName).then((value) => updateAnalysisByStats(value));
                          });
                        },
                        child: buildButton('3 ماه گذشته', widget.last3Month)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          setState(() {
                            widget.lastMonth = false;
                            widget.last3Month = false;
                            widget.last6Month = true;
                            widget.lastYear = false;
                            _getTakenTripsForCompany(
                                context, widget.user.firstName).then((value) => updateAnalysisByStats(value));
                          });
                        },
                        child: buildButton('6 ماه گذشته', widget.last6Month)),
                    GestureDetector(
                        onTap: () async {
                          setState(() {
                            widget.lastMonth = false;
                            widget.last3Month = false;
                            widget.last6Month = false;
                            widget.lastYear = true;
                            _getTakenTripsForCompany(
                                context, widget.user.firstName).then((value) => updateAnalysisByStats(value));
                          });
                        },
                        child: buildButton('سال گذشته', widget.lastYear)),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Container buildButton(input, isActive) {
    return Container(
      height: 50,
      width: 180,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        color: () {
          if (isActive) {
            return Theme.of(context).colorScheme.primary;
          } else {
            return Theme.of(context).colorScheme.secondary;
          }
        }(),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(0, 1),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            input,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 22,
                  color: () {
                    return (!isActive) ? Colors.black : Colors.white;
                  }(),
                ),
          ),
        ],
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String message, bool isError) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: (isError
            ? Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(color: Colors.red)
            : Theme.of(context).textTheme.displaySmall),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ),
  );
}

Future<String> _getTakenTripsForCompany(context, company) async {
  String response = "false";
  await Socket.connect(SellerPage.ip, SellerPage.port).then((serverSocket) {
    print("Connected!");
    serverSocket.write("getTakenTripsForCompany-$company*");
    serverSocket.flush();
    print("Sent data!");
    serverSocket.listen((socket) {
      response = utf8.decode(socket);
    });
  });
  return Future.delayed(const Duration(milliseconds: 1000), () {
    return response;
  });
}

showDialogLoading(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return const AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 10),
            Text('لطفا صبر کنید'),
          ],
        ),
      );
    },
  );
}


convertEnToFa(txt) {
  txt = txt.toString();
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