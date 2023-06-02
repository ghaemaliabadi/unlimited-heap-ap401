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
          body: const TabBarView(
            children: [
              Center(
                child: Text('تراکنش‌ها'),
              ),
              Center(
                child: Text('سفرها'),
              ),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        color: Colors.transparent,
                        elevation: 0.0,
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage('assets/images/user.png'),
                        ),
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
