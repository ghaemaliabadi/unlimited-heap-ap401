import 'dart:convert' show utf8;
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:tab_container/tab_container.dart';
import 'EditUserInfoPage.dart';
import '../models/company.dart';
import '../models/transaction.dart';
import '../models/userinfo.dart';
import '../models/tripsTaken.dart';
import '../models/transfer.dart';
import 'ProjectMainPage.dart';

// ignore: must_be_immutable
class AccountPage extends StatefulWidget {
  User? user;

  AccountPage(
      {Key? key,
        this.user,
      })
      : super(key: key);

  static const String ip = "192.168.215.134";
  static const int port = 1234;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

// User sampleUser = User(
//   username: 'sample_username',
//   password: 'Aa@010101',
//   email: 'sample@sample.com',
//   balance: '۰',
//   phoneNumber: '۰۹۱۲۳۴۵۶۷۸۹',
//   birthDate: Jalali(1370, 1, 1),
//   firstName: 'محمد',
//   lastName: 'محمدی',
//   nationalID: '0920513',
// );

List<TakenTrip> takenTrips = [
  TakenTrip(
    id: '12564',
    transportType: 'اتوبوس',
    date: Jalali(1399, 1, 1, 12, 30),
    price: '200000',
    status: Status.done,
    company: Company('زاگرس'),
    reservationNumber: '2803',
    from: 'تهران',
    to: 'اصفهان',
  ),
  TakenTrip(
    id: '25646',
    transportType: 'قطار',
    date: Jalali(1399, 1, 2, 8, 30),
    price: '500000',
    status: Status.canceled,
    company: Company('رجا'),
    reservationNumber: '1458',
    from: 'مشهد',
    to: 'تهران',
  ),
  TakenTrip(
    id: '13548',
    transportType: 'پرواز داخلی',
    date: Jalali(1399, 1, 3, 15, 30),
    price: '1590000',
    status: Status.done,
    company: Company('ماهان'),
    reservationNumber: '1234',
    from: 'تهران',
    to: 'مشهد',
  ),
  TakenTrip(
    id: '84686',
    transportType: 'پرواز خارجی',
    date: Jalali(1399, 1, 4, 10, 30),
    price: '30000000',
    status: Status.done,
    company: Company('ایران ایر'),
    reservationNumber: '7894',
    from: 'تهران',
    to: 'لندن',
  ),
  TakenTrip(
    id: '12546',
    transportType: 'قطار',
    date: Jalali(1399, 1, 5, 12, 30),
    price: '400000',
    status: Status.done,
    company: Company('رجا'),
    reservationNumber: '1458',
    from: 'تهران',
    to: 'مشهد',
  ),
  TakenTrip(
    id: '75896',
    transportType: 'پرواز داخلی',
    date: Jalali(1399, 1, 6, 8, 30),
    price: '1200000',
    status: Status.ongoing,
    company: Company('ماهان'),
    reservationNumber: '1234',
    from: 'تهران',
    to: 'مشهد',
  ),
  TakenTrip(
    id: '13546',
    transportType: 'اتوبوس',
    date: Jalali(1399, 1, 7, 15, 30),
    price: '350000',
    status: Status.done,
    company: Company('زاگرس'),
    reservationNumber: '2803',
    from: 'تهران',
    to: 'اصفهان',
  ),
  TakenTrip(
    id: '91536',
    transportType: 'قطار',
    date: Jalali(1399, 1, 8, 10, 30),
    price: '600000',
    status: Status.canceled,
    company: Company('رجا'),
    reservationNumber: '1458',
    from: 'مشهد',
    to: 'تهران',
  ),
  TakenTrip(
    id: '14864',
    transportType: 'قطار',
    date: Jalali(1399, 1, 9, 12, 30),
    price: '700000',
    status: Status.done,
    company: Company('رجا'),
    reservationNumber: '1458',
    from: 'تهران',
    to: 'مشهد',
  ),
];

// List<Transaction> transactions = [
//   Transaction(
//     date: Jalali(1399, 1, 1),
//     amount: '2000000',
//     type: TransactionType.increase,
//     description: 'افزایش موجودی',
//   ),
//   Transaction(
//     date: Jalali(1399, 1, 1),
//     amount: '2000000',
//     type: TransactionType.decrease,
//     description: 'خرید بلیط',
//   ),
//   Transaction(
//     date: Jalali(1399, 1, 3),
//     amount: '15900000',
//     type: TransactionType.increase,
//     description: 'افزایش موجودی',
//   ),
//   Transaction(
//     date: Jalali(1399, 1, 3),
//     amount: '15900000',
//     type: TransactionType.decrease,
//     description: 'خرید بلیط',
//   ),
// ];

// List<Transfer> transfers = [
//   Transfer(
//       date: Jalali(1400, 1, 1),
//       amount: "1000000",
//       id: "123456789",
//   ),
//   Transfer(
//       date: Jalali(1400, 1, 2),
//       amount: "2000000",
//       id: "654886321",
//   ),
//   Transfer(
//       date: Jalali(1400, 1, 3),
//       amount: "3000000",
//       id: "987654321",
//   ),
// ];

List<Transaction> transactions = [];
List<Transfer> transfers = [];
String startingDateLabel = 'از تاریخ';
String endingDateLabel = 'تا تاریخ';
Jalali startingDateSearch = Jalali(1380, 1, 1);
Jalali endingDateSearch = Jalali.now();
String idSearch = '';

class _AccountPageState extends State<AccountPage> {

