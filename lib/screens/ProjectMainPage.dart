import 'dart:convert' show utf8;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:tab_container/tab_container.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:unlimited_heap_ap401/screens/LoginPage.dart';
import 'package:unlimited_heap_ap401/screens/SellerPage.dart';
import '../models/sort.dart';
import '../models/trip.dart';
import '../models/userinfo.dart';
import '../theme/MainTheme.dart';
import 'AccountPage.dart';
import 'ResultPage.dart';

// ignore: must_be_immutable
class ProjectMainPage extends StatefulWidget {
  User? user;

  ProjectMainPage({
    Key? key,
    this.user,
  }) : super(key: key);

  final String title = 'صفحه اصلی پروژه';

  @override
  State<ProjectMainPage> createState() => _ProjectMainPage();
}

List<String> items = [
  'تهران',
  'مشهد',
  'اصفهان',
  'شیراز',
  'گرگان',
  'کرمان',
  'تبریز',
  'بوشهر',
];
List<Trip> lastTrips = [];

String? selectedValue;
String? lastSelectedValue;
String? transportBy;
String? travelType;
String? selectedValueFrom;
String? selectedValueTo;
String departureTypeLabel = '';
String returnTypeLabel = '';
int adultPassengers = 1;
int childPassengers = 0;
int infantPassengers = 0;
Jalali selectedDateForDepartureType = Jalali.now();
JalaliRange selectedDateForReturnType =
    JalaliRange(start: Jalali.now(), end: Jalali.now().add(days: 1));
final TextEditingController textEditingControllerFrom = TextEditingController();
final TextEditingController textEditingControllerTo = TextEditingController();

