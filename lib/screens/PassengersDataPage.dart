import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unlimited_heap_ap401/models/userinfo.dart';
import '../models/passenger.dart';
import '../models/ticket.dart';
import '../models/trip.dart';
import 'submitDetailsPage.dart';

// ignore: must_be_immutable
class PassengersDataPage extends StatefulWidget {
  Trip tripData;

  PassengersDataPage({super.key, required this.tripData});

  @override
  State<PassengersDataPage> createState() => _PassengersDataPageState();
}

var numberFormat = NumberFormat("###,###", "en_US");

class _PassengersDataPageState extends State<PassengersDataPage> {
  // init
  @override
  void initState() {
    widget.tripData.passengerList = [];
    for (var i = 0; i < widget.tripData.sumPassengers; i++) {
      widget.tripData.passengerList.add(Passenger());
    }
    widget.tripData.passengerList[0].firstName = 'محمد';
    widget.tripData.passengerList[0].lastName = 'محمدی';
    widget.tripData.passengerList[0].gender = 'مرد';
    widget.tripData.passengerList[0].id = '1234567890';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('تکمیل خرید',
            style: Theme.of(context).textTheme.displayMedium),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 86.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              () {
                                if (widget.tripData.transportBy.contains('پرواز')) {
                                  return Icons.airplanemode_active_rounded;
                                } else if (widget.tripData.transportBy == 'اتوبوس') {
                                  return Icons.directions_bus_rounded;
                                } else if (widget.tripData.transportBy == 'قطار') {
                                  return Icons.train_rounded;
                                } else {
                                  return Icons.more_horiz_rounded;
                                }
                              }(),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 4),
                            // arrow icon
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.account_box_sharp,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'مشخصات مسافران',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            const SizedBox(width: 4),
                            // arrow icon
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.newspaper_sharp,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 4),
                            const Text('تایید اطلاعات',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.grey)),
                            const SizedBox(width: 4),
                            // arrow icon
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.payment_rounded,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            const SizedBox(width: 4),
                            const Text('پرداخت',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        SizedBox(
                          height: 1.0,
                          child: Container(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        buildTicket(widget.tripData.departTicket!, 'بلیط رفت'),
                        () {
                          if (widget.tripData.returnTicket != null) {
                            return buildTicket(
                                widget.tripData.returnTicket!, 'بلیط برگشت');
                          } else {
                            return const SizedBox(height: 0);
                          }
                        }(),
                        // fields for passengers data
                        const SizedBox(height: 8.0),
                        // const Text(
                        //   'مشخصات مسافران',
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold, color: Colors.black54),
                        // ),
                        // const SizedBox(height: 8.0),
                        // create text form fields for passengers data
                        for (int i = 0; i < widget.tripData.passengers['adult']!; i++)
                          () {
                            return buildExpansionFor('اطلاعات مسافر', 'بزرگسال', i);
                          }(),
                        for (int i = widget.tripData.passengers['adult']!;
                            i <
                                widget.tripData.passengers['adult']! +
                                    widget.tripData.passengers['child']!;
                            i++)
                          () {
                            return buildExpansionFor('اطلاعات مسافر', 'کودک', i);
                          }(),
                        for (int i = widget.tripData.passengers['adult']! +
                                widget.tripData.passengers['child']!;
                            i <
                                widget.tripData.passengers['adult']! +
                                    widget.tripData.passengers['child']! +
                                    widget.tripData.passengers['infant']!;
                            i++)
                          () {
                            return buildExpansionFor('اطلاعات مسافر', 'نوزاد', i);
                          }(),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).size.height * 0.79, 16, 24),
            child: SizedBox(
              width: double.infinity,
              height: 54.0,
              child: TextButton(
                onPressed: () {
                  bool flag = false;
                    for (int i = 0; i < widget.tripData.passengerList.length; i++) {
                      if (widget.tripData.passengerList[i].firstName == null || widget.tripData.passengerList[i].lastName == null || widget.tripData.passengerList[i].id == null || widget.tripData.passengerList[i].gender == null) {
                        flag = true;
                      }
                    }
                    if (flag) {
                      _showSnackBar(context, 'لطفا اطلاعات مسافران را کامل کنید');
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubmitDetailsPage(tripData: widget.tripData),
                        ),
                      );
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
                  'تایید اطلاعات',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildExpansionFor(
      String passengerName, String passengerType, int saveToIndex) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ExpansionWidget(
        initiallyExpanded: false,
        titleBuilder:
            (double animationValue, _, bool isExpaned, toggleFunction) {
          return InkWell(
              onTap: () => toggleFunction(animated: true),
              child: Container(
                decoration: () {
                  if (isExpaned) {
                    return BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        left: BorderSide(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        // top border
                        top: BorderSide(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        // right border
                        right: BorderSide(
                          color: Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                    );
                  } else {
                    return BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      // border all
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.5),
                        width: 1,
                      ),
                    );
                  }
                }(),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(passengerName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Colors.black87,
                                      fontSize: 20,
                                    )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Container(
                              margin: const EdgeInsets.only(right: 4.0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(1000),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                                child: Text(passengerType,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                              ),
                            ),
                          ),
                        ],
                      )),
                      Transform.rotate(
                        angle: 3.1415 * animationValue,
                        alignment: Alignment.center,
                        child: const Icon(Icons.keyboard_arrow_up_outlined,
                            color: Colors.black54, size: 30),
                      )
                    ],
                  ),
                ),
              ));
        },
        content: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            color: Colors.white,
            // border all
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'لطفا نام مسافر را وارد کنید';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          widget.tripData.passengerList[saveToIndex].firstName =
                              value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'نام',
                        hintStyle: const TextStyle(color: Colors.black54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  // last name
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'لطفا نام خانوادگی مسافر را وارد کنید';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          widget.tripData.passengerList[saveToIndex].lastName =
                              value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'نام خانوادگی',
                        hintStyle: const TextStyle(color: Colors.black54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black),
                      validator: (value) {
                        if (value != null) {
                          value = convertFaToEn(value);
                        }
                        if (value == null || value.isEmpty) {
                          return 'لطفا کد ملی مسافر را وارد کنید';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          widget.tripData.passengerList[saveToIndex].id = convertFaToEn(value);
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'کد ملی',
                        hintStyle: const TextStyle(color: Colors.black54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
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
                        labelText: 'جنسیت',
                        hintStyle: const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'مرد',
                          child: Text(
                            'مرد',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'زن',
                          child: Text(
                            'زن',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          widget.tripData.passengerList[saveToIndex].gender =
                              value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Container buildTicket(Ticket ticket, String title) {
    return Container(
        height: 140,
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 12, 16.0, 0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            ticket.company.logo!,
                            width: 50.0,
                            height: 50.0,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            ticket.company.name,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      const SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          () {
                            if (ticket.description != '') {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  ticket.description,
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                              );
                            } else {
                              return const SizedBox(height: 0);
                            }
                          }(),
                          () {
                            return Row(
                              children: ticket.tags
                                  .map(
                                    (tag) => Container(
                                      margin: const EdgeInsets.only(right: 4.0),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.blueAccent.withOpacity(0.15),
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                      ),
                                      child: Text(
                                        tag,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Colors.black,
                                            ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          }(),
                          () {
                            if (ticket.description == '') {
                              return const SizedBox(height: 12.0);
                            } else {
                              return const SizedBox(height: 8.0);
                            }
                          }(),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              children: [
                                Text(
                                  ticket.from,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(width: 4.0),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 16.0,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  ticket.to,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 2, 8, 0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_rounded,
                                  size: 16.0,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  convertEnToFa(
                                    '${ticket.outboundDate!.formatter.wN}  ${ticket.outboundDate!.year}/${ticket.outboundDate!.month}/${ticket.outboundDate!.day}   -  ساعت  ${ticket.outboundTimeString}',
                                  ),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                () {
                  if (ticket.description == '') {
                    return const SizedBox(height: 26.0);
                  } else {
                    return const SizedBox(height: 4.0);
                  }
                }(),
              ],
            ),
            const SizedBox(width: 8.0),
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: RotatedBox(
                quarterTurns: 3,
                child: Container(
                  margin: const EdgeInsets.only(right: 4.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                    child: Text(title,
                        style: Theme.of(context).textTheme.displayLarge),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

convertEnToFa(String txt) {
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

void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: Theme.of(context).textTheme.displaySmall,
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ),
  );
}