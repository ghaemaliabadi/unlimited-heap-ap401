import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../models/userinfo.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

User sampleUser = User(
  username: 'نام کاربری',
  password: 'Aa@010101',
  email: 'sample@sample.com',
  balance: '۰',
  birthDate: Jalali(1370, 1, 1),
);

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa'), // farsi
      ],
      debugShowCheckedModeBanner: false,

      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: AppBar(
              title: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back),
                iconSize: 24.0,
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
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
                                      showDialogWithTextFormField(context);
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
                                  InkWell(
                                    onTap: () {
                                      // TODO: fix the animation to next tab here
                                      DefaultTabController.of(context).animateTo(1);
                                    },
                                    child: Text(
                                      'افزایش موجودی  >',
                                      style: Theme.of(context).textTheme.labelMedium,
                                    ),
                                  ),
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
                                  (sampleUser.nationalID ?? '-')),
                              const SizedBox(height: 20.0,),
                              buildRowForUserInfo(context, 'شماره تماس',
                                  (sampleUser.phoneNumber ?? '-')),
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
                                Text(
                                  'ویرایش رمز عبور',
                                  style: Theme.of(context).textTheme.headlineMedium,
                                )
                              ],
                            )
                        ),
                      ),
                    ],
                  ),
              ),
              const Center(
                child: Text('تراکنش‌ها'),
              ),
              const Center(
                child: Text('سفرها'),
              ),
            ],
          ),
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
// TODO: add validation to email text field
Future<dynamic> showDialogWithTextFormField(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: const Text('ویرایش آدرس ایمیل'),
        content: TextFormField(
          style: Theme.of(context).textTheme.headlineMedium,
          showCursor: true,
          decoration: const InputDecoration(
            alignLabelWithHint: true,
            labelText: 'ایمیل جدید',
          ),
        ),
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