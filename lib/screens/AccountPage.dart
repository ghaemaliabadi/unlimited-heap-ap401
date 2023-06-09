import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../models/userinfo.dart';
import '../models/tripsTaken.dart';

//TODO: fix sizes and paddings

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  @override
  State<AccountPage> createState() => _AccountPageState();
}

User sampleUser = User(
  username: 'sample_username',
  password: 'Aa@010101',
  email: 'sample@sample.com',
  balance: '۰',
  phoneNumber: '۰۹۱۲۳۴۵۶۷۸۹',
  birthDate: Jalali(1370, 1, 1),
  firstName: 'محمد',
  lastName: 'محمدی',
  nationalID: '0920513',
);

List<TakenTrip> takenTrips = [
  TakenTrip(
    id: '12564',
    transportType: 'اتوبوس',
    date: Jalali(1399, 1, 1),
    price: '200000',
    status: Status.done,
  ),
  TakenTrip(
    id: '25646',
    transportType: 'قطار',
    date: Jalali(1399, 1, 2),
    price: '500000',
    status: Status.canceled,
  ),
  TakenTrip(
    id: '13548',
    transportType: 'پرواز داخلی',
    date: Jalali(1399, 1, 3),
    price: '1590000',
    status: Status.done,
  ),
  TakenTrip(
    id: '84686',
    transportType: 'پرواز خارجی',
    date: Jalali(1399, 1, 4),
    price: '30000000',
    status: Status.done,
  ),
  TakenTrip(
    id: '12546',
    transportType: 'قطار',
    date: Jalali(1399, 1, 5),
    price: '400000',
    status: Status.done,
  ),
  TakenTrip(
    id: '75896',
    transportType: 'پرواز داخلی',
    date: Jalali(1399, 1, 6),
    price: '1200000',
    status: Status.ongoing,
  ),
  TakenTrip(
    id: '13546',
    transportType: 'اتوبوس',
    date: Jalali(1399, 1, 7),
    price: '350000',
    status: Status.done,
  ),
  TakenTrip(
    id: '91536',
    transportType: 'قطار',
    date: Jalali(1399, 1, 8),
    price: '600000',
    status: Status.canceled,
  ),
  TakenTrip(
    id: '14864',
    transportType: 'قطار',
    date: Jalali(1399, 1, 9),
    price: '700000',
    status: Status.done,
  ),
];

String startingDateLabel = 'از تاریخ';
String endingDateLabel = 'تا تاریخ';
Jalali startingDateSearch = Jalali.now();
Jalali endingDateSearch = Jalali.now();

class _AccountPageState extends State<AccountPage> {
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
                    sampleUser.username,
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
                                sampleUser.email,
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                              const SizedBox(width: 30.0,),
                              InkWell(
                                onTap: () {
                                  showDialogToEditEmail(context);
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
                              const SizedBox(width: 50.0,),
                              Text(
                                '${sampleUser.balance} ریال',
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
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'ویرایش اطلاعات',
                                      //TODO: change the widget to form fields
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
                              sampleUser.getFullName()),
                          const SizedBox(height: 20.0,),
                          buildRowForUserInfo(context, 'کد ملی',
                              (sampleUser.getNationalID())),
                          const SizedBox(height: 20.0,),
                          buildRowForUserInfo(context, 'شماره تماس',
                              (sampleUser.getPhoneNumber())),
                          const SizedBox(height: 20.0,),
                          buildRowForUserInfo(context, 'تاریخ تولد',
                              (sampleUser.getBirthDateString())),
                        ]
                      ),
                    )
                  ),
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
                            onPressed: () => showDialogToEditPassword(context),
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(10.0),
                      elevation: 2.5,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10.0),
                        height: pageHeight * 0.26,
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
                            const SizedBox(height: 20.0,),
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
                                  '${sampleUser.balance} ریال',
                                  style: Theme.of(context).textTheme.labelMedium,
                                ),
                              ],
                            ),
                            Divider(
                              height: 30.0,
                              color: Theme.of(context).colorScheme.secondary,
                              thickness: 1.5,
                              indent: 20.0,
                              endIndent: 20.0,
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
                            const SizedBox(height: 20.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 5.0),
                                    SizedBox(
                                      width: pageWidth * 0.5,
                                      height: pageHeight * 0.06,
                                      child: TextFormField(
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
                                    SizedBox(width: pageWidth * 0.08),
                                    ElevatedButton(
                                      onPressed: () {

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
                            )
                          ],
                        ),
                      )
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
                        height: pageHeight * 0.31,
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
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                'جستجو',
                              ),
                            )
                          ]
                        )
                      )
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      height: pageHeight * 0.09,
                      // width: pageWidth * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
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
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: takenTrips.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black26,
                                ),
                                right: BorderSide(
                                  color: Colors.black26,
                                ),
                                left: BorderSide(
                                  color: Colors.black26,
                                ),
                              )
                            ),
                            height: pageHeight * 0.08,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(child: Text(takenTrips[index].getID(),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.headlineMedium)),
                                Expanded(child: Text(takenTrips[index].transportType,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.headlineMedium)),
                                Expanded(child: Text(takenTrips[index].getDate(),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.headlineMedium)),
                                // Expanded(child: Text(takenTrips[index].getPrice(),
                                //     textAlign: TextAlign.center,
                                //     style: Theme.of(context).textTheme.headlineMedium)),
                                Expanded(child: Text(takenTrips[index].getStatus(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    )
                                  )
                                ),
                                Expanded(
                                  child: InkWell(
                                    splashFactory: NoSplash.splashFactory,
                                    onTap: () {},
                                    child: const Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'مشاهده',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 16.0,
                                          color: Colors.blueAccent,
                                        )
                                      ],
                                    )
                                  )
                                )
                              ],
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
  GestureDetector buildDatePicker(BuildContext context, String flag) {
    return GestureDetector(
      onTap: () async {
        var pickedDate = await showPersianDatePicker(
          context: context,
          initialDate: Jalali.now(),
          firstDate: Jalali(1380, 1, 1),
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
                "${startingDateSearch.formatter.wN} ${startingDateSearch.formatter.dd} ${startingDateSearch.formatter.mN}");
          } else {
            endingDateLabel = convertEnToFa(
                "${endingDateSearch.formatter.wN} ${endingDateSearch.formatter.dd} ${endingDateSearch.formatter.mN}");
          }
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

Future<dynamic> showDialogToEditEmail(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return const CustomAlertDialogToEditEmail();
    },
  );
}

class CustomAlertDialogToEditEmail extends StatefulWidget {
  const CustomAlertDialogToEditEmail({super.key});

  final String emailRegex = "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$";

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
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              sampleUser.setEmail(_controller.text);
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'ایمیل با موفقیت ویرایش شد.',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  duration: const Duration(seconds: 1),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
              );
              Navigator.of(context).pop();
            }
          },
          child: const Text('تایید'),
        ),
      ],
    );
  }
}

Future<dynamic> showDialogToEditPassword(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return const CustomAlertDialogToEditPassword();
    },
  );
}

class CustomAlertDialogToEditPassword extends StatefulWidget {
  const CustomAlertDialogToEditPassword({super.key});

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
                  } else if (value != sampleUser.password) {
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
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                sampleUser.password = _controller.text;
                Navigator.of(context).pop();
              }
            },
            child: const Text('تایید'),
          )
        ]
    );
  }
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
        // TODO: update the balance in the next tab
        style: Theme.of(context).textTheme.labelMedium,
        ),
      );
  }
}