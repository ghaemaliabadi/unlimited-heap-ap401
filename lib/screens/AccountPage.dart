import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                  Tab(
                      icon: const Icon(Icons.person),
                      child: Text(
                        'حساب کاربری',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                  ),
                ],
              ),
            )
          ),
          body: TabBarView(
            children: [
              const Center(
                child: Text('تراکنش‌ها'),
              ),
              const Center(
                child: Text('سفرها'),
              ),
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
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'اطلاعات حساب کاربری',
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const Icon(Icons.person_pin),
                                ],
                              ),
                              const SizedBox(height: 20.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'sample@sample.com',
                                    style: Theme.of(context).textTheme.headlineMedium,
                                  ),
                                  const SizedBox(width: 50.0,),
                                  Text(
                                    'ایمیل',
                                    style: Theme.of(context).textTheme.titleSmall,

                                  ),
                                  const Icon(Icons.email, size: 16.0,),
                                ],
                              ),
                              const SizedBox(height: 20.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '۰ ریال',
                                    style: Theme.of(context).textTheme.headlineMedium,
                                  ),
                                  const SizedBox(width: 50.0,),
                                  Text(
                                    'موجودی حساب',
                                    style: Theme.of(context).textTheme.titleSmall,

                                  ),
                                  const Icon(Icons.money, size: 16.0,),
                                ],
                              )
                            ],
                          ),
                        )
                      ),
                    ],
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
