import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../models/company.dart';
import '../models/ticket.dart';

// ignore: must_be_immutable
class AddNewTicket extends StatefulWidget {
  AddNewTicket({
    Key? key,
    required this.title,
    this.ticket,
  }) : super(key: key);

  final String title;
  Ticket? ticket;

  @override
  State<AddNewTicket> createState() => _AddNewTicketState();
}

class _AddNewTicketState extends State<AddNewTicket> {
  var numberFormat = NumberFormat("###,###", "en_US");

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
        elevation: 1.5,
        title: Text(widget.title,
            style: Theme.of(context).textTheme.displayMedium),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black54),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          int.parse(value) < 0) {
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
                      if (value == null || value.isEmpty) {
                        return 'لطفا جنسیت مسافر را انتخاب کنید';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'نوع بلیط',
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
                    style: const TextStyle(color: Colors.black54),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'مقصد نمی تواند خالی باشد';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        widget.ticket?.from = value;
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
                GestureDetector(
                  onTap: () async {
                    // رفت
                    var pickedDate = await showModalBottomSheet<Jalali>(
                      context: context,
                      builder: (context) {
                        Jalali? tempPickedDate = widget.ticket?.outboundDate;
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
                                            tempPickedDate ?? Jalali.now());
                                      } else {
                                        showDialogError(context,
                                            'تاریخ وارد شده باید بعد از تاریخ امروز باشد');
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
                                          TextStyle(fontFamily: "Kalameh"),
                                    ),
                                  ),
                                  child: PCupertinoDatePicker(
                                    mode: PCupertinoDatePickerMode.dateAndTime,
                                    onDateTimeChanged: (Jalali dateTime) {
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
                GestureDetector(
                  onTap: () async {
                    // رفت
                    var pickedDate = await showModalBottomSheet<Jalali>(
                      context: context,
                      builder: (context) {
                        Jalali? tempPickedDate = widget.ticket?.inboundDate;
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
                                            tempPickedDate ?? Jalali.now());
                                      } else {
                                        showDialogError(context,
                                            'تاریخ وارد شده باید بعد از تاریخ امروز باشد');
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
                                          TextStyle(fontFamily: "Kalameh"),
                                    ),
                                  ),
                                  child: PCupertinoDatePicker(
                                    mode: PCupertinoDatePickerMode.dateAndTime,
                                    onDateTimeChanged: (Jalali dateTime) {
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
            ),
          ),
        ],
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