  final _addBalanceController = TextEditingController();
  final _withdrawBalanceController = TextEditingController();
  final _transferFormKey = GlobalKey<FormState>();
  final _balanceFormKey = GlobalKey<FormState>();
  late TabContainerController _tabController = TabContainerController(length: 2);

  List<TakenTrip> _foundTrips = [];

  @override
  void dispose() {
    _addBalanceController.dispose();
    _withdrawBalanceController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabContainerController(length: 2);
    _tabController.jumpTo(1);
    _foundTrips = takenTrips;
    _getTransactions(widget.user!.username);
    _getTransfers(widget.user!.username);
    super.initState();
  }

  void _runIdSearch(String enteredID) {
    setState(() {
      if (_foundTrips.length < takenTrips.length) {
        _foundTrips = takenTrips.where((trip) => trip.id.startsWith(enteredID)
            && trip.date.compareTo(startingDateSearch) >= 0
            && trip.date.compareTo(endingDateSearch) <= 0).toList();
      } else {
        _foundTrips = takenTrips.where((trip) => trip.id.startsWith(enteredID)).toList();
      }
    });
  }

  void _runDateSearch(Jalali startingDate, Jalali endingDate) {
    setState(() {
      if (_foundTrips.length < takenTrips.length) {
        _foundTrips = takenTrips.where((trip) =>
        trip.id.startsWith(idSearch)
            && trip.date.compareTo(startingDateSearch) >= 0
            && trip.date.compareTo(endingDateSearch) <= 0).toList();
      } else {
        _foundTrips =
            takenTrips.where((trip) => trip.id.startsWith(idSearch)).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var pageHeight = MediaQuery.of(context).size.height;
    var pageWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            elevation: 1.5,
            bottom: TabBar(
              indicatorColor: Theme.of(context).colorScheme.primary,
              splashFactory: NoSplash.splashFactory,
              tabs: [
                Tab(
                  icon: const Icon(Icons.person),
                  child: Text(
                    'حساب کاربری',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Tab(
                  icon: const Icon(Icons.credit_card),
                  child: Text(
                    'تراکنش‌ها',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Tab(
                  icon: const Icon(Icons.luggage),
                  child: Text(
                    'سفرها',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          )
        ),
        body: TabBarView(
          children: [
            // User info
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    color: Colors.transparent,
                    child: const CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/images/user.png'),
                    ),
                  ),
                  Text(
                    widget.user!.username,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Divider(
                    height: 20.0,
                    color: Theme.of(context).colorScheme.primary,
                    thickness: 1.5,
                  ),
                  Card(
                    margin: const EdgeInsets.all(10.0),
                    elevation: 2.5,
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10.0),
                      height: 140.0,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.person_pin),
                              const SizedBox(width: 5.0,),
                              Text(
                                'اطلاعات حساب کاربری',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.email, size: 16.0,),
                              const SizedBox(width: 5.0,),
                              Text(
                                'ایمیل',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(width: 50.0,),
                              Text(
                                widget.user!.email,
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                              const SizedBox(width: 30.0,),
                              InkWell(
                                onTap: () {
                                  showDialogToEditEmail(context, widget.user);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'ویرایش',
                                      style: Theme.of(context).textTheme.labelMedium,
                                    ),
                                    const Icon(
                                      Icons.edit_rounded,
                                      size: 16.0,
                                      color: Colors.blueAccent,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.money, size: 16.0,),
                              const SizedBox(width: 5.0,),
                              Text(
                                'موجودی حساب',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              SizedBox(width: pageWidth * 0.05,),
                              Text(
                                '${widget.user!.getBalance()} ریال',
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                              const SizedBox(width: 30.0),
                              const GoToTransactionsTab(),
                            ],
                          )
                        ],
                      ),
                    )
                  ),
                  Card(
                    margin: const EdgeInsets.all(10.0),
                    elevation: 2.5,
                    child: Container(
                      alignment: Alignment.center,
                      padding : const EdgeInsets.all(10.0),
                      height: 210.0,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.person_sharp),
                              const SizedBox(width: 5.0,),
                              Text(
                                'اطلاعات شخصی',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(width: 80.0,),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => EditUserInfoPage(
                                        user: widget.user,
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'ویرایش اطلاعات',
                                      style: Theme.of(context).textTheme.labelMedium,
                                    ),
                                    const Icon(
                                      Icons.edit_rounded,
                                      size: 16.0,
                                      color: Colors.blueAccent,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0,),
                          buildRowForUserInfo(context, 'نام و نام خانوادگی',
                              widget.user!.getFullName()),
                          const SizedBox(height: 20.0,),
                          buildRowForUserInfo(context, 'کد ملی',
                              (widget.user!.getNationalID())),
                          const SizedBox(height: 20.0,),
                          buildRowForUserInfo(context, 'شماره تماس',
                              (widget.user!.getPhoneNumber())),
                          const SizedBox(height: 20.0,),
                          buildRowForUserInfo(context, 'تاریخ تولد',
                              (widget.user!.getBirthDateString())),
                        ]
                      ),
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: const BorderSide(
                                  width: 2.0,
                                  color: Colors.redAccent,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.logout,
                                  color: Colors.redAccent,
                                ),
                                const SizedBox(width: 5.0,),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => ProjectMainPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'خروج از حساب کاربری',
                                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 14.0),
                                  ),
                                )
                              ],
                            )
                        ),
                      ),
                      const SizedBox(width: 10.0,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(
                              width: 2.0,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )
                          ),
                          child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.key,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 5.0,),
                              TextButton(
                                onPressed: () => showDialogToEditPassword(context, widget.user),
                                child: Text(
                                  'ویرایش رمز عبور',
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                              )
                            ],
                          )
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Transactions Tab
            InkWell(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(10.0),
                      elevation: 2.5,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10.0),
                        height: pageHeight * 0.38,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.credit_score),
                                const SizedBox(width: 5.0,),
                                Text(
                                  'موجودی حساب کاربری',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                            const SizedBox(height: 15.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 5.0,),
                                Text(
                                  'موجودی حساب',
                                  style: Theme.of(context).textTheme.headlineLarge,
                                ),
                                const SizedBox(width: 50.0,),
                                Text(
                                  '${widget.user!.getBalance()} ریال',
                                  style: Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                            ),
                            Divider(
                              height: 30.0,
                              color: Theme.of(context).colorScheme.secondary,
                              thickness: 1.5,
                              indent: 30.0,
                              endIndent: 30.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.attach_money),
                                const SizedBox(width: 5.0,),
                                Text(
                                  'افزایش موجودی',
                                  style: Theme.of(context).textTheme.displaySmall,
                                )
                              ],
                            ),
                            const SizedBox(height: 15.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 5.0),
                                    SizedBox(
                                      width: pageWidth * 0.5,
                                      height: pageHeight * 0.06,
                                      child: Form(
                                        key: _balanceFormKey,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'لطفا مبلغ مورد نظر را وارد کنید.';
                                            }
                                            return null;
                                          },
                                          controller: _addBalanceController,
                                          keyboardType: TextInputType.number,
                                          style: Theme.of(context).textTheme.headlineMedium,
                                          decoration: InputDecoration(
                                            suffixText: 'ریال',
                                            labelText: 'مبلغ مورد نظر',
                                            alignLabelWithHint: true,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: pageWidth * 0.08),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_balanceFormKey.currentState!.validate()) {
                                          setState(() {
                                            widget.user!.addBalance(_addBalanceController.text);
                                            _addUserBalance(widget.user!.username,
                                                _addBalanceController.text);
                                          });
                                          FocusManager.instance.primaryFocus?.unfocus();
                                          _showSnackBar(context, 'موجودی با موفقیت افزایش یافت.', false);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: Size(pageWidth * 0.2, pageHeight * 0.05),
                                      ),
                                      child: const Text(
                                        'پرداخت',
                                      )
                                    )
                                  ],
                                )
                              ]
                            ),
                            Divider(
                              height: 30.0,
                              color: Theme.of(context).colorScheme.secondary,
                              thickness: 1.5,
                              indent: 30.0,
                              endIndent: 30.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.money_off),
                                const SizedBox(width: 5.0,),
                                Text(
                                  'انتقال موجودی به حساب بانکی',
                                  style: Theme.of(context).textTheme.displaySmall,
                                )
                              ],
                            ),
                            const SizedBox(height: 15.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 5.0),
                                    SizedBox(
                                      width: pageWidth * 0.5,
                                      height: pageHeight * 0.06,
                                      child: Form(
                                        key: _transferFormKey,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'لطفا مبلغ مورد نظر را وارد کنید.';
                                            } else if (!widget.user!.checkEnoughBalance(value)) {
                                              _withdrawBalanceController.clear();
                                              return 'موجودی حساب شما کافی نیست.';
                                            }
                                            return null;
                                          },
                                          controller: _withdrawBalanceController,
                                          keyboardType: TextInputType.number,
                                          style: Theme.of(context).textTheme.headlineMedium,
                                          decoration: InputDecoration(
                                            suffixText: 'ریال',
                                            labelText: 'مبلغ مورد نظر',
                                            alignLabelWithHint: true,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: pageWidth * 0.08),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_transferFormKey.currentState!.validate()) {
                                          setState(() {
                                            widget.user!.withdrawBalance(
                                                _withdrawBalanceController.text);
                                            _withdrawUserBalance(widget.user!.username,
                                                _withdrawBalanceController.text);
                                          });
                                          FocusManager.instance
                                              .primaryFocus?.unfocus();
                                          _showSnackBar(context,
                                              'موجودی با موفقیت به حساب بانکی شما انتقال یافت.', false);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: Size(pageWidth * 0.2, pageHeight * 0.05),
                                      ),
                                      child: const Text(
                                        'ثبت',
                                      )
                                    )
                                  ],
                                )
                              ]
                            ),
                          ],
                        ),
                      )
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: pageHeight * 0.39),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TabContainer(
                          selectedTextStyle: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Theme.of(context).colorScheme.onSurface),
                          unselectedTextStyle: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Theme.of(context).colorScheme.onSurface),
                          color: Theme.of(context).colorScheme.secondary,
                          tabDuration: const Duration(milliseconds: 300),
                          tabs: const [
                            'انتقال موجودی',
                            'تراکنش‌ها',
                          ],
                          controller: _tabController,
                          children: [
                            buildListView(context, 'تراکنش‌ها'),
                            buildListView(context, 'انتقال موجودی'),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ),
            ),
            InkWell(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(10.0),
                      elevation: 2.5,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        height: pageHeight * 0.26,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.search),
                                const SizedBox(width: 5.0,),
                                Text(
                                  'جستجوی سفارش',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ]
                            ),
                            const SizedBox(height: 5.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.info_outline),
                                const SizedBox(width: 5.0,),
                                Text(
                                  'برای جستجو در لیست سفرها پرکردن حداقل یک فیلد کافیست.',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ]
                            ),
                            const SizedBox(height: 20.0,),
                            SizedBox(
                              width: pageWidth * 0.82,
                              height: pageHeight * 0.05,
                              child: TextFormField(
                                onChanged: (value) {
                                  idSearch = value;
                                  _runIdSearch(value);
                                  // FocusManager.instance.primaryFocus?.unfocus();
                                },
                                keyboardType: TextInputType.number,
                                style: Theme.of(context).textTheme.headlineMedium,
                                decoration: InputDecoration(
                                  labelText: 'شماره سفارش',
                                  alignLabelWithHint: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                buildDatePicker(context, 'از'),
                                buildDatePicker(context, 'تا'),
                              ]
                            ),
                            const SizedBox(height: 10.0,),
                            // ElevatedButton(
                            //   onPressed: () {},
                            //   child: const Text(
                            //     'جستجو',
                            //   ),
                            // )
                          ]
                        )
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black38,
                            width: 2.0,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        height: pageHeight * 0.07,
                        // width: pageWidth * 0.9,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                          SizedBox(width: pageWidth * 0.04),
                          Expanded(child: Text('شماره سفارش', textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium)),
                          Expanded(child: Text('نوع سفارش', textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium)),
                          Expanded(child: Text('تاریخ', textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium)),
                          // Expanded(child: Text('مبلغ کل(تومان)', textAlign: TextAlign.center,
                          //     style: Theme.of(context).textTheme.headlineMedium)),
                          Expanded(child: Text('وضعیت', textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium)),
                          const Expanded(child: Text('')),
                          ],
                        )
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: _foundTrips.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: ExpansionTile(
                              title: Container(
                                padding: const EdgeInsets.all(10.0),
                                // decoration: const BoxDecoration(
                                //   border: Border(
                                //     // bottom: BorderSide(color: Colors.black26,),
                                //     // right: BorderSide(color: Colors.black26,),
                                //     // left: BorderSide(color: Colors.black26,),
                                //   ),
                                // ),
                                height: pageHeight * 0.08,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(child: Text(_foundTrips[index].getID(),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.headlineMedium)),
                                    Expanded(child: Text(_foundTrips[index].transportType,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.headlineMedium)),
                                    Expanded(child: Text(_foundTrips[index].getDate(),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.headlineMedium)),
                                    // Expanded(child: Text(_foundTrips[index].getPrice(),
                                    //     textAlign: TextAlign.center,
                                    //     style: Theme.of(context).textTheme.headlineMedium)),
                                    Expanded(child: Text(_foundTrips[index].getStatus(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        )
                                      )
                                    ),
                                    // Expanded(
                                    //   child: InkWell(
                                    //     splashFactory: NoSplash.splashFactory,
                                    //     onTap: () {},
                                    //     child: const Row(
                                    //       mainAxisAlignment: MainAxisAlignment.center,
                                    //       children: [
                                    //         Text(
                                    //           'مشاهده',
                                    //           textAlign: TextAlign.center,
                                    //           style: TextStyle(
                                    //             fontSize: 16.0,
                                    //             fontWeight: FontWeight.w600,
                                    //             color: Colors.blueAccent,
                                    //           ),
                                    //         ),
                                    //         Icon(
                                    //           Icons.keyboard_arrow_down,
                                    //           size: 16.0,
                                    //           color: Colors.blueAccent,
                                    //         )
                                    //       ],
                                    //     )
                                    //   )
                                    // )
                                  ],
                                ),
                              ),
                              children: [buildExpandedWidget(context, index)],
                            )
                          );
                        }
                      ),
                    ),
                    SizedBox(height: pageHeight * 0.01,)
                  ]
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getTransactions(String username) async {
    String response = "false";
    await Socket.connect(AccountPage.ip, AccountPage.port).then((serverSocket) {
      print("Connected!");
      serverSocket.write("getTransactions-$username*");
      serverSocket.flush();
      print("Sent data!");
      serverSocket.listen((socket) {
        response = utf8.decode(socket);
        transactions.clear();
        List<String> temp = response.split("*");
        for (String t in temp) {
          print(t);
          String date = t.split("-")[1];
          transactions.add(
            Transaction(
              date: Jalali(int.parse(date.split("/")[0]),
                  int.parse(date.split("/")[1]),
                  int.parse(date.split("/")[2])
              ),
              amount: t.split("-")[2],
              type: (t.split("-")[3] == "increase"
                  ? TransactionType.increase
                  : TransactionType.decrease
              ),
              description: (t.split("-")[3] == "increase"
                  ? "افزایش موجودی"
                  : "خرید بلیط"
                ),
            )
          );
        }
      });
    }
    );
    return Future.delayed(const Duration(milliseconds: 100), () => response);
  }

  Future<String> _getTransfers(String username) async {
    String response = "false";
    await Socket.connect(AccountPage.ip, AccountPage.port).then((serverSocket) {
      print("Connected!");
      serverSocket.write("getTransfers-$username*");
      serverSocket.flush();
      print("Sent data!");
      serverSocket.listen((socket) {
        response = utf8.decode(socket);
        transfers.clear();
        List<String> temp = response.split("*");
        for (String t in temp) {
          print(t);
          String date = t.split("-")[1];
          transfers.add(
            Transfer(
            date: Jalali(int.parse(date.split("/")[0]),
                int.parse(date.split("/")[1]),
                int.parse(date.split("/")[2])
            ),
            amount: t.split("-")[2],
            id: t.split("-")[3],
          )
        );
        }
      });
    }
    );
    return Future.delayed(const Duration(milliseconds: 100), () => response);
  }

  Future<String> _addUserBalance(String username, String amount) async {
    String response = "false";
    await Socket.connect(EditUserInfoPage.ip, EditUserInfoPage.port).then((serverSocket) {
      print("Connected!");
      serverSocket.write("addTransaction-$username-${Jalali.now().year}/"
          "${Jalali.now().month}/${Jalali.now().day}-$amount-increase*");
      serverSocket.flush();
      print("Sent data!");
      serverSocket.listen((socket) {
        response = utf8.decode(socket);
        setState(() {
          _getTransactions(username);
        });
        print(response);
      });
    }
    );
    return Future.delayed(const Duration(milliseconds: 100), () => response);
  }

  String _idGenerator() {
    // return a random 9 digit number
    return (Random().nextInt(900000000) + 100000000).toString();
  }

  Future<String> _withdrawUserBalance(String username, String amount) async {
    String response = "false";
    await Socket.connect(EditUserInfoPage.ip, EditUserInfoPage.port).then((serverSocket) {
      print("Connected!");
      String id = _idGenerator();
      serverSocket.write("addTransfer-$username-${Jalali.now().year}/"
          "${Jalali.now().month}/${Jalali.now().day}-$amount-$id*");
      serverSocket.flush();
      print("Sent data!");
      serverSocket.listen((socket) {
        response = utf8.decode(socket);
        setState(() {
          _getTransfers(username);
        });
        print(response);
      });
    }
    );
    return Future.delayed(const Duration(milliseconds: 100), () => response);
  }

  Column buildExpandedWidget(BuildContext context, int index) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: Text('شماره رزرو', textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium)),
            Expanded(child: Text('شرکت هواپیمایی', textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium)),
            Expanded(child: Text('مسیر', textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium)),
            Expanded(child: Text('ساعت حرکت', textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium)),
          ],
        ),
        const Divider(
          height: 5.0,
          thickness: 1.0,
          color: Colors.black54,
          indent: 10.0,
          endIndent: 10.0,
        ),
        SizedBox(
          height: 45.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(child: Text(_foundTrips[index].getReservationNumber(), textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium)),
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15.0,
                      // backgroundColor: Colors.white,
                      backgroundImage: AssetImage(_foundTrips[index].getCompany().logo??"assets/images/mahan.png"),
                    ),
                    const SizedBox(width: 5.0,),
                    Text(
                        _foundTrips[index].getCompany().name,
                        textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium
                    ),
                  ],
                )
              ),
              Expanded(child: Text(_foundTrips[index].getRoute(), textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium)),
              Expanded(child: Text(_foundTrips[index].getHour(), textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium)),
            ],
          ),
        ),
      ],
    );
  }

  GestureDetector buildDatePicker(BuildContext context, String flag) {
    return GestureDetector(
      onTap: () async {
        var pickedDate = await showPersianDatePicker(
          context: context,
          initialDate: Jalali.now(),
          firstDate: (
              flag.compareTo('از') == 0
              ? Jalali(1380, 1, 1)
              : startingDateSearch
          ),
          lastDate: Jalali.now(),
        );
        if (flag.compareTo('از') == 0) {
          startingDateSearch = pickedDate!;
        } else {
          endingDateSearch = pickedDate!;
        }
        setState(() {
          if (flag.compareTo('از') == 0) {
            startingDateLabel = convertEnToFa(
                "${startingDateSearch.formatter.dd} ${startingDateSearch.formatter.mN} ${startingDateSearch.formatter.yy}");
          } else {
            endingDateLabel = convertEnToFa(
                "${endingDateSearch.formatter.dd} ${endingDateSearch.formatter.mN} ${endingDateSearch.formatter.yy}");
          }
          FocusManager.instance.primaryFocus?.unfocus();
          _runDateSearch(startingDateSearch, endingDateSearch);
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 50.0,
        padding: const EdgeInsets.only(left: 10.0, right: 15.0),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              color: Colors.black45,
            ),
            const SizedBox(width: 5.0),
            Text(
              (flag.compareTo('از') == 0)
                  ? startingDateLabel
                  : endingDateLabel,
              style: Theme.of(context).textTheme.headlineMedium,
            )
          ],
        ),
      ),
    );
  }

  Container buildListView(BuildContext context, String title) {
    var pageHeight = MediaQuery.of(context).size.height;
    late var list;
    bool flag = true;

    if (title.compareTo('انتقال موجودی') == 0) {
      list = transactions;
    } else {
      list = transfers;
      flag = false;
    }
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black38,
                width: 2.0,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
            ),
            padding: const EdgeInsets.all(5.0),
            height: pageHeight * 0.06,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: Text('تاریخ', textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium)),
                Expanded(child: Text('مبلغ(ریال)', textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium)),
                () {
                  if (flag) {
                    return Expanded(child: Text('نوع تراکنش', textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium));
                  }
                  return Expanded(child: Text('کد رهگیری', textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium));
                }(),
                () {
                  if (flag) {
                    return Expanded(child: Text('توضیحات', textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium));
                  }
                  return const SizedBox(width: 0.0);
                }(),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.black26,),
                      right: BorderSide(color: Colors.black26,),
                      left: BorderSide(color: Colors.black26,),
                    ),
                  ),
                  height: pageHeight * 0.07,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(child: Text(list[index].getDate(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium)),
                      Expanded(child: Text(list[index].getAmount(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium)),
                      () {
                        if (flag) {
                          return Expanded(child: Text(list[index].getType(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium));
                        }
                          return Expanded(child: Text(list[index].getID(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium));
                      }(),
                      () {
                        if (flag) {
                          return Expanded(child: Text(list[index].getDescription(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium));
                        }
                        return const SizedBox(width: 0.0);
                      }(),
                    ],
                  )
                );
              }
            ),
          ),
          // SizedBox(height: 15.0,)
        ],
      ),
    );
  }
}

