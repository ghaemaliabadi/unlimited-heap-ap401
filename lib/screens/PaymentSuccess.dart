import 'dart:io';
import 'package:flutter/material.dart';
import 'package:unlimited_heap_ap401/screens/ProjectMainPage.dart';
import '../models/trip.dart';
import 'dart:convert' show utf8;

// ignore: must_be_immutable
class PaymentSuccess extends StatefulWidget {
  Trip trip;
  PaymentSuccess({super.key, required this.trip});

  final String title = 'پرداخت';
  static const String ip = "127.0.0.1";
  static const int port = 1234;

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 1.5,
        title: Text(widget.title,
            style: Theme.of(context).textTheme.displayMedium),
      ),
      body: InkWell(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                            () {
                          if (widget.trip.transportBy.contains('پرواز')) {
                            return Icons.airplanemode_active_rounded;
                          } else if (widget.trip.transportBy == 'اتوبوس') {
                            return Icons.directions_bus_rounded;
                          } else if (widget.trip.transportBy == 'قطار') {
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
                          color: Theme.of(context).colorScheme.primary
                      ),
                      const SizedBox(width: 4),
                      Text('پرداخت',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 6.0,
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
              // TODO: add trip to transactions
              const SizedBox(
                height: 60.0,
              ),
              Text(
                'پرداخت با موفقیت انجام شد.',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(
                height: 50.0,
              ),
              // back to main page with user data
              SizedBox(
                height: 45.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProjectMainPage(
                        user: widget.trip.user,
                      )
                    )
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'بازگشت به صفحه اصلی',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String message, bool isError) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: (isError
            ? Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.red)
            : Theme.of(context).textTheme.displaySmall
        ),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ),
  );
}