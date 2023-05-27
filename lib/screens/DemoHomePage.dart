import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'SignUpPage.dart';
// import signup

class DemoHomePage extends StatefulWidget {
  const DemoHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.5,
        title:
        Text(widget.title, style: Theme
            .of(context)
            .textTheme
            .headline1),
      ),
      // add two input for enter username and password
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 200.0),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Text("Test DemoHomePage",
                  style: Theme
                      .of(context)
                      .textTheme
                      .headline1)),
          // submit button
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(title: 'ورود'),
                  ),
                ),
            child: const Text('ورود'),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () =>
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpPage(title: 'ثبت‌نام'),
                  ),
                ),
            child: const Text('ثبت‌نام'),
          ),
        ],
      ),
    );
  }
}