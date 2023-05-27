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
        title: Text(widget.title, style: Theme.of(context).textTheme.headline2),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 48),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                child: Text("صفحات پروژه:",
                    // add style to text and manually set font size to 36
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        ?.copyWith(fontSize: 36))),
            // add space between buttons
            const SizedBox(height: 16),
            ElevatedButton(
              // redirect to login page with navigator
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUpPage(title: 'ثبت‌نام'),
                ),
              ),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(150.0, 50.0)),
                // add circular border to button
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1000.0),
                  ),
                ),
              ),
              child: Text(
                'ثبت‌نام',
                style: Theme.of(context)
                    .textTheme
                    .headline2,
              ),
            ),
            // add space between buttons
            const SizedBox(height: 16),
            ElevatedButton(
              // redirect to login page with navigator
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(title: 'ورود'),
                ),
              ),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(150.0, 50.0)),
                // add circular border to button
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(1000.0),
                  ),
                ),
              ),
              child: Text(
                'ورود',
                // add style to text and manually set color to white
                style: Theme.of(context)
                    .textTheme
                    .headline2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
