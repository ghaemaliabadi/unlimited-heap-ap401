import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class ProjectMainPage extends StatefulWidget {
  const ProjectMainPage({super.key});

  final String title = 'صفحه اصلی پروژه';

  @override
  State<ProjectMainPage> createState() => _ProjectMainPage();
}
final List<String> items = [
  'تهران',
  'مشهد',
  'اصفهان',
  'شیراز',
  'گرگان',
  'کرمان',
  'تبریز',
  'بوشهر',
];
String? selectedValue;
final _formKey = GlobalKey<FormState>();
final TextEditingController textEditingController = TextEditingController();

class _ProjectMainPage extends State<ProjectMainPage> {
  late PageController _pageController = PageController();
  int activePageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    textEditingController.dispose();
    super.dispose();
  }
  final List<String> travelType = [
    'یک طرفه',
    'دو طرفه',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    // var pageWidth = MediaQuery
    //     .of(context)
    //     .size
    //     .width;
    var pageHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.title, style: Theme.of(context).textTheme.headline2),
        // remove app bar background color
        backgroundColor: Colors.transparent,
        elevation: 0.1,
        // decrease top bar height
        toolbarHeight: 2.0,
        centerTitle: true,
        titleSpacing: 0.0,
        // add back icon without leading space
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            // row for back icon
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                // move to right side
                padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  // back to previous page
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ), // Row For Back Icon
          SingleChildScrollView(
            // scroll view for page view vertical scroll
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              // width: pageWidth,
              height: pageHeight * 0.85,
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
                          if (activePageIndex != i) {
                            activePageIndex = i;
                          }
                        });
                      },
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 40),
                                  buildDropDown(context, title: 'مبدا'),
                                  const SizedBox(height: 20),
                                  buildDropDown(context, title: 'مقصد'),
                                  const SizedBox(height: 20),
                                  TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                      }
                                    },
                                    child: const Text('Submit Button'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: const Center(
                            child: Text("تست ۲"),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: const Center(
                            child: Text("تست ۳"),
                          ),
                        ),
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: const Center(
                            child: Text("تست ۴"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // ),
          )
        ],
      ),
    );
  }

  DropdownButtonFormField2<String> buildDropDown(BuildContext context,
      {required String title}) {
    return DropdownButtonFormField2(
      decoration: InputDecoration(
        //Add isDense true and zero Padding.
        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        //Add more decoration as you want here
        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
      ),
      isExpanded: true,
      hint: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ))
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'لطفا $title رو انتخاب کنید';
        }
        return null;
      },
      onChanged: (value) {
        //Do something when changing the item if you want.
      },
      onSaved: (value) {
        selectedValue = value.toString();
      },
      buttonStyleData: const ButtonStyleData(
        height: 60,
        padding: EdgeInsets.only(left: 20, right: 10),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 30,
      ),
      dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          maxHeight: 200,
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          )),
    );
  }

  Widget _menuBar(BuildContext context) {
    var pageWidth = MediaQuery.of(context).size.width;
    return Container(
      width: pageWidth * 0.85,
      height: 60.0,
      decoration: const BoxDecoration(
        color: Color(0XFFE0E0E0),
        borderRadius: BorderRadius.all(Radius.circular(1000)),
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
    _pageController.animateToPage(0,
        duration: const Duration(milliseconds: 10), curve: Curves.decelerate);
  }

  void _tapOnInternationalFlight() {
    _pageController.animateToPage(1,
        duration: const Duration(milliseconds: 10), curve: Curves.decelerate);
  }

  void _tapOnTrain() {
    _pageController.animateToPage(2,
        duration: const Duration(milliseconds: 10), curve: Curves.decelerate);
  }

  void _tapOnBus() {
    _pageController.animateToPage(3,
        duration: const Duration(milliseconds: 10), curve: Curves.decelerate);
  }
}
