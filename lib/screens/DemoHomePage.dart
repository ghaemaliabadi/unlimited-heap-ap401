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
        title: Text(widget.title, style: Theme.of(context).textTheme.headline1),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(
              height: 48,
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                child: Text("صفحات پروژه:",
                    style: Theme.of(context).textTheme.headline1)),
            // submit button
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(title: 'ورود'),
                ),
              ),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(150.0, 50.0)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1000.0),
                  ),
                ),
              ),
              child: const Text('ورود'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUpPage(title: 'ثبت‌نام'),
                ),
              ),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(150.0, 50.0)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1000.0),
                  ),
                ),
              ),
              child: const Text('ثبت‌نام'),
            ),
          ],
        ),
      ),
    );
  }
}
