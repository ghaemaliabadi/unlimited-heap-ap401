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

        )
      ),
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
