import 'package:flutter/material.dart';
import 'package:unlimited_heap_ap401/models/passenger.dart';

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
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                              () {
                            if (widget.tripData.transportBy.contains('پرواز')) {
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
    color: Theme.of(context).colorScheme.primary
                        ),
                        const SizedBox(width: 4),
                        Text('تایید اطلاعات',
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
                          Icons.payment_rounded,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        const SizedBox(width: 4),
                        const Text('پرداخت',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.grey)),
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
                  ],
                ),
              ),
              buildTicketDetails(widget.tripData.departTicket, 'بلیط رفت'),
              () {
                if (widget.tripData.type == 'رفت و برگشت') {
                  return buildTicketDetails(
                      widget.tripData.returnTicket, 'بلیط برگشت');
                } else {
                  return const SizedBox();
                }
              }(),
              buildPassengersDetails(widget.tripData.passengerList),
              const SizedBox(height: 64),
            ],
          )),
    );
  }

  Padding buildTicketDetails(ticket, ticketTitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
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
                  ticketTitle,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 24,
                        color: Colors.black87,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            rowGeneratorForTicket('مبدا', ticket.from),
            const Divider(),
            rowGeneratorForTicket('مقصد', ticket.to),
            const Divider(),
            rowGeneratorForTicket('تاریخ و ساعت',
                ticket.dateString + '  -  ' + ticket.inboundTimeString),
            const Divider(),
            rowGeneratorForTicket('شرکت', ticket!.company.name),
            const Divider(),
            rowGeneratorForTicket('نوع بلیط', ticket.transportBy),
            const Divider(),
            rowGeneratorForTicket('قیمت بلیط', '${ticket!.priceString} تومان'),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Row rowGeneratorForTicket(title, value) {
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

  buildPassengersDetails(List<Passenger> passengerList) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
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
                  Icons.person,
                  color: Colors.black87,
                  size: 32,
                ),
                const SizedBox(width: 8),
                Text(
                  'مسافران',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 24,
                        color: Colors.black87,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: passengerList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    rowGeneratorForPassenger(
                        'نام', passengerList[index].firstName),
                    const Divider(),
                    rowGeneratorForPassenger(
                        'نام خانوادگی', passengerList[index].lastName),
                    const Divider(),
                    rowGeneratorForPassenger('کد ملی', passengerList[index].id),
                    const Divider(),
                    rowGeneratorForPassenger(
                        'جنسیت', passengerList[index].gender),
                    () {
                     if (index != passengerList.length - 1) {
                        return const Divider(
                          height: 48,
                          thickness: 2,
                        );
                      } else {
                        return const SizedBox();
                      }
                    } (),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Row rowGeneratorForPassenger(String title, String? value) {
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
          value!,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: Colors.black54,
              ),
        ),
      ],
    );
  }
}
