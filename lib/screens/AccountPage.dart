import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

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
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: AppBar(
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
                        'نام کاربری',
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
                                    'sample@sample.com',
                                    style: Theme.of(context).textTheme.headlineMedium,
                                  ),
                                  const SizedBox(width: 30.0,),
                                  InkWell(
                                    onTap: () {},
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
                                    '۰ ریال',
                                    style: Theme.of(context).textTheme.headlineMedium,
                                  ),
                                  const SizedBox(width: 30.0),
                                  InkWell(
                                    onTap: () {},
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
                                  'نام و نام خانوادگی'),
                              const SizedBox(height: 20.0,),
                              buildRowForUserInfo(context, 'کد ملی', 'کد ملی'),
                              const SizedBox(height: 20.0,),
                              buildRowForUserInfo(context, 'شماره تماس', 'شماره تماس'),
                              const SizedBox(height: 20.0,),
                              buildRowForUserInfo(context, 'تاریخ تولد', 'تاریخ تولد'),
                            ]
                          ),
                        )
                      )
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

Row buildRowForUserInfo(BuildContext context, String title, String value) {
  return Row(
    children: [
      const SizedBox(width: 5.0,),
      Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      const SizedBox(width: 50.0,),
      Text(
        value,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    ],
  );
}