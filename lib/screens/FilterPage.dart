import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:unlimited_heap_ap401/models/trip.dart';

import '../models/sort.dart';
import 'ResultPage.dart';

// ignore: must_be_immutable
class FilterPage extends StatefulWidget {
  Trip tripData;
  String selectTicketFor;
  HashSet<String>? tags;
  HashSet<String>? companies;
  List<bool> selectedCompanies = <bool>[];
  List<bool> selectedTags = <bool>[];
  double? startValue;
  double? endValue;
  FilterPage(
      {super.key,
      required this.tripData,
      required this.selectTicketFor,
      required this.selectedCompanies,
      required this.selectedTags,
      this.startValue,
      this.endValue,
      this.tags,
      this.companies});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1.5,
          title:
              Text('فیلترها', style: Theme.of(context).textTheme.displayMedium),
        ),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Row(
                  children: [
                    Icon(Icons.access_time,
                        color: Theme.of(context).colorScheme.primary, size: 30),
                    const SizedBox(width: 10),
                    Text('زمان حرکت',
                        style: Theme.of(context).textTheme.displayLarge),
                  ],
                ),
              ),
              // range slider from 04:30 to 23:30
              RangeSlider(
                values: RangeValues(widget.startValue!, widget.endValue!),
                min: 4.5,
                max: 23.5,
                divisions: 19,
                labels: RangeLabels(convertIntToTimeStr(widget.startValue!.toDouble()),
                    convertIntToTimeStr(widget.endValue!.toDouble())),
                onChanged: (RangeValues values) {
                  setState(() {
                    widget.startValue = values.start;
                    widget.endValue = values.end;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  // center
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(convertIntToTimeStr(widget.startValue!.toDouble()),
                        style: Theme.of(context).textTheme.displaySmall),
                    const SizedBox(width: 10),
                    const Icon(Icons.arrow_forward, size: 24),
                    const SizedBox(width: 10),
                    Text(convertIntToTimeStr(widget.endValue!.toDouble()),
                        style: Theme.of(context).textTheme.displaySmall),
                  ],
                ),
              ),
              // print companies
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Row(
                  children: [
                    Icon(Icons.label,
                        color: Theme.of(context).colorScheme.primary, size: 30),
                    const SizedBox(width: 10),
                    Text('شرکت‌',
                        style: Theme.of(context).textTheme.displayLarge),
                  ],
                ),
              ),
              // check list of widget.companies and when user click on one of them, check or uncheck it
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.companies!.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      activeColor: Theme.of(context).colorScheme.primary,
                      title: Text(widget.companies!.elementAt(index),
                          style: Theme.of(context).textTheme.displaySmall),
                      value: widget.selectedCompanies[index],
                      onChanged: (newValue) {
                        setState(() {
                          if (widget.selectedCompanies[index] == true) {
                            widget.selectedCompanies[index] = false;
                          } else {
                            widget.selectedCompanies[index] = true;
                          }
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Row(
                  children: [
                    Icon(Icons.label,
                        color: Theme.of(context).colorScheme.primary, size: 30),
                    const SizedBox(width: 10),
                    Text('برچسب',
                        style: Theme.of(context).textTheme.displayLarge),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.tags!.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      activeColor: Theme.of(context).colorScheme.primary,
                      title: Text(widget.tags!.elementAt(index),
                          style: Theme.of(context).textTheme.displaySmall),
                      value: widget.selectedTags[index],
                      onChanged: (newValue) {
                        setState(() {
                          if (widget.selectedTags[index] == true) {
                            widget.selectedTags[index] = false;
                          } else {
                            widget.selectedTags[index] = true;
                          }
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    );
                  },
                ),
              ),
              SizedBox(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48.0,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        // navigate to result page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResultPage(
                                    tripData: widget.tripData,
                                    startValue: widget.startValue,
                                    endValue: widget.endValue,
                                    selectedCompanies: widget.selectedCompanies,
                                    selectedTags: widget.selectedTags,
                                    sort: Sort(),
                                    selectTicketFor: widget.selectTicketFor,
                                  )),
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.primary,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'اعمال فیلتر',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

String convertIntToTimeStr(double time) {
  var intPart = time ~/ 1;
  var decimalPart = time - intPart;
  var hour = intPart;
  var minute = (decimalPart * 60).round();
  return '${hour < 10 ? '0' : ''}$hour:${minute < 10 ? '0' : ''}$minute';
}
