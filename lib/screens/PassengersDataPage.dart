import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/sort.dart';
import '../models/trip.dart';

// ignore: must_be_immutable
class PassengersDataPage extends StatefulWidget {
  Trip tripData;

  PassengersDataPage({super.key, required this.tripData});

  @override
  State<PassengersDataPage> createState() => _PassengersDataPageState();
}

var numberFormat = NumberFormat("###,###", "en_US");

class _PassengersDataPageState extends State<PassengersDataPage> {
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                          if (widget.tripData.transportBy == 'هواپیما') {
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
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)),
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
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
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
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0, 2),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16.0, 12, 16.0, 0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    widget.tripData.departTicket!.company.logo!,
                                    width: 50.0,
                                    height: 50.0,
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    widget.tripData.departTicket!.company.name,
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 16.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                      () {
                                    if (widget.tripData.departTicket!.description != '') {
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          widget.tripData.departTicket!.description,
                                          style: Theme.of(context).textTheme.displaySmall,
                                        ),
                                      );
                                    } else {
                                      return const SizedBox(height: 0);
                                    }
                                  }(),
                                      () {
                                    return Row(
                                      children: widget.tripData.departTicket!.tags
                                          .map(
                                            (tag) => Container(
                                          margin: const EdgeInsets.only(right: 4.0),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 4.0),
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent.withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(1000),
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
                                    if (widget.tripData.departTicket!.description == '') {
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
                                          widget.tripData.departTicket!.from,
                                          style: Theme.of(context).textTheme.bodyLarge,
                                        ),
                                        const SizedBox(width: 4.0),
                                        const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 16.0,
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          widget.tripData.departTicket!.to,
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
                                              '${widget.tripData.departTicket!.outboundDate!.formatter.wN}  ${widget.tripData.departTicket!.outboundDate!.year}/${widget.tripData.departTicket!.outboundDate!.month}/${widget.tripData.departTicket!.outboundDate!.day}   -  ساعت  ${widget.tripData.departTicket!.outboundTimeString}',
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
                          if (widget.tripData.departTicket!.description == '') {
                            return const SizedBox(height: 26.0);
                          } else {
                            return const SizedBox(height: 4.0);
                          }
                        }(),
                      ],
                    )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