Row buildRowForUserInfo(BuildContext context, String title, String? value) {
  return Row(
    children: [
      const SizedBox(width: 5.0,),
      Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      const SizedBox(width: 50.0,),
      Text(
        value!,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    ],
  );
}

Future<dynamic> showDialogToEditEmail(BuildContext context, User? user) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialogToEditEmail(user: user);
    },
  );
}
// ignore: must_be_immutable
class CustomAlertDialogToEditEmail extends StatefulWidget {
  User? user;

   CustomAlertDialogToEditEmail(
      {Key? key,
        this.user,
      })
      : super(key: key);

  final String emailRegex =
      "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}"
      "[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$";

  @override
  State<CustomAlertDialogToEditEmail> createState() => _CustomAlertDialogToEditEmailState();
}

class _CustomAlertDialogToEditEmailState extends State<CustomAlertDialogToEditEmail> {

  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: const Text('ویرایش آدرس ایمیل'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          validator: (value) {
            RegExp regExp = RegExp(widget.emailRegex);
            if (value == null || value.isEmpty) {
              return 'لطفا ایمیل را وارد کنید.';
            } else if (!regExp.hasMatch(value)) {
              return 'ایمیل واردشده معتبر نیست.';
            }
            return null;
          },
          style: Theme.of(context).textTheme.headlineMedium,
          showCursor: true,
          decoration: const InputDecoration(
            alignLabelWithHint: true,
            labelText: 'ایمیل جدید',
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              // widget.user?.setEmail(_controller.text);
              String serverResponse = await _checkEmailUpdate(widget.user!.username, _controller.text);
              print(serverResponse);
              if (context.mounted) {
                if (serverResponse == 'true') {
                  setState(() {
                    widget.user?.setEmail(_controller.text);
                  });
                  _showSnackBar(context, 'ایمیل با موفقیت ویرایش شد.', false);
                  Navigator.of(context).pop();
                } else {
                  _showSnackBar(context, 'ایمیل وارد شده تکراری است.', true);
                  Navigator.of(context).pop();
                }
              }
            }
          },
          child: const Text('تایید'),
        ),
      ],
    );
  }
}

