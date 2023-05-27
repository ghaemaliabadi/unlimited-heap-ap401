import 'package:flutter/material.dart';

class ProjectMainPage extends StatefulWidget {
  const ProjectMainPage({super.key});

  final String title = 'صفحه اصلی پروژه';

  @override
  State<ProjectMainPage> createState() => _ProjectMainPage();
}

class _ProjectMainPage extends State<ProjectMainPage> {
  late PageController _pageController = PageController();
  int activePageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    var pageWidth = MediaQuery
        .of(context)
        .size
        .width;
    var pageHeight = MediaQuery
        .of(context)
        .size
        .height;
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
            physics: const ClampingScrollPhysics(),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                width: pageWidth,
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
                      // flex: 2,
                      child: PageView(
                        controller: _pageController,
                        physics: const ClampingScrollPhysics(),
                        onPageChanged: (int i) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            activePageIndex = i;
                          });
                        },
                        children: <Widget>[
                          ConstrainedBox(
                            constraints: const BoxConstraints.expand(),
                            child: const Center(
                              child: Text("تست"),
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
                              child: Text("تست 4"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _menuBar(BuildContext context) {
    var pageWidth = MediaQuery
        .of(context)
        .size
        .width;
    // var pageHeight = MediaQuery
    //     .of(context)
    //     .size
    //     .height;
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
          width: MediaQuery
              .of(context)
              .size
              .width,
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
