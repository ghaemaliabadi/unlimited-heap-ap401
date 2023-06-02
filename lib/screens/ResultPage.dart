import 'package:flutter/material.dart';
import 'package:unlimited_heap_ap401/models/trip.dart';

class ResultPage extends StatefulWidget {
  final Trip tripData;

  const ResultPage({Key? key, required this.tripData}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

@override
void initState(widget) {

}

class _ResultPageState extends State<ResultPage> {
  // trip data
  @override
  Widget build(BuildContext context) {
    // trip data
    final Trip tripData = widget.tripData;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            //replace with our own icon data.
          ),
          titleSpacing: 0,
          elevation: 4.5,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('بلیط ${tripData.transportBy} ${tripData.title}',
                      style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 2.0),
                  Text(tripData.dateString,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                          )),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  )),
              // convert icon to icon button
            ],
          ),
        ),
      ),
    );
  }
}
