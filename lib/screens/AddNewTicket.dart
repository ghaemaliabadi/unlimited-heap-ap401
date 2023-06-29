import 'dart:convert' show utf8;
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:unlimited_heap_ap401/screens/SellerPage.dart';
import '../models/company.dart';
import '../models/ticket.dart';
import '../models/userinfo.dart';

// ignore: must_be_immutable
class AddNewTicket extends StatefulWidget {
  AddNewTicket({
    Key? key,
    required this.title,
    this.ticket,
    this.user,
  }) : super(key: key);

  final String title;
  Ticket? ticket;
  User? user;

  @override
  State<AddNewTicket> createState() => _AddNewTicketState();
}

class _AddNewTicketState extends State<AddNewTicket> {
  var numberFormat = NumberFormat("###,###", "en_US");
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    widget.ticket ??= Ticket(
      ticketID: 0,
      transportBy: 'پرواز داخلی',
      from: '',
      to: '',
      outboundDate: Jalali.now(),
      inboundDate: Jalali.now(),
      company: Company(
        'آسمان',
      ),
      price: 0,
      remainingSeats: 0,
      description: '',
      tags: [],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            Future.delayed(const Duration(milliseconds: 200), () {
              Navigator.pop(context);
            });
          },
          icon: const Icon(Icons.arrow_back),
        ),
        elevation: 1.5,
        title: Text(widget.title,
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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          initialValue: widget.ticket?.ticketID.toString(),
                          style: const TextStyle(color: Colors.black54),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                int.parse(value) <= 0) {
                              return 'کد بلیط باید یک عدد باشد';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              widget.ticket?.ticketID = int.parse(value);
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'کد بلیط',
                            hintStyle: const TextStyle(color: Colors.black54),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: DropdownButtonFormField(
                          validator: (value) {
                            if ((value == null || value.isEmpty) &&
                                !widget.title.contains('ویرایش')) {
                              return 'لطفا نوع بلیط را انتخاب کنید';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: () {
                              if (widget.title.contains('ویرایش')) {
                                return widget.ticket!.transportBy;
                              } else {
                                return 'نوع بلیط';
                              }
                            }(),
                            hintStyle: const TextStyle(color: Colors.black54),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'پرواز داخلی',
                              child: Text(
                                'پرواز داخلی',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'پرواز خارجی',
                              child: Text(
                                'پرواز خارجی',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'قطار',
                              child: Text(
                                'قطار',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'اتوبوس',
                              child: Text(
                                'اتوبوس',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              widget.ticket?.transportBy = value!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          initialValue: widget.ticket?.from,
                          style: const TextStyle(color: Colors.black54),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'مبدا نمی تواند خالی باشد';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              widget.ticket?.from = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'مبدا',
                            hintStyle: const TextStyle(color: Colors.black54),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          initialValue: widget.ticket?.to,
                          style: const TextStyle(color: Colors.black54),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'مقصد نمی تواند خالی باشد';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              widget.ticket?.to = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'مقصد',
                            hintStyle: const TextStyle(color: Colors.black54),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("تاریخ و زمان حرکت به مقصد:        ",
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          GestureDetector(
                            onTap: () async {
                              var pickedDate = await showModalBottomSheet<Jalali>(
                                context: context,
                                builder: (context) {
                                  Jalali? tempPickedDate =
                                      widget.ticket?.outboundDate;
                                  return SizedBox(
                                    height: 250,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            CupertinoButton(
                                              child: const Text(
                                                'لغو',
                                                style: TextStyle(
                                                  fontFamily: 'Kalameh',
                                                  fontSize: 20,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            CupertinoButton(
                                              child: const Text(
                                                'تایید',
                                                style: TextStyle(
                                                  fontFamily: 'Kalameh',
                                                  fontSize: 20,
                                                ),
                                              ),
                                              onPressed: () {
                                                if (tempPickedDate!
                                                    .isAfter(Jalali.now())) {
                                                  Navigator.of(context).pop(
                                                      tempPickedDate ??
                                                          Jalali.now());
                                                } else {
                                                  showDialogError(context,
                                                      'تاریخ و زمان وارد شده باید بعد از تاریخ امروز باشد');
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          height: 0,
                                          thickness: 1,
                                        ),
                                        Expanded(
                                          child: CupertinoTheme(
                                            data: const CupertinoThemeData(
                                              textTheme: CupertinoTextThemeData(
                                                dateTimePickerTextStyle:
                                                    TextStyle(
                                                        fontFamily: "Kalameh"),
                                              ),
                                            ),
                                            child: PCupertinoDatePicker(
                                              mode: PCupertinoDatePickerMode
                                                  .dateAndTime,
                                              onDateTimeChanged:
                                                  (Jalali dateTime) {
                                                tempPickedDate = dateTime;
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                              if (pickedDate?.day == null) {
                                widget.ticket?.outboundDate = Jalali.now();
                              } else {
                                widget.ticket?.outboundDate = pickedDate;
                              }
                              setState(() {});
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 50,
                              padding: const EdgeInsets.only(left: 10, right: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black38,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today_outlined,
                                    color: Colors.black45,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    widget.ticket!.outboundTimeAndDateString,
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text("تاریخ و زمان رسیدن به مقصد:        ",
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          GestureDetector(
                            onTap: () async {
                              var pickedDate = await showModalBottomSheet<Jalali>(
                                context: context,
                                builder: (context) {
                                  Jalali? tempPickedDate =
                                      widget.ticket?.inboundDate;
                                  return SizedBox(
                                    height: 250,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            CupertinoButton(
                                              child: const Text(
                                                'لغو',
                                                style: TextStyle(
                                                  fontFamily: 'Kalameh',
                                                  fontSize: 20,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            CupertinoButton(
                                              child: const Text(
                                                'تایید',
                                                style: TextStyle(
                                                  fontFamily: 'Kalameh',
                                                  fontSize: 20,
                                                ),
                                              ),
                                              onPressed: () {
                                                if (tempPickedDate!.isAfter(widget
                                                    .ticket!.outboundDate!)) {
                                                  Navigator.of(context).pop(
                                                      tempPickedDate ??
                                                          Jalali.now());
                                                } else {
                                                  showDialogError(context,
                                                      'تاریخ و زمان وارد شده باید بعد از تاریخ شروع حرکت باشد');
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          height: 0,
                                          thickness: 1,
                                        ),
                                        Expanded(
                                          child: CupertinoTheme(
                                            data: const CupertinoThemeData(
                                              textTheme: CupertinoTextThemeData(
                                                dateTimePickerTextStyle:
                                                    TextStyle(
                                                        fontFamily: "Kalameh"),
                                              ),
                                            ),
                                            child: PCupertinoDatePicker(
                                              mode: PCupertinoDatePickerMode
                                                  .dateAndTime,
                                              onDateTimeChanged:
                                                  (Jalali dateTime) {
                                                tempPickedDate = dateTime;
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                              if (pickedDate?.day == null) {
                                widget.ticket?.inboundDate = Jalali.now();
                              } else {
                                widget.ticket?.inboundDate = pickedDate!;
                              }
                              setState(() {});
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 50,
                              padding: const EdgeInsets.only(left: 10, right: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black38,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today_outlined,
                                    color: Colors.black45,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    widget.ticket!.inboundTimeAndDateString,
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          initialValue: widget.ticket?.price.toString(),
                          style: const TextStyle(color: Colors.black54),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                int.tryParse(value) == null ||
                                int.tryParse(value) == 0) {
                              return 'قیمت رو به صورت یک عدد صحیح به تومان وارد کنید';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              widget.ticket?.price = int.parse(value);
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'قیمت',
                            hintStyle: const TextStyle(color: Colors.black54),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextFormField(
                          initialValue: widget.ticket?.remainingSeats.toString(),
                          style: const TextStyle(color: Colors.black54),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                int.tryParse(value) == null ||
                                int.tryParse(value) == 0) {
                              return 'ظرفیت باید به صورت یک عدد صحیح باشد';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              widget.ticket?.remainingSeats = int.parse(value);
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'ظرفیت',
                            hintStyle: const TextStyle(color: Colors.black54),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.93,
                        child: TextFormField(
                          initialValue: widget.ticket?.description,
                          style: const TextStyle(color: Colors.black54),
                          validator: (value) {
                            if (value!.length > 40) {
                              return 'توضیحات بلیط نباید بیشتر از 40 کاراکتر باشد';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              widget.ticket?.description = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'توضیحات بلیط',
                            hintStyle: const TextStyle(color: Colors.black54),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.93,
                        child: TextFormField(
                          initialValue: widget.ticket?.tags.join(', '),
                          style: const TextStyle(color: Colors.black54),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'تگ‌های بلیط را وارد کنید';
                            }
                            // count , in value
                            var cnt = 0;
                            for (int i = 0; i < value.length; i++) {
                              if (value[i] == ',') {
                                cnt++;
                              }
                            }
                            if (cnt > 3) {
                              return 'حداکثر ۴ تگ با یک کاما فاصله بین وارد کنید';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              value = value.replaceAll('،', ',');
                              value = value.replaceAll(', ', ',');
                              value = value.replaceAll(' ,', ',');
                              var splitByComma = value.split(',');
                              widget.ticket?.tags = splitByComma;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'تگ‌های بلیط',
                            hintStyle: const TextStyle(color: Colors.black54),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.93,
                  height: 54.0,
                  child: TextButton(
                    onPressed: () async {
                      // run validators
                      if (_formKey.currentState!.validate()) {
                        var isEdit = false;
                        if (widget.title.contains('ویرایش')) {
                          isEdit = true;
                        }
                        String serverResponse = await _addTicket(
                          // ignore: prefer_interpolation_to_compose_strings
                            widget.ticket!.ticketID.toString() + '-' +
                                widget.ticket!.transportBy + '-' +
                                widget.ticket!.from + '-' +
                                widget.ticket!.to + '-' +
                                widget.ticket!.outboundDate!.year.toString() + '-' +
                                widget.ticket!.outboundDate!.month.toString() + '-' +
                                widget.ticket!.outboundDate!.day.toString() + '-' +
                                widget.ticket!.outboundDate!.hour.toString() + '-' +
                                widget.ticket!.outboundDate!.minute.toString() + '-' +
                                widget.ticket!.inboundDate!.year.toString() + '-' +
                                widget.ticket!.inboundDate!.month.toString() + '-' +
                                widget.ticket!.inboundDate!.day.toString() + '-' +
                                widget.ticket!.inboundDate!.hour.toString() + '-' +
                                widget.ticket!.inboundDate!.minute.toString() + '-' +
                                widget.user!.firstName! + '-' +
                                widget.ticket!.price.toString() + '-' +
                                widget.ticket!.remainingSeats.toString() + '-' +
                                widget.ticket!.description +
                                widget.ticket!.tagsString,
                            isEdit
                        );
                        if (serverResponse == "true") {
                          // Navigator.of(context).pop();
                          // ignore: use_build_context_synchronously
                          FocusScope.of(context).unfocus();
                          Future.delayed(const Duration(milliseconds: 200), () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (context, animation1, animation2) =>
                                      SellerPage(
                                        user: widget.user,
                                      )),
                            );
                          });
                          print('validate success');
                        } else {
                          if (serverResponse == "code is not unique") {
                            // ignore: use_build_context_synchronously
                            showDialogError(context, "کد بلیط تکراری است");
                          } else {
                            // ignore: use_build_context_synchronously
                            showDialogError(context, serverResponse);
                          }
                        }
                      } else {
                        print('validate failed');
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.primary,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    child: Text(
                      () {
                        if (widget.title.contains('ویرایش')) {
                          return 'ویرایش بلیط';
                        } else {
                          return 'افزودن بلیط';
                        }
                      }(),
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
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

Future<dynamic> showDialogError(BuildContext context, String errorText) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: const Text('خطا'),
        content: Text(errorText, style: Theme.of(context).textTheme.bodyLarge),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('تایید'),
          ),
        ],
      );
    },
  );
}

Future<String> _addTicket(str, isEdit) async {
  String response = "false";
  await Socket.connect(SellerPage.ip, SellerPage.port).then((serverSocket) {
    print("Connected!");
    if (isEdit) {
    serverSocket.write("editTicket-$str*");
    } else {
    serverSocket.write("addTicket-$str*");
    }
    serverSocket.flush();
    print("Sent data!");
    serverSocket.listen((socket) {
      response = utf8.decode(socket);
    });
  });
  return Future.delayed(const Duration(milliseconds: 1000), () => response);
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