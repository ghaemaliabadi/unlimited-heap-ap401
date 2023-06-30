import 'dart:io';
import 'package:flutter/material.dart';
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
        child: Text(
          'پرداخت با موفقیت انجام شد.',
          style: Theme.of(context).textTheme.displayLarge,
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