class _ProjectMainPage extends State<ProjectMainPage> {
  late PageController _pageController = PageController();
  late TabContainerController _tabController =
      TabContainerController(length: 2);
  int activePageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _pageController = PageController();
    _tabController = TabContainerController(length: 2);
    _tabController.jumpTo(1);
    var start = Jalali.now();
    var end = Jalali.now().add(days: 1);
    departureTypeLabel = convertEnToFa(
        "${start.formatter.wN} ${start.formatter.dd} ${start.formatter.mN}");
    returnTypeLabel = convertEnToFa(
        "${end.formatter.wN} ${end.formatter.dd} ${end.formatter.mN}");
    returnTypeLabel = '$departureTypeLabel الی $returnTypeLabel';
    transportBy = 'پرواز داخلی';
    super.initState();
    _getAllOrigins(transportBy).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    // var pageHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // remove app bar background color
        backgroundColor: Colors.transparent,
        elevation: 0.1,
        // decrease top bar height
        toolbarHeight: 2.0,
        centerTitle: true,
        titleSpacing: 0.0,
        // add back icon without leading space
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 24, 20),
              child: Row(
                // row for back icon
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.account_circle,
                      color: Colors.black54,
                      size: 48,
                    ),
                    onPressed: () {
                      if (widget.user?.username == null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      } else {
                        if (widget.user?.accountType == "seller") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SellerPage(
                                user: widget.user,
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AccountPage(
                                user: widget.user,
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'انتخاب سفر',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 28,
                          ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(
                      Icons.info,
                      color: Colors.black54,
                      size: 48,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ), // Row For Back Icon
            Column(children: [
              Container(
                height: 500,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0),
                      child: _menuBar(context),
                    ),
                    Expanded(
                      flex: 2,
                      child: PageView(
                        controller: _pageController,
                        // scroll  view for page view horizontal scroll
                        physics: const AlwaysScrollableScrollPhysics(),
                        onPageChanged: (int i) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            activePageIndex = i;
                          });
                        },
                        children: <Widget>[
                          buildConstrainedBox(context, 'پرواز داخلی'),
                          buildConstrainedBox(context, 'پرواز خارجی'),
                          buildConstrainedBox(context, 'قطار'),
                          buildConstrainedBox(context, 'اتوبوس'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // move to bottom
                color: Colors.white,
                child: () {
                  if (lastTrips.isNotEmpty) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 16, top: 16),
                              child: Row(
                                children: [
                                  Text('جستجوهای اخیر',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge),
                                  Text(
                                      " (${convertEnToFa(lastTrips.length.toString())})",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    lastTrips.clear();
                                  });
                                },
                                child: Text(
                                  'پاک کردن',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        decoration: TextDecoration.underline,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // list view
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: SizedBox(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: lastTrips.length,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Trip tripData = lastTrips[index];
                                    // transportBy = lastTrips[index].transportBy;
                                    // travelType = lastTrips[index].type;
                                    // selectedValueFrom = lastTrips[index].from;
                                    // selectedValueTo = lastTrips[index].to;
                                    // selectedDateForDepartureType =
                                    //     lastTrips[index].date!;
                                    // selectedDateForReturnType = lastTrips[index].dateRange!;
                                    // adultPassengers = lastTrips[index].passengers['adult']!;
                                    // childPassengers = lastTrips[index].passengers['child']!;
                                    // infantPassengers = lastTrips[index].passengers['infant']!;
                                    // setState(() {});
                                    tripData.departTicket = null;
                                    tripData.returnTicket = null;
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ResultPage(
                                          tripData: tripData,
                                          sort: Sort(),
                                          selectTicketFor: 'depart',
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    width: 180,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[200],
                                      border: Border.all(
                                        color: Colors.grey[400]!,
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          lastTrips[index].title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                              ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          '« ${lastTrips[index].transportBy} »',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                              ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          lastTrips[index].dateString,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }(),
              ),
            ]),
            () {
              if (lastTrips.isNotEmpty) {
                return Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * 0.25,
                );
              } else {
                return Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * 0.4,
                );
              }
            }(),
          ],
        ),
      ),
    );
  }

  ConstrainedBox buildConstrainedBox(BuildContext context, String tripType) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: TabContainer(
          selectedTextStyle: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
          unselectedTextStyle: Theme.of(context)
              .textTheme
              .displaySmall!
              .copyWith(color: Theme.of(context).colorScheme.onSurface),
          color: Theme.of(context).colorScheme.secondary,
          tabDuration: const Duration(milliseconds: 300),
          tabs: const [
            'رفت و برگشت',
            'یک طرفه',
          ],
          controller: _tabController,
          children: [
            buildFormContainer(context, 'رفت و برگشت', tripType),
            buildFormContainer(context, 'رفت', tripType),
          ],
        ),
      ),
    );
  }

  Container buildFormContainer(BuildContext context, type, tripType) {
    var pageWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Divider(
            height: 1,
            thickness: 3,
            color: Theme.of(context).colorScheme.primary,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Row(children: [
                    Text('از مبدا:',
                        style: Theme.of(context).textTheme.displaySmall),
                    SizedBox(width: pageWidth / 2 - 45),
                    Text('به مقصد:',
                        style: Theme.of(context).textTheme.displaySmall),
                  ]),
                ),
                const SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildDropDownMenuWithSearch(
                        context, 'مبدا', textEditingControllerFrom, 'from'),
                    // button for swap from and to
                    IconButton(
                      icon: const Icon(Icons.swap_horiz_rounded),
                      onPressed: () {
                        setState(() {
                          var temp = selectedValueFrom;
                          selectedValueFrom = selectedValueTo;
                          selectedValueTo = temp;
                        });
                      },
                    ),
                    buildDropDownMenuWithSearch(
                        context, 'مقصد', textEditingControllerTo, 'to'),
                  ],
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Row(children: [
                    () {
                      return Text('تاریخ $type:',
                          style: Theme.of(context).textTheme.displaySmall);
                    }(),
                  ]),
                ),
                const SizedBox(height: 5.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    () {
                      if (type == 'رفت و برگشت') {
                        return buildDatePicker(context, 'تاریخ رفت و برگشت');
                      } else {
                        return buildDatePicker(context, 'تاریخ سفر');
                      }
                    }(),
                  ],
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Row(children: [
                    Text('تعداد مسافران:',
                        style: Theme.of(context).textTheme.displaySmall),
                  ]),
                ),
                const SizedBox(height: 5.0),
                buildPassengerSelect(context),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    checkInputsAndNavigateToResult(context);
                  },
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(const Size(200.0, 50.0)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1000.0),
                      ),
                    ),
                  ),
                  child: Text('جستجوی $tripType',
                      style: Theme.of(context).textTheme.displayMedium),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector buildPassengerSelect(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showModalBottomSheet(
          context: context,
          builder: (context) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setModalState) {
              return SizedBox(
                height: 300,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Text('مسافران',
                              style: Theme.of(context).textTheme.displayLarge),
                        ],
                      ),
                    ),
                    buildPassengerCountRow(
                        context, setModalState, 'بزرگسال', '(۱۲ سال به بالا)'),
                    buildPassengerCountRow(
                        context, setModalState, 'کودک', '(۲ تا ۱۲ سال)'),
                    buildPassengerCountRow(
                        context, setModalState, 'نوزاد', '(۱۰ روز تا ۲ سال)'),
                    ElevatedButton(
                      onPressed: () {
                        checkInputsAndNavigateToResult(context);
                      },
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(100.0, 40.0)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1000.0),
                          ),
                        ),
                      ),
                      child: const Text('تایید و جستجو'),
                    ),
                  ],
                ),
              );
            });
          },
          shape: ShapeBorder.lerp(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            0,
          ),
        );
        setState(() {});
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        height: 50,
        padding: const EdgeInsets.only(left: 10, right: 15),
        decoration: defaultBoxDecoration(),
        child: Row(
          children: [
            const Icon(
              Icons.supervisor_account,
              color: Colors.black45,
            ),
            const SizedBox(width: 8),
            Text(
              "${getSumOfPassengers()} مسافر",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  void checkInputsAndNavigateToResult(BuildContext context) {
    // check destination and origin are not empty
    if (selectedValueFrom == null || selectedValueTo == null) {
      // show error using dialog
      showDialogError(context, 'مبدا و مقصد نباید خالی باشند.');
      return;
    }
    if (_tabController.index == 1) {
      travelType = 'یک طرفه';
    } else {
      travelType = 'رفت و برگشت';
    }
    Trip tripData = Trip(
      user: widget.user,
      transportBy: transportBy!,
      type: travelType!,
      from: selectedValueFrom!,
      to: selectedValueTo!,
      date: selectedDateForDepartureType,
      dateRange: selectedDateForReturnType,
      passengers: {
        'adult': adultPassengers,
        'child': childPassengers,
        'infant': infantPassengers,
      },
    );
    tripData.departTicket = null;
    tripData.returnTicket = null;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ResultPage(
              tripData: tripData,
              sort: Sort(),
              selectTicketFor: 'depart',
            )));
    // check if all field are tripData is not equal to another last trip
    if (lastTrips.isNotEmpty) {
      for (var lastTrip in lastTrips) {
        if (lastTrip.from == tripData.from &&
            lastTrip.to == tripData.to &&
            lastTrip.date == tripData.date &&
            lastTrip.dateRange == tripData.dateRange &&
            lastTrip.passengers['adult'] == tripData.passengers['adult'] &&
            lastTrip.passengers['child'] == tripData.passengers['child'] &&
            lastTrip.passengers['infant'] == tripData.passengers['infant'] &&
            lastTrip.transportBy == tripData.transportBy &&
            lastTrip.type == tripData.type) {
        } else {
          lastTrips.insert(0, tripData);
          setState(() {});
          break;
        }
      }
    } else {
      lastTrips.insert(0, tripData);
      setState(() {});
    }
  }

  Row buildPassengerCountRow(BuildContext context, StateSetter setModalState,
      String passengerType, String passengerTypeDescription) {
    var show = 0;
    if (passengerType == 'بزرگسال') {
      show = adultPassengers;
    }
    if (passengerType == 'کودک') {
      show = childPassengers;
    }
    if (passengerType == 'نوزاد') {
      show = infantPassengers;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Row(
            children: [
              Text(passengerType,
                  style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(width: 5),
              Text(passengerTypeDescription,
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.add_circle_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 30,
                ),
                onPressed: () {
                  setModalState(() {
                    if (adultPassengers + childPassengers + infantPassengers ==
                        9) {
                      // err
                    } else {
                      if (passengerType == 'بزرگسال') {
                        adultPassengers++;
                        show = adultPassengers;
                      }
                      if (passengerType == 'کودک') {
                        childPassengers++;
                        show = adultPassengers;
                      }
                      if (passengerType == 'نوزاد') {
                        infantPassengers++;
                        show = adultPassengers;
                        Text('$show',
                            style: Theme.of(context).textTheme.displaySmall);
                      }
                    }
                  });
                  setState(() {});
                },
              ),
              const SizedBox(width: 10),
              Text('$show', style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(width: 10),
              IconButton(
                icon: Icon(
                  Icons.remove_circle_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 30,
                ),
                onPressed: () {
                  setModalState(() {
                    if (getSumOfPassengers() != 1) {
                      if (passengerType == 'بزرگسال') {
                        if (adultPassengers > 0) adultPassengers--;
                        show = adultPassengers;
                      }
                      if (passengerType == 'کودک') {
                        if (childPassengers > 0) childPassengers--;
                        show = adultPassengers;
                      }
                      if (passengerType == 'نوزاد') {
                        if (infantPassengers > 0) infantPassengers--;
                        show = adultPassengers;
                      }
                    }
                  });
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  buildDropDownMenuWithSearch(
      BuildContext context, String title, textEditingController, type) {
    if (type == 'from') {
      selectedValue = selectedValueFrom;
    } else {
      // type == 'to'
      selectedValue = selectedValueTo;
    }
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: Colors.black45,
            ),
            const SizedBox(width: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Colors.black45,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value.toString();
            // // remove selected value from items
            items.remove(selectedValue);
            // // add selected value to the end of items
            items.add(selectedValue!);
            if (type == 'from') {
              if (selectedValueTo == selectedValue) {
                selectedValueTo = selectedValueFrom;
              }
              selectedValueFrom = selectedValue;
            } else {
              // type == 'to'
              if (selectedValueFrom == selectedValue) {
                selectedValueFrom = selectedValueTo;
              }
              selectedValueTo = selectedValue;
            }
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: MediaQuery.of(context).size.width / 2 - 50,
          padding: const EdgeInsets.only(left: 10, right: 15),
          decoration: defaultBoxDecoration(),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          padding: null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 8,
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: textEditingController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: textEditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'جستجوی $title',
                hintStyle: const TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return (item.value.toString().contains(searchValue));
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),
    );
  }

  Widget _menuBar(BuildContext context) {
    var pageWidth = MediaQuery.of(context).size.width;
    return Container(
      width: pageWidth * 0.85,
      height: 60.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(1000)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          createPageItem(context, "پرواز داخلی", 0, _tapOnDomesticFlight),
          createPageItem(context, "پرواز خارجی", 1, _tapOnInternationalFlight),
          createPageItem(context, "قطار", 2, _tapOnTrain),
          createPageItem(context, "اتوبوس", 3, _tapOnBus),
        ],
      ),
    );
  }

  Expanded createPageItem(BuildContext context, String name, int index, onTap) {
    return Expanded(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(1000)),
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: (activePageIndex == index)
              ? BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(1000)),
                )
              : null,
          child: Text(
            name,
            style: (activePageIndex == index)
                ? const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)
                : const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void _tapOnDomesticFlight() {
    int jumpTo = 0;
    jumpWithAnimationCustom(_pageController, jumpTo);
    transportBy = 'پرواز داخلی';
    _getAllOrigins(transportBy);
  }

  void _tapOnInternationalFlight() {
    int jumpTo = 1;
    jumpWithAnimationCustom(_pageController, jumpTo);
    transportBy = 'پرواز خارجی';
    _getAllOrigins(transportBy);
  }

  void _tapOnTrain() {
    int jumpTo = 2;
    jumpWithAnimationCustom(_pageController, jumpTo);
    transportBy = 'قطار';
    _getAllOrigins(transportBy);
  }

  void _tapOnBus() {
    int jumpTo = 3;
    jumpWithAnimationCustom(_pageController, jumpTo);
    transportBy = 'اتوبوس';
    _getAllOrigins(transportBy);
  }

  GestureDetector buildDatePicker(BuildContext context, String type) {
    return GestureDetector(
      onTap: () async {
        if (type == 'تاریخ رفت و برگشت') {
          var picked = await showPersianDateRangePicker(
            context: context,
            fieldStartLabelText: 'تاریخ رفت',
            fieldEndLabelText: 'تاریخ برگشت',
            initialDateRange: JalaliRange(
              start: selectedDateForReturnType.start,
              end: selectedDateForReturnType.end,
            ),
            firstDate:
                Jalali(Jalali.now().year, Jalali.now().month, Jalali.now().day),
            lastDate: Jalali(1405, 9),
          );
          selectedDateForReturnType = picked!;
          selectedDateForDepartureType = picked.start;
        } else {
          // رفت
          var picked = await showPersianDatePicker(
            context: context,
            fieldLabelText: 'تاریخ سفر',
            initialDate: selectedDateForDepartureType,
            firstDate:
                Jalali(Jalali.now().year, Jalali.now().month, Jalali.now().day),
            lastDate: Jalali(1405, 9),
          );
          selectedDateForDepartureType = picked!;
        }
        setState(() {
          // update the label
          if (type == 'تاریخ رفت و برگشت') {
            var start = selectedDateForReturnType.start;
            var end = selectedDateForReturnType.end;
            departureTypeLabel =
                "${start.formatter.wN} ${start.formatter.dd} ${start.formatter.mN}";
            returnTypeLabel =
                "${end.formatter.wN} ${end.formatter.dd} ${end.formatter.mN}";
            returnTypeLabel =
                convertEnToFa('$departureTypeLabel الی $returnTypeLabel');
          } else {
            departureTypeLabel = convertEnToFa(
                "${selectedDateForDepartureType.formatter.wN} ${selectedDateForDepartureType.formatter.dd} ${selectedDateForDepartureType.formatter.mN}");
          }
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        height: 50,
        padding: const EdgeInsets.only(left: 10, right: 15),
        decoration: defaultBoxDecoration(),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              color: Colors.black45,
            ),
            const SizedBox(width: 8),
            Text(
              (type == 'تاریخ رفت و برگشت')
                  ? returnTypeLabel
                  : departureTypeLabel,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  getSumOfPassengers() {
    return convertEnToFa(
        (adultPassengers + childPassengers + infantPassengers).toString());
  }
}

void jumpWithAnimationCustom(pageController, int jumpTo) {
  // check if page is after or before the current page -> animate to it or just jump
  if (pageController.page! - jumpTo == 1 ||
      pageController.page! - jumpTo == -1) {
    pageController.animateToPage(jumpTo,
        duration: const Duration(milliseconds: 150), curve: Curves.easeInOut);
  } else {
    // jump to page without animation
    pageController.jumpToPage(jumpTo);
  }
}

Future<dynamic> showDialogError(BuildContext context, String errorText) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: const Text('خطا'),
        content: Text(errorText, style: Theme.of(context).textTheme.bodyLarge),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('تایید'),
          ),
        ],
      );
    },
  );
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

Future<String> _getAllOrigins(transportBy) async {
  String response = "false";
  await Socket.connect(SellerPage.ip, SellerPage.port).then((serverSocket) {
    print("Connected!");
    serverSocket.write("getAllOrigins-$transportBy*");
    serverSocket.flush();
    print("Sent data!");
    serverSocket.listen((socket) {
      response = utf8.decode(socket);
      items.clear();
      for (var item in response.split('\n')) {
        if (item.isNotEmpty) {
            items.add(item);
        }
      }
    });
  });
  // return Future.delayed(const Duration(milliseconds: 200), () => response);
  return response;
}