import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:unlimited_heap_ap401/models/trip.dart';
import 'package:unlimited_heap_ap401/models/ticket.dart';

import '../models/company.dart';

class ResultPage extends StatefulWidget {
  final Trip tripData;

  const ResultPage({Key? key, required this.tripData}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

var numberFormat = NumberFormat("###,###", "en_US");

List<Ticket> tickets = [
  Ticket(
    transportBy: 'هواپیما',
    from: 'تهران',
    to: 'مشهد',
    outboundDate: Jalali(1401, 3, 15, 12, 30),
    inboundDate: Jalali(1400, 3, 15, 13, 35),
    company: Company('زاگرس'),
    price: 920000,
    remainingSeats: 68,
    description: '',
    tags: ['Fokker 100', 'اکونومی', 'سیستمی'],
  ),
  Ticket(
    transportBy: 'هواپیما',
    from: 'تهران',
    to: 'مشهد',
    outboundDate: Jalali(1401, 3, 15, 14, 20),
    inboundDate: Jalali(1400, 3, 15, 15, 25),
    company: Company('ماهان'),
    price: 1210000,
    remainingSeats: 55,
    description: '',
    tags: ['CF8', 'اکونومی', 'سیستمی'],
  ),
  Ticket(
    transportBy: 'هواپیما',
    from: 'تهران',
    to: 'مشهد',
    outboundDate: Jalali(1401, 3, 15, 15, 30),
    inboundDate: Jalali(1400, 3, 15, 16, 35),
    company: Company('زاگرس'),
    price: 1590000,
    remainingSeats: 12,
    description: '',
    tags: ['Fokker 100', 'بیزنس', 'سیستمی'],
  ),
  Ticket(
    transportBy: 'هواپیما',
    from: 'تهران',
    to: 'مشهد',
    outboundDate: Jalali(1401, 3, 15, 18, 20),
    inboundDate: Jalali(1400, 3, 15, 18, 25),
    company: Company('ماهان'),
    price: 990000,
    remainingSeats: 0,
    description: '',
    tags: ['CF8', 'اکونومی', 'سیستمی'],
  ),
  Ticket(
    transportBy: 'هواپیما',
    from: 'تهران',
    to: 'مشهد',
    outboundDate: Jalali(1401, 3, 15, 18, 20),
    inboundDate: Jalali(1400, 3, 15, 18, 25),
    company: Company('وارش'),
    price: 1120000,
    remainingSeats: 15,
    description: '',
    tags: ['CF8', 'اکونومی', 'سیستمی'],
  ),
];

@override
void initState(widget) {}

class _ResultPageState extends State<ResultPage> {
  // trip data
  @override
  Widget build(BuildContext context) {
    // trip data
    final Trip tripData = widget.tripData;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            //replace with our own icon data.
          ),
          titleSpacing: 0,
          elevation: 2.5,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('بلیط ${tripData.transportBy} ${tripData.title}',
                      style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 2.0),
                  Text(tripData.dateString,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                          )),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  )),
              // convert icon to icon button
            ],
          ),
        ),
      ),
      body: buildListView(),
    );
  }

  ListView buildListView() {
    tickets.sort((a, b) => a.remainingSeats.compareTo(b.remainingSeats));
    tickets = tickets.reversed.toList();
    return ListView.builder(
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        return ticketCard(ticket: tickets[index]);
      },
    );
  }

  Widget ticketCard({required Ticket ticket}) {
    return GestureDetector(
      onTap: () {
        if (ticket.remainingSeats > 0) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => TicketPage(ticket: ticket),
          //   ),
          // );
          print("ok");
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        height: 170,
        decoration: () {
          if (ticket.remainingSeats > 0) {
            return BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0, 2),
                  blurRadius: 4.0,
                ),
              ],
            );
          } else {
            return BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(1, 3),
                  blurRadius: 4.0,
                ),
              ],
            );
          }
        }(),
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
                      Text(
                        ticket.transportBy,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Text(
                            ticket.from,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(width: 8.0),
                          const Icon(
                            Icons.arrow_forward,
                            size: 16.0,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            ticket.to,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Text(
                            ticket.outboundTimeString,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(width: 8.0),
                          const Icon(
                            Icons.arrow_forward,
                            size: 16.0,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            ticket.inboundTimeString,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            const Divider(
              height: 2.0,
              color: Colors.black,
            ),
            const SizedBox(height: 12.0),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      () {
                        if (ticket.remainingSeats > 0) {
                          return Text(
                            '${convertEnToFa(ticket.remainingSeats)} صندلی باقی مانده',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.grey[700],
                                  fontSize: 16.0,
                                ),
                          );
                        } else {
                          return Text(
                            'تکمیل ظرفیت',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.red[700],
                                  fontSize: 16.0,
                                ),
                          );
                        }
                      }(),
                      Row(
                        children: [
                          Text(
                              '${convertEnToFa(numberFormat.format(ticket.price))}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: 28.0,
                                    color: (ticket) {
                                      if (ticket.remainingSeats > 0) {
                                        return Colors.blueAccent;
                                      } else {
                                        return Colors.grey[700];
                                      }
                                    }(ticket),
                                    fontWeight: FontWeight.bold,
                                  )),
                          const SizedBox(width: 4.0),
                          Column(
                            children: [
                              const SizedBox(height: 4.0),
                              Text(
                                'تومان',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.grey[700],
                                      fontSize: 18.0,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ) // price and remaining seats
          ],
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
