import 'dart:collection';
import 'package:flutter/material.dart';

import '../models/ticket.dart';

// ignore: must_be_immutable
class ShowTicketDetails extends StatefulWidget {
  Ticket ticket;
  ShowTicketDetails({super.key, required this.ticket});
  @override
  State<ShowTicketDetails> createState() => _ShowTicketDetailsState();
}

class _ShowTicketDetailsState extends State<ShowTicketDetails> {
  var _startValue = 4.5;
  var _endValue = 23.5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1.5,
          title: Text('اطلاعات ${widget.ticket.transportBy}',
              style: Theme.of(context).textTheme.displayMedium),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column (
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.ticket.from} - ${widget.ticket.to}',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${widget.ticket.outboundDate?.year}/${widget.ticket.outboundDate?.month}/${widget.ticket.outboundDate?.day}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${widget.ticket.outboundTimeString}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${widget.ticket.inboundDate?.year}/${widget.ticket.inboundDate?.month}/${widget.ticket.inboundDate?.day}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${widget.ticket.inboundTimeString}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${widget.ticket.company.name}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${widget.ticket.price} تومان',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${widget.ticket.remainingSeats} صندلی',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${widget.ticket.description}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${widget.ticket.tags}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'نظرات کاربران',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 8.0),
            ],
          ),
        ),
      ],
    ),
    ),
    );
  }
}

String convertIntToTimeStr(double time) {
  var intPart = time ~/ 1;
  var decimalPart = time - intPart;
  var hour = intPart;
  var minute = (decimalPart * 60).round();
  return '${hour < 10 ? '0' : ''}$hour:${minute < 10 ? '0' : ''}$minute';
}