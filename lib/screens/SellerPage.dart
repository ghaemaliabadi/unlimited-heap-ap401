import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../models/company.dart';
import '../models/ticket.dart';

class SellerPage extends StatefulWidget {
  const SellerPage({super.key});

  final String title = 'صفحه فروشنده';

  @override
  State<SellerPage> createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  var numberFormat = NumberFormat("###,###", "en_US");
  // TODO: get this part from backend
  List<Ticket> tickets = [
    Ticket(
      ticketID: 1,
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
      ticketID: 2,
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
      ticketID: 3,
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
      ticketID: 4,
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
      ticketID: 5,
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
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1.5,
        title: Text(widget.title,
            style: Theme
                .of(context)
                .textTheme
                .displayMedium),
      ),
      body: InkWell(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: [
              Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.75,
                  child: FutureBuilder(
                    future:
                    Future.delayed(const Duration(seconds: 2)).then((
                        value) => tickets),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Expanded(child: buildListViewForCards());
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(top: 100.0),
                          child: Center(
                            child: LoadingAnimationWidget.fourRotatingDots(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                              size: 100,
                            ),
                          ),
                        );
                      }
                    },
                  ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      _showSnackBar(context, 'ثبت بلیط جدید');
                    },
                    child: buildButton('ثبت بلیط جدید'),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      _showSnackBar(context, 'مشاهده تحلیل فروش');
                    },
                    child: buildButton('مشاهده تحلیل فروش'),
                  ),
                ],
              )
            ],
          )),
    );
  }

  Container buildButton(input) {
    return Container(
      height: 50,
      width: 180,
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        color: Theme
            .of(context)
            .colorScheme
            .primary,
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
            style: Theme
                .of(context)
                .textTheme
                .displayMedium!
                .copyWith(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListViewForCards() {
    if (tickets.isEmpty) {
      return Column(
        children: [
          const SizedBox(height: 200.0),
          Text(
            'هیچ بلیطی یافت نشد.',
            style: Theme
                .of(context)
                .textTheme
                .displayLarge,
          ),
        ],
      );
    } else {
      tickets = divideByRemainingSeats(tickets);
      return ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          return ticketCard(ticket: tickets[index]);
        },
      );
    }
  }


  List<Ticket> divideByRemainingSeats(List<Ticket> tickets) {
    List<Ticket> remaining0Tickets = [];
    List<Ticket> otherTickets = [];
    for (var ticket in tickets) {
      if (ticket.remainingSeats == 0) {
        remaining0Tickets.add(ticket);
      } else {
        otherTickets.add(ticket);
      }
    }
    tickets = otherTickets + remaining0Tickets;
    return tickets;
  }

  Widget ticketCard({required Ticket ticket}) {
    return GestureDetector(
      onTap: () {
        _showSnackBar(context, 'مشاهده جزئیات بلیط');
      },
      child: ticketContainer(ticket),
    );
  }
  Container ticketContainer(Ticket ticket) {
    return Container(
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
                                style: Theme.of(context).textTheme.displayLarge,
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
                                style: Theme.of(context).textTheme.displayLarge,
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
                          style:
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[700],
                            fontSize: 16.0,
                          ),
                        );
                      } else {
                        return Text(
                          'تکمیل ظرفیت',
                          style:
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                            style:
                            Theme.of(context).textTheme.bodyLarge?.copyWith(
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
    );
  }
}

void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: Theme
            .of(context)
            .textTheme
            .displaySmall,
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .secondary,
    ),
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
