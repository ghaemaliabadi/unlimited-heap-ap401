import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/sort.dart';
import '../models/ticket.dart';
import '../models/trip.dart';
import 'PassengersDataPage.dart';
import 'ResultPage.dart';

// ignore: must_be_immutable
class ShowTicketDetails extends StatefulWidget {
  Ticket ticket;
  Trip tripData;

  ShowTicketDetails({super.key, required this.ticket, required this.tripData});

  @override
  State<ShowTicketDetails> createState() => _ShowTicketDetailsState();
}

var numberFormat = NumberFormat("###,###", "en_US");

class _ShowTicketDetailsState extends State<ShowTicketDetails> {
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
        title: Text('اطلاعات ${widget.ticket.transportBy}',
            style: Theme.of(context).textTheme.displayMedium),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            widget.ticket.company.logo!,
                            width: 90.0,
                            height: 100.0,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            widget.ticket.company.name,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ],
                      ),
                    ),
                    RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.linear_scale_sharp,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 80.0,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          widget.ticket.outboundTimeString,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          widget.ticket.inboundTimeString,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                    const SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.ticket.from,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              convertEnToFa(
                                  '${widget.ticket.outboundDate!.formatter.wN} ${widget.ticket.outboundDate!.day} ${widget.ticket.outboundDate!.formatter.mN} ${widget.ticket.outboundDate!.year}'),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.ticket.to,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              convertEnToFa(
                                  '${widget.ticket.inboundDate!.formatter.wN} ${widget.ticket.inboundDate!.day} ${widget.ticket.inboundDate!.formatter.mN} ${widget.ticket.inboundDate!.year}'),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.event_seat_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8.0),
                      Row(
                        children: [
                          Text(
                            'تعداد صندلی باقی مانده: ',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(width: 2.0),
                          Text(
                            '${convertEnToFa(widget.ticket.remainingSeats.toString())} عدد',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 16, 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'اطلاعات بیشتر ${widget.ticket.transportBy}:',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 16, 4),
                  child: Row(
                    children: [
                      Wrap(
                        spacing: 8.0,
                        children: widget.ticket.tags.map((tag) {
                          return Chip(
                            label: Text(
                              tag,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
              ],
            ),
            // size box by page height
            SizedBox(height: MediaQuery.of(context).size.height * 0.29),
            SizedBox(
              height: 1.0,
              child: Container(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, top: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        'جزئیات مسافران:',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 42, 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '- بزرگسال:',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            convertEnToFa(
                                '${convertEnToFa(numberFormat.format(widget.tripData.passengers['adult']))} نفر'),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '- کودک:',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            convertEnToFa(
                                '${convertEnToFa(numberFormat.format(widget.tripData.passengers['child']))} نفر'),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            '- نوزاد:',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            convertEnToFa(
                                '${convertEnToFa(numberFormat.format(widget.tripData.passengers['infant']))} نفر'),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.0,
                  child: Container(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 16, 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 2.0),
                          Text(
                            'مجموع قیمت:',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          children: [
                            Text(
                              // price with number format and convert to fa
                                convertEnToFa(
                                    '${convertEnToFa(numberFormat.format(widget.ticket.price * widget.tripData.sumPassengers))}'),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                  color: Colors.blueAccent,
                                  fontSize: 32.0,
                                )),
                            const SizedBox(width: 6.0),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                'تومان',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // text button for buy ticket
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 54.0,
                child: TextButton(
                  onPressed: () {
                    if (widget.tripData.type == 'رفت و برگشت' && widget.tripData.departTicket == null) {
                      widget.tripData.departTicket = widget.ticket;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ResultPage(
                            tripData: widget.tripData,
                            sort: Sort(),
                            selectTicketFor: 'return',
                          )));
                    } else {
                      if (widget.tripData.type == 'رفت و برگشت') {
                        widget.tripData.returnTicket = widget.ticket;
                      } else {
                        widget.tripData.departTicket = widget.ticket;
                      }
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PassengersDataPage(
                            tripData: widget.tripData,
                          )));
                    }
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => BuyTicketPage(
                    //       ticket: widget.ticket,
                    //       tripData: widget.tripData,
                    //     ),
                    //   ),
                    // );
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
                    'خرید بلیط',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
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
