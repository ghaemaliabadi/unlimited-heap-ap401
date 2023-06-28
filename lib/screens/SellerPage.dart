import 'dart:io';
import 'dart:convert' show utf8;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../models/company.dart';
import '../models/ticket.dart';
import '../models/userinfo.dart';
import 'AddNewTicket.dart';

// ignore: must_be_immutable
class SellerPage extends StatefulWidget {
  User? user;

  SellerPage({
    Key? key,
    this.user,
  }) : super(key: key);

  final String title = 'صفحه فروشنده';
  static const String ip = "127.0.0.1";
  static const int port = 1234;

  @override
  State<SellerPage> createState() => _SellerPageState();
}

List<Ticket>? tickets;

class _SellerPageState extends State<SellerPage> {
  var numberFormat = NumberFormat("###,###", "en_US");

  @override
  void initState() {
    super.initState();
  }

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
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.75,
                child: FutureBuilder(
                  // future: Future.delayed(const Duration(seconds: 2))
                  future: _getUserTickets("وارش")
                      .then((value) => tickets),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // return Expanded(child: buildListViewForCards());
                      return buildListViewForCards();
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddNewTicket(
                                title: 'ثبت بلیط جدید',
                                user: widget.user,
                              ),
                        ),
                      );
                    },
                    child: buildButton('ثبت بلیط جدید'),
                  ),
                  const SizedBox(width: 20),
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
      margin: const EdgeInsets.only(top: 20),
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
    if (tickets!.isEmpty) {
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
      tickets = divideByRemainingSeats(tickets!);
      return ListView.builder(
        itemCount: tickets!.length,
        itemBuilder: (context, index) {
          return ticketCard(ticket: tickets![index]);
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
    // return GestureDetector(
    //   onTap: () {
    //     _showSnackBar(context, 'مشاهده جزئیات بلیط');
    //   },
    //   child:
    return ticketContainer(ticket);
    // );
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
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 2.0,
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddNewTicket(
                                  title: 'ویرایش بلیط شماره  ${ticket
                                      .ticketID}',
                                  ticket: ticket,
                                  user: widget.user,
                                ),
                          ),
                        );
                      },
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(1000),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black38,
                              offset: Offset(0, 0),
                              blurRadius: 1.0,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Theme
                              .of(context)
                              .colorScheme
                              .primary,
                          size: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: () {
                        // show dialog for submit delete
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'حذف بلیط',
                                style:
                                Theme
                                    .of(context)
                                    .textTheme
                                    .displayMedium,
                              ),
                              content: Text(
                                'آیا از حذف بلیط اطمینان دارید؟',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .displaySmall,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'خیر',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                      color: Theme
                                          .of(context)
                                          .colorScheme
                                          .primary,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // delete ticket
                                    setState(() {
                                      // TODO: delete ticket from database
                                      tickets?.remove(ticket);
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'بله',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(
                                      color: Theme
                                          .of(context)
                                          .colorScheme
                                          .primary,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(1000),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black38,
                              offset: Offset(0, 0),
                              blurRadius: 1.0,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.delete,
                          color: Theme
                              .of(context)
                              .colorScheme
                              .primary,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(width: 16.0),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Image.asset(
                //       ticket.company.logo!,
                //       width: 50.0,
                //       height: 50.0,
                //     ),
                //     const SizedBox(height: 8.0),
                //     Text(
                //       ticket.company.name,
                //       style: Theme.of(context).textTheme.bodyLarge,
                //     ),
                //   ],
                // ),
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
                            style: Theme
                                .of(context)
                                .textTheme
                                .displaySmall,
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
                              (tag) =>
                              Container(
                                margin: const EdgeInsets.only(right: 4.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(1000),
                                ),
                                child: Text(
                                  tag,
                                  style: Theme
                                      .of(context)
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
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .displayLarge,
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                ticket.from,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodySmall,
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
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .displayLarge,
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                ticket.to,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodySmall,
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
          const SizedBox(height: 4.0),
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
                          '${convertEnToFa(ticket
                              .remainingSeats)} صندلی باقی مانده',
                          style:
                          Theme
                              .of(context)
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
                          style:
                          Theme
                              .of(context)
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
                            '${convertEnToFa(numberFormat.format(ticket
                                .price))}',
                            style:
                            Theme
                                .of(context)
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
                              style: Theme
                                  .of(context)
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

Future<String> _getUserTickets(companyName) async {
  String response = "false";
  await Socket.connect(SellerPage.ip, SellerPage.port).then((serverSocket) {
    print("Connected!");
    serverSocket.write("getTickets-$companyName*");
    serverSocket.flush();
    print("Sent data!");
    serverSocket.listen((socket) {
      // response = String.fromCharCodes(socket).trim().substring(2);
      response = utf8.decode(socket);
      List<String> temp = response.split("\n");
      tickets = [];
      for (var line in temp) {
        List<String> element = line.split("-");
        if (element.length > 1) {
          List<String> tags = [];
          if (element[18] != '') {
            tags.add(element[18]);
          }
          if (element[19] != '') {
            tags.add(element[19]);
          }
          if (element[20] != '') {
            tags.add(element[20]);
          }
          if (element[21] != '') {
            tags.add(element[21]);
          }
          tickets?.add(Ticket(
              ticketID: int.parse(element[0]),
              transportBy: element[1],
              from: element[2],
              to: element[3],
              outboundDate: Jalali(
                  int.parse(element[4]), int.parse(element[5]),
                  int.parse(element[6]), int.parse(element[7]),
                  int.parse(element[8])),
              inboundDate
                  : Jalali(
                  int.parse(element[9]), int.parse(element[10]),
                  int.parse(element[11]), int.parse(element[12]),
                  int.parse(element[13])),
              company: Company(element[14]),
              price: int.parse(element[15]),
              remainingSeats: int.parse(element[16]),
              description: element[17] == 'null' ? '' : element[17],
              tags: tags));
        }
      }
    });
  });
  return Future.delayed(const Duration(milliseconds: 1000), () => response);
}