Future<String> _checkEmailUpdate(String username, String email) async {
  String response = "false";
  await Socket.connect(AccountPage.ip, AccountPage.port).then((serverSocket) {
    print("Connected!");
    serverSocket.write("edit-email-$username-$email*");
    serverSocket.flush();
    print("Sent data!");
    serverSocket.listen((socket) {
      response = utf8.decode(socket);
      print(response);
    });
  }
  );
  return Future.delayed(const Duration(milliseconds: 100), () => response);
}

Future<dynamic> showDialogToEditPassword(BuildContext context, User? user) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomAlertDialogToEditPassword(user: user);
    },
  );
}
// ignore: must_be_immutable
class CustomAlertDialogToEditPassword extends StatefulWidget {
  User? user;

   CustomAlertDialogToEditPassword(
      {Key? key,
        this.user,
      })
      : super(key: key);

  @override
  State<CustomAlertDialogToEditPassword> createState() => _CustomAlertDialogToEditPasswordState();
}

class _CustomAlertDialogToEditPasswordState extends State<CustomAlertDialogToEditPassword> {

  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  bool visibleCurrentPassword = false;
  bool visibleNewPassword = false;
  bool visibleConfirmNewPassword = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: const Text('ویرایش رمز عبور'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'لطفا رمز عبور فعلی را وارد کنید.';
                  } else if (value != widget.user!.password) {
                    return 'رمز عبور فعلی اشتباه است.';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.headlineMedium,
                obscureText: visibleCurrentPassword,
                showCursor: true,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'رمز عبور فعلی',
                  suffixIcon: IconButton(
                    iconSize: 16.0,
                    alignment: Alignment.bottomLeft,
                    icon: Icon(visibleCurrentPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        visibleCurrentPassword = !visibleCurrentPassword;
                      });
                    },
                  ),
                ),
              ),
              TextFormField(
                controller: _controller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'لطفا رمز عبور را وارد کنید.';
                  } else if (value.length < 8) {
                    return 'رمز عبور باید حداقل ۸ کاراکتر باشد.';
                  } else if (!RegExp(
                      "(?=[A-Za-z0-9]+\$)^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{8,}).*\$")
                      .hasMatch(value)) {
                    return 'رمز عبور باید شامل حروف کوچک و بزرگ انگلیسی و اعداد باشد.';
                  } else if (!RegExp("(1|0)+").hasMatch(value) &&
                      !('a'.allMatches(value).length >= 2)) {
                    return 'رمز عبور باید شامل حداقل دو حرف a یا یک عدد در مبنای دو باشد.';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.headlineMedium,
                obscureText: visibleNewPassword,
                showCursor: true,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'رمز عبور جدید',
                  suffixIcon: IconButton(
                    iconSize: 16.0,
                    alignment: Alignment.bottomLeft,
                    icon: Icon(visibleNewPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        visibleNewPassword = !visibleNewPassword;
                      });
                    },
                  ),
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'لطفا رمز عبور جدید را تکرار کنید.';
                  } else if (value.compareTo(_controller.text) != 0) {
                    return 'تکرار رمز عبور صحیح نمی‌باشد.';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.headlineMedium,
                obscureText: visibleConfirmNewPassword,
                showCursor: true,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'تکرار رمز عبور جدید',
                  suffixIcon: IconButton(
                    iconSize: 16.0,
                    alignment: Alignment.bottomLeft,
                    icon: Icon(visibleConfirmNewPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        visibleConfirmNewPassword = !visibleConfirmNewPassword;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                String serverResponse = await _checkPasswordUpdate(widget.user!.username, _controller.text);
                print(serverResponse);
                if (context.mounted) {
                  if (serverResponse == 'true') {
                    setState(() {
                      widget.user?.password = _controller.text;
                    });
                    _showSnackBar(context, 'رمز عبور با موفقیت ویرایش شد.', false);
                    Navigator.of(context).pop();
                  } else {
                    _showSnackBar(context, 'لطفا دوباره تلاش کنید.', true);
                    Navigator.of(context).pop();
                  }
                }
              }
            },
            child: const Text('تایید'),
          )
        ]
    );
  }
}

Future<String> _checkPasswordUpdate(String username, String password) async {
  String response = "false";
  await Socket.connect(AccountPage.ip, AccountPage.port).then((serverSocket) {
    print("Connected!");
    serverSocket.write("edit-password-$username-$password*");
    serverSocket.flush();
    print("Sent data!");
    serverSocket.listen((socket) {
      response = utf8.decode(socket);
      print(response);
    });
  }
  );
  return Future.delayed(const Duration(milliseconds: 100), () => response);
}

class GoToTransactionsTab extends StatelessWidget {
  const GoToTransactionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        DefaultTabController.of(context).animateTo(1);
      },
      child: Text(
        'افزایش موجودی  >',
        style: Theme.of(context).textTheme.labelMedium,
        ),
      );
  }
}

void _showSnackBar(BuildContext context, String message, bool isError) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: (isError
            ? Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.red)
            : Theme.of(context).textTheme.displaySmall
        ),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ),
  );
}