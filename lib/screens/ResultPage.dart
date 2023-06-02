import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:unlimited_heap_ap401/models/trip.dart';
import 'package:unlimited_heap_ap401/models/ticket.dart';
import '../models/company.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// ignore: must_be_immutable
class ResultPage extends StatefulWidget {
  Trip tripData;

  ResultPage({Key? key, required this.tripData}) : super(key: key);

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
    description: 'توضیحات تستی نام واسه قطار',
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
ScrollController _scrollController = ScrollController();

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
      body: Column(
        children: [
          Container(
            height: 65.0,
            color: Colors.grey[200],
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    _scrollController.animateTo(
                      _scrollController.position.pixels -
                          MediaQuery.of(context).size.width * 0.196,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(0, 6, 16, 0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.grey,
                    ),
                  ),
                ),
                buildListViewForDateSelect(),
                InkWell(
                  onTap: () {
                    // scroll to left
                    _scrollController.animateTo(
                      _scrollController.position.pixels +
                          MediaQuery.of(context).size.width * 0.196,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(16, 6, 0, 0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16.0, 14.0, 8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: Colors.grey,
                ),
                const SizedBox(width: 8.0),
                // TODO: add filter menu and sort dropdown
                Text(
                  'قیمت‌ها برای یک بزرگسال محاسبه شده است.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: Future.delayed(const Duration(seconds: 2))
                .then((value) => tickets),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(child: buildListViewForCards());
              } else {
                return Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                      color: Theme.of(context).colorScheme.primary,
                      size: 100,
                    ),
                  ),
                );
              }
            },
          ),
          // Expanded(child: buildListViewForCards()),
        ],
      ),
    );
  }

  ListView buildListViewForCards() {
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
                      () {
                        if (ticket.description != '') {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              ticket.description,
                              style: Theme.of(context).textTheme.displaySmall,
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
                            Column(
                              children: [
                                Text(
                                  ticket.outboundTimeString,
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  ticket.from,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            const SizedBox(width: 8.0),
                            const Icon(
                              Icons.arrow_forward_rounded,
                              size: 32.0,
                            ),
                            const SizedBox(width: 4.0),
                            Column(
                              children: [
                                Text(
                                  ticket.inboundTimeString,
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  ticket.to,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
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
            const Divider(
              height: 2.0,
              color: Colors.black,
            ),
            const SizedBox(height: 8.0),
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

  buildListViewForDateSelect() {
    // Trip tripData = widget.tripData;
    // list of dates
    var nowDate = Jalali.now();
    // TODO: config with for and navigate scrollbar to selected date
    List<Jalali> dates = [
      Jalali(nowDate.year, nowDate.month, nowDate.day),
      Jalali(nowDate.year, nowDate.month, nowDate.day + 1),
      Jalali(nowDate.year, nowDate.month, nowDate.day + 2),
      Jalali(nowDate.year, nowDate.month, nowDate.day + 3),
      Jalali(nowDate.year, nowDate.month, nowDate.day + 4),
      Jalali(nowDate.year, nowDate.month, nowDate.day + 5),
      Jalali(nowDate.year, nowDate.month, nowDate.day + 6),
      Jalali(nowDate.year, nowDate.month, nowDate.day + 7),
      Jalali(nowDate.year, nowDate.month, nowDate.day + 8),
      Jalali(nowDate.year, nowDate.month, nowDate.day + 9),
      Jalali(nowDate.year, nowDate.month, nowDate.day + 10),
    ];
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.81,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            width: MediaQuery.of(context).size.width * 0.197,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
              // border from left
              border: Border(
                left: BorderSide(
                  color: Colors.grey[500]!,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   widget.tripData.date = dates[index];
                    // });
                    widget.tripData.date = dates[index];
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              ResultPage(tripData: widget.tripData)),
                    );
                  },
                  child: Column(
                    children: [
                      Text(
                        // ignore: prefer_interpolation_to_compose_strings
                        '${dates[index].formatter.wN.substring(0, 1) + ' - ' + convertEnToFa(dates[index].formatter.mm)}/' +
                            convertEnToFa(dates[index].day),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                        ),
                      ),
                      Text(
                        '${convertEnToFa(numberFormat.format(1265))}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
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