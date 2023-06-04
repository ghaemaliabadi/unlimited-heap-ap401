import 'dart:collection';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FilterPage extends StatefulWidget {
  HashSet<String>? tags;
  HashSet<String>? companies;
  FilterPage({super.key, this.tags, this.companies});
  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  var _startValue = 4.5;
  var _endValue = 23.5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1.5,
        title: Text('فیلترها',
            style: Theme.of(context).textTheme.displayMedium),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column (
          children: [
            // range slider from 04:30 to 23:30
            RangeSlider(
              values: RangeValues(_startValue, _endValue),
              min: 4.5,
              max: 23.5,
              divisions: 19,
              labels: RangeLabels(
                  convertIntToTimeStr(_startValue.toDouble()),
                  convertIntToTimeStr(_endValue.toDouble())
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _startValue = values.start;
                  _endValue = values.end;
                });
              },
            ),
            // از ساعت تا ساعت
            Text('از ${convertIntToTimeStr(_startValue.toDouble())} تا ${convertIntToTimeStr(_endValue.toDouble())}'),
            // print companies
            Text(widget.companies.toString()),
            // print tags
            Text(widget.tags.toString()),
          ],
        ),
      )
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