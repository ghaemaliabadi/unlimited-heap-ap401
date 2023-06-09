import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// ignore: must_be_immutable
class FilterPage extends StatefulWidget {
  HashSet<String>? tags;
  HashSet<String>? companies;
  FilterPage({super.key, this.tags, this.companies});
  @override
  State<FilterPage> createState() => _FilterPageState();
}

var selectedCompanies = <bool>[];
var selectedTags = <bool>[];

class _FilterPageState extends State<FilterPage> {
  var _startValue = 4.5;
  var _endValue = 23.5;
  @override
  void initState() {
    super.initState();
    selectedCompanies = List<bool>.filled(widget.companies!.length, true);
    selectedTags = List<bool>.filled(widget.tags!.length, true);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1.5,
        title: Text('فیلترها',
            style: Theme.of(context).textTheme.displayMedium),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column (
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
              child: Row(
                children: [
                  Icon(Icons.access_time, color: Theme.of(context).colorScheme.primary, size: 30),
                  const SizedBox(width: 10),
                  Text('زمان حرکت', style: Theme.of(context).textTheme.displayLarge),
                ],
              ),
            ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                // center
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(convertIntToTimeStr(_startValue.toDouble()), style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_forward, size: 24),
                  const SizedBox(width: 10),
                  Text(convertIntToTimeStr(_endValue.toDouble()), style: Theme.of(context).textTheme.displaySmall),
                ],
              ),
            ),
            // print companies
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.label, color: Theme.of(context).colorScheme.primary, size: 30),
                  const SizedBox(width: 10),
                  Text('شرکت‌', style: Theme.of(context).textTheme.displayLarge),
                ],
              ),
            ),
            // check list of widget.companies and when user click on one of them, check or uncheck it
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder (
                shrinkWrap: true,
                itemCount: widget.companies!.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    activeColor: Theme.of(context).colorScheme.primary,
                    title: Text(widget.companies!.elementAt(index), style: Theme.of(context).textTheme.displaySmall),
                    value: selectedCompanies[index],
                    onChanged: (newValue) {
                      setState(() {
                        if (selectedCompanies[index] == true) {
                          selectedCompanies[index] = false;
                        } else {
                          selectedCompanies[index] = true;
                        }
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.label, color: Theme.of(context).colorScheme.primary, size: 30),
                    const SizedBox(width: 10),
                    Text('برچسب', style: Theme.of(context).textTheme.displayLarge),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder (
                shrinkWrap: true,
                itemCount: widget.tags!.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    activeColor: Theme.of(context).colorScheme.primary,
                    title: Text(widget.tags!.elementAt(index), style: Theme.of(context).textTheme.displaySmall),
                    value: selectedTags[index],
                    onChanged: (newValue) {
                      setState(() {
                        if (selectedTags[index] == true) {
                          selectedTags[index] = false;
                        } else {
                          selectedTags[index] = true;
                        }
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                  );
                },
              ),
            ),
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