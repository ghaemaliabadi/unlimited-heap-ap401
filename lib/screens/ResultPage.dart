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
    price: 1210000,
    remainingSeats: 12,
    description: 'بلیط هواپیما با زاگرس',
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
    remainingSeats: 12,
    description: 'بلیط هواپیما با ماهان ایر',
    tags: ['CF8', 'اکونومی', 'سیستمی'],
  ),
  Ticket(
    transportBy: 'هواپیما',
    from: 'تهران',
    to: 'مشهد',
    outboundDate: Jalali(1401, 3, 15, 15, 30),
    inboundDate: Jalali(1400, 3, 15, 16, 35),
    company: Company('زاگرس'),
    price: 1210000,
    remainingSeats: 12,
    description: 'بلیط هواپیما با زاگرس',
    tags: ['Fokker 100', 'اکونومی', 'سیستمی'],
  ),
  Ticket(
    transportBy: 'هواپیما',
    from: 'تهران',
    to: 'مشهد',
    outboundDate: Jalali(1401, 3, 15, 18, 20),
    inboundDate: Jalali(1400, 3, 15, 18, 25),
    company: Company('ماهان'),
    price: 1210000,
    remainingSeats: 12,
    description: 'بلیط هواپیما با ماهان ایر',
    tags: ['CF8', 'اکونومی', 'سیستمی'],
  ),
];

@override
void initState(widget) {

}

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
      body: ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          return ticketCard(ticket: tickets[index]);
        },
      ),
    );
  }

  Widget ticketCard({required Ticket ticket}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
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
                ],
             ),
           ),
          const SizedBox(height: 12.0),
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
                    Text(
                      '${convertEnToFa(ticket.remainingSeats)} صندلی باقی مانده',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      '${convertEnToFa(numberFormat.format(ticket.price))} تومان',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              )
            ],
          )
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
