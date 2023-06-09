import 'package:flutter/material.dart';

import '../models/trip.dart';

// ignore: must_be_immutable
class SubmitDetailsPage extends StatefulWidget {
  final Trip tripData;
  const SubmitDetailsPage({super.key, required this.tripData});

  @override
  State<SubmitDetailsPage> createState() => SubmitDetailsPageState();
}

class SubmitDetailsPageState extends State<SubmitDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.5,
        title: Text('تایید اطلاعات',
            style: Theme.of(context).textTheme.displayMedium),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            buildTicketDetails(widget.tripData!.departTicket),
            () {
             if (widget.tripData.type == 'رفت و برگشت') {
               // return buildTicketDetails();
               return const SizedBox();
             } else {
               return const SizedBox();
             }
            } (),
          ],
        )
    ),
    );
  }

  Padding buildTicketDetails(ticket) {
    return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 2.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.sticky_note_2_outlined,
                        color: Colors.black87,
                        size: 32,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'بلیط رفت',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontSize: 24,
                              color: Colors.black87,
                            ),
                      ),
                    ],
                  ),
                  const Divider(),
                  RowGeneratorForTicket('مبدا', ticket.from),
                  const Divider(),
                  RowGeneratorForTicket('مقصد', ticket.to),
                  const Divider(),
                  RowGeneratorForTicket('تاریخ و ساعت', ticket.dateString + '  -  ' + ticket.inboundTimeString),
                  const Divider(),
                  RowGeneratorForTicket('شرکت', ticket!.company.name),
                  const Divider(),
                  RowGeneratorForTicket('نوع بلیط', ticket.transportBy),
                  const Divider(),
                  RowGeneratorForTicket('قیمت بلیط', '${ticket!.priceString} تومان'),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
  }

  Row RowGeneratorForTicket(title, value) {
    return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 20,
                          color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                ],
              );
  }
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
