import 'package:flutter/material.dart';
import 'package:unlimited_heap_ap401/models/trip.dart';

class ResultPage extends StatefulWidget {
  const ResultPage(Trip tripData, {super.key});
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.5,
        title: Text("نتایج جستجو", style: Theme.of(context).textTheme.displayMedium),
      ),
    );
  }
}