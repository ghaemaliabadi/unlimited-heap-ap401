import 'dart:collection';
import 'dart:convert' show utf8;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:unlimited_heap_ap401/models/trip.dart';
import 'package:unlimited_heap_ap401/models/ticket.dart';
import 'package:unlimited_heap_ap401/screens/showTicketDetails.dart';
import '../models/company.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pull_down_button/pull_down_button.dart';
import '../models/sort.dart';
import 'FilterPage.dart';

// ignore: must_be_immutable
class ResultPage extends StatefulWidget {
  Trip tripData;
  Sort sort;
  String selectTicketFor;
  List<bool>? selectedCompanies;
  List<bool>? selectedTags;
  double? startValue;
  double? endValue;

  ResultPage({
    Key? key,
    required this.tripData,
    required this.sort,
    required this.selectTicketFor,
    this.selectedCompanies,
    this.selectedTags,
    this.startValue,
    this.endValue,
  }) : super(key: key);

  static const String ip = "127.0.0.1";
  static const int port = 1234;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

var numberFormat = NumberFormat("###,###", "en_US");

List<Ticket> orgTickets = [];
List<Ticket> tickets = [];
HashSet<String>? allTags = HashSet();
HashSet<String>? allCompanies = HashSet();
AutoScrollController _scrollController = AutoScrollController();

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    var tempFrom = widget.tripData.from;
    var tempTo = widget.tripData.to;
    var tempMonth = widget.tripData.date!.month;
    var tempDay = widget.tripData.date!.day;
    if (widget.tripData.type == 'رفت و برگشت') {
      tempMonth = widget.tripData.dateRange!.start.month;
      tempDay = widget.tripData.dateRange!.start.day;
    }
    if (widget.selectTicketFor == 'return') {
      tempFrom = widget.tripData.to;
      tempTo = widget.tripData.from;
      tempMonth = widget.tripData.dateRange!.end.month;
      tempDay = widget.tripData.dateRange!.end.day;
    }
    _getTicketsFromTo(widget.tripData.transportBy, tempFrom, tempTo, tempMonth, tempDay)
        .then((value) {
      tickets = orgTickets;
      if (widget.selectedCompanies != null) {
        for (var i = 0; i < widget.selectedCompanies!.length; i++) {
          if (!widget.selectedCompanies![i]) {
            tickets.removeWhere((element) =>
                element.company.name == allCompanies!.elementAt(i));
          }
        }
      }
      if (widget.selectedTags != null) {
        for (var i = 0; i < widget.selectedTags!.length; i++) {
          if (!widget.selectedTags![i]) {
            tickets.removeWhere(
                (element) => element.tags.contains(allTags!.elementAt(i)));
          }
        }
      }
      if (widget.startValue != null) {
        tickets.removeWhere(
            (element) => element.outboundDate!.hour < widget.startValue!);
      }
      if (widget.endValue != null) {
        tickets.removeWhere(
            (element) => element.outboundDate!.hour > widget.endValue!);
      }
      for (var ticket in orgTickets) {
        allTags?.addAll(ticket.tags);
        allCompanies?.add(ticket.company.name);
      }
    });
    _scrollController = AutoScrollController();
    _scrollController.scrollToIndex(
        (widget.tripData.date!.day + widget.tripData.date!.month * 31) -
            (Jalali.now().day + Jalali.now().month * 31),
        preferPosition: AutoScrollPosition.begin,
        duration: const Duration(milliseconds: 1));
    super.initState();
  }

  void dispose() {
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
              if (widget.tripData.type == 'رفت و برگشت' &&
                  widget.tripData.departTicket != null) {
                widget.tripData.departTicket = null;
                widget.tripData.returnTicket = null;
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
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
                  Text(tripData.dateStringWithParam(widget.selectTicketFor),
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
          () {
            if (widget.tripData.departTicket != null) {
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 16, 0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      margin: const EdgeInsets.only(right: 4.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('بلیط رفت:',
                              style: Theme.of(context).textTheme.bodyLarge),
                          const SizedBox(width: 4.0),
                          Text(
                              '${convertEnToFa(widget.tripData.departTicket!.outboundDate?.day)} ${widget.tripData.departTicket!.outboundDate?.formatter.mN}',
                              style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          }(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 16.0, 14.0, 8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        var selectedCompanies =
                            List<bool>.filled(allCompanies!.length, true);
                        var selectedTags =
                            List<bool>.filled(allTags!.length, true);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FilterPage(
                              tripData: widget.tripData,
                              selectTicketFor: widget.selectTicketFor,
                              tags: allTags,
                              companies: allCompanies,
                              selectedCompanies:
                                  (widget.selectedCompanies == null)
                                      ? selectedCompanies
                                      : widget.selectedCompanies!,
                              selectedTags: (widget.selectedTags == null)
                                  ? selectedTags
                                  : widget.selectedTags!,
                              startValue: (widget.startValue == null)
                                  ? 4.5
                                  : widget.startValue!,
                              endValue: (widget.endValue == null)
                                  ? 23.5
                                  : widget.endValue!,
                            ),
                          ),
                        );
                      },
                      child: Container(
                          height: 32.0,
                          width: 120.0,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(1000),
                            border: Border.all(
                                color: Colors.grey[300]!,
                                width: 1.5,
                                style: BorderStyle.solid),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.filter_list,
                                color: Colors.black54,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                'فیلترها',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(width: 8.0),
                    PullDownButton(
                        itemBuilder: (context) => [
                              PullDownMenuItem.selectable(
                                  onTap: () {
                                    setState(() {
                                      widget.sort.byPriceAsc = false;
                                      widget.sort.byPriceDesc = false;
                                      widget.sort.byTimeAsc = false;
                                      widget.sort.byTimeDesc = false;
                                      widget.sort.defaultSort = true;
                                      tickets = sortTickets(tickets);
                                      buildListWithLoading(tickets);
                                    });
                                  },
                                  selected: widget.sort.defaultSort,
                                  title: 'پیش فرض',
                                  // icon: Icons.arrow_downward_rounded,
                                  itemTheme: PullDownMenuItemTheme(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontSize: 20.0,
                                        ),
                                  )),
                              PullDownMenuItem.selectable(
                                  onTap: () {
                                    setState(() {
                                      widget.sort.byPriceAsc = true;
                                      widget.sort.byPriceDesc = false;
                                      widget.sort.byTimeAsc = false;
                                      widget.sort.byTimeDesc = false;
                                      widget.sort.defaultSort = false;
                                      tickets = sortTickets(tickets);
                                      buildListWithLoading(tickets);
                                    });
                                  },
                                  selected: widget.sort.byPriceAsc,
                                  title: 'ارزان ترین',
                                  // icon: Icons.arrow_downward_rounded,
                                  itemTheme: PullDownMenuItemTheme(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontSize: 20.0,
                                        ),
                                  )),
                              PullDownMenuItem.selectable(
                                  onTap: () {
                                    setState(() {
                                      widget.sort.byPriceAsc = false;
                                      widget.sort.byPriceDesc = true;
                                      widget.sort.byTimeAsc = false;
                                      widget.sort.byTimeDesc = false;
                                      widget.sort.defaultSort = false;
                                      tickets = sortTickets(tickets);
                                      buildListWithLoading(tickets);
                                    });
                                  },
                                  selected: widget.sort.byPriceDesc,
                                  title: 'گران ترین',
                                  // icon: Icons.arrow_upward_rounded,
                                  itemTheme: PullDownMenuItemTheme(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontSize: 20.0,
                                        ),
                                  )),
                              PullDownMenuItem.selectable(
                                  onTap: () {
                                    setState(() {
                                      widget.sort.byPriceAsc = false;
                                      widget.sort.byPriceDesc = false;
                                      widget.sort.byTimeAsc = true;
                                      widget.sort.byTimeDesc = false;
                                      widget.sort.defaultSort = false;
                                      tickets = sortTickets(tickets);
                                      buildListWithLoading(tickets);
                                    });
                                  },
                                  selected: widget.sort.byTimeAsc,
                                  title: 'زودترین',
                                  // icon: Icons.arrow_downward_rounded,
                                  itemTheme: PullDownMenuItemTheme(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontSize: 20.0,
                                        ),
                                  )),
                              PullDownMenuItem.selectable(
                                  onTap: () {
                                    setState(() {
                                      widget.sort.byPriceAsc = false;
                                      widget.sort.byPriceDesc = false;
                                      widget.sort.byTimeAsc = false;
                                      widget.sort.byTimeDesc = true;
                                      widget.sort.defaultSort = false;
                                      tickets = sortTickets(tickets);
                                      buildListWithLoading(tickets);
                                    });
                                  },
                                  selected: widget.sort.byTimeDesc,
                                  title: 'دیرترین',
                                  // icon: Icons.arrow_upward_rounded,
                                  itemTheme: PullDownMenuItemTheme(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontSize: 20.0,
                                        ),
                                  )),
                            ],
                        buttonBuilder: (context, showMenu) => GestureDetector(
                              onTap: showMenu,
                              child: Container(
                                  height: 32.0,
                                  width: 140.0,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(1000),
                                    border: Border.all(
                                      color: Colors.blueAccent,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.sort_rounded,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(width: 6.0),
                                      Text(
                                        widget.sort.buttonText,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: Colors.blue[800],
                                            ),
                                      ),
                                      const SizedBox(width: 1.0),
                                      const Icon(
                                        Icons.arrow_drop_down_rounded,
                                        color: Colors.blue,
                                      ),
                                    ],
                                  )),
                            ))
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      'قیمت‌ها برای یک بزرگسال محاسبه شده است.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
          buildListWithLoading(tickets),
          // Expanded(child: buildListViewForCards()),
        ],
      ),
    );
  }

  List<Ticket> sortTickets(List<Ticket> tickets) {
    if (widget.sort.byPriceAsc) {
      tickets.sort((a, b) => a.price.compareTo(b.price));
    } else if (widget.sort.byPriceDesc) {
      tickets.sort((a, b) => b.price.compareTo(a.price));
    } else if (widget.sort.byTimeAsc || widget.sort.defaultSort) {
      tickets.sort((a, b) =>
          (a.outboundDate!.hour * 60 + a.outboundDate!.minute)
              .compareTo(b.outboundDate!.hour * 60 + b.outboundDate!.minute));
    } else if (widget.sort.byTimeDesc) {
      tickets.sort((a, b) =>
          (b.outboundDate!.hour * 60 + b.outboundDate!.minute)
              .compareTo(a.outboundDate!.hour * 60 + a.outboundDate!.minute));
    }
    return divideByRemainingSeats(tickets);
  }

  FutureBuilder<List<Ticket>> buildListWithLoading(tickets) {
    return FutureBuilder(
      future:
          Future.delayed(const Duration(seconds: 2)).then((value) => tickets),
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
    );
  }

  Widget buildListViewForCards() {
    if (tickets.isEmpty) {
      return Column(
        children: [
          const SizedBox(height: 200.0),
          Text(
            'هیچ بلیطی یافت نشد.',
            style: Theme.of(context).textTheme.displayLarge,
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
        if (ticket.remainingSeats > 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ShowTicketDetails(ticket: ticket, tripData: widget.tripData),
            ),
          );
        }
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

  buildListViewForDateSelect() {
    // Trip tripData = widget.tripData;
    // list of dates
    var nowDate = Jalali.now();
    List<Jalali> dates = [];
    var now = Jalali(nowDate.year, nowDate.month, nowDate.day);
    var targetDate = widget.tripData.date;
    if (widget.selectTicketFor == 'return') {
      targetDate = widget.tripData.dateRange!.end;
    } else {
      // departure
      if (widget.tripData.type == 'رفت و برگشت') {
        targetDate = widget.tripData.dateRange!.start;
      }
    }
    var selected = Jalali(targetDate!.year, targetDate.month, targetDate.day);
    for (var i = -180; i < 180; i++) {
      var date = selected.addDays(i);
      if (date.isAfter(now) || date.isAtSameMomentAs(now)) {
        dates.add(date);
      }
    }
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.81,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return AutoScrollTag(
            key: ValueKey(index),
            controller: _scrollController,
            index: index,
            child: GestureDetector(
              onTap: () {
                // setState(() {
                //   widget.tripData.date = dates[index];
                // });
                widget.tripData.date = dates[index];
                if (widget.selectTicketFor == 'return') {
                  widget.tripData.dateRange = JalaliRange(
                    start: widget.tripData.dateRange!.start,
                    end: dates[index],
                  );
                } else {
                  // departure
                  if (widget.tripData.type == 'رفت و برگشت') {
                    widget.tripData.dateRange = JalaliRange(
                      start: dates[index],
                      end: widget.tripData.dateRange!.end,
                    );
                  }
                }
                orgTickets.clear();
                tickets.clear();
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          ResultPage(
                            tripData: widget.tripData,
                            sort: widget.sort,
                            selectTicketFor: widget.selectTicketFor,
                          )),
                );
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                width: MediaQuery.of(context).size.width * 0.197,
                decoration: BoxDecoration(
                  color: (widget.tripData.date == dates[index])
                      ? Colors.blueAccent.withOpacity(0.3)
                      : Colors.grey[200],
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
                    Column(
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
                        // Text(
                        //   '${convertEnToFa(numberFormat.format(12000))}',
                        //   style: const TextStyle(
                        //     fontSize: 14,
                        //     fontWeight: FontWeight.bold,
                        //     color: Colors.black54,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
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

Future<String> _getTicketsFromTo(transportBy, city1, city2, month, day) async {
  String response = "false";
  await Socket.connect(ResultPage.ip, ResultPage.port).then((serverSocket) {
    serverSocket.write("getTicketsFromTo-$transportBy-$city1-$city2-$month-$day*");
    serverSocket.flush();
    print("Sent data!");
    serverSocket.listen((socket) {
      response = utf8.decode(socket);
      print(response);
      List<String> temp = response.split("\n");
      orgTickets = [];
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
          orgTickets.add(Ticket(
              ticketID: int.parse(element[0]),
              transportBy: element[1],
              from: element[2],
              to: element[3],
              outboundDate: Jalali(
                  int.parse(element[4]),
                  int.parse(element[5]),
                  int.parse(element[6]),
                  int.parse(element[7]),
                  int.parse(element[8])),
              inboundDate: Jalali(
                  int.parse(element[9]),
                  int.parse(element[10]),
                  int.parse(element[11]),
                  int.parse(element[12]),
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
