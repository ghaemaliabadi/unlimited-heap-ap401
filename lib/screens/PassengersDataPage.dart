import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/sort.dart';
import '../models/trip.dart';

// ignore: must_be_immutable
class PassengersDataPage extends StatefulWidget {
  Trip tripData;

  PassengersDataPage({super.key, required this.tripData});

  @override
  State<PassengersDataPage> createState() => _PassengersDataPageState();
}

var numberFormat = NumberFormat("###,###", "en_US");

class _PassengersDataPageState extends State<PassengersDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('تکمیل خرید',
            style: Theme.of(context).textTheme.displayMedium),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  (){
                    if(widget.tripData.transportBy == 'هواپیما'){
                      return Icons.airplanemode_active_rounded;
                    } else if(widget.tripData.transportBy == 'اتوبوس'){
                      return Icons.directions_bus_rounded;
                    } else if(widget.tripData.transportBy == 'قطار'){
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
                  Icons.arrow_forward_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.account_box_sharp,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 4),
                // arrow icon
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const Text('مشخصات مسافران'),
                const SizedBox(width: 4),
                Icon(
                  Icons.newspaper_sharp,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 4),
                // arrow icon
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const Text('تایید اطلاعات'),
                const SizedBox(width: 4),

              ],
            ),
          ],
        ),
      ),
    );
  }
}

convertEnToFa(String txt) {
  return txt
      .replaceAll('0', '۰')
      .replaceAll('1', '۱')
      .replaceAll('2', '۲')
      .replaceAll('3', '۳')
      .replaceAll('4', '۴')
      .replaceAll('5', '۵')
      .replaceAll('6', '۶')
      .replaceAll('7', '۷')
      .replaceAll('8', '۸')
      .replaceAll('9', '۹');
}
