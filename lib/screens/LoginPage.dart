import 'package:flutter/material.dart';

import 'SignUpPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  final String title = 'ورود';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.5,
        title: Text(widget.title, style: Theme.of(context).textTheme.headline1),
      ),
      // add two input for enter username and password
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 200.0),Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Text(
                  "Test LoginPage",
                  style: Theme.of(context).textTheme.headline1
              )
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: TextField(
              decoration: InputDecoration(
                alignLabelWithHint: true,
                labelText: 'نام کاربری',
                // hintText: 'نام کاربری خود را وارد کنید',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.person),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'رمز عبور',
                // hintText: 'رمز عبور',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.lock),
              ),
            ),
          ),
          // submit button
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () => {
              _showSnackBar(context, 'ورود با موفقیت انجام شد.'),
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const SignUpPage()),
              ),
            },
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(const Size(150.0, 50.0)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1000.0),
                ),
              ),
            ),
            child: Text(
              'ورود',
              style: (Theme.of(context).textTheme.headline2),
            ),
          ),
        ],
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text, style: Theme.of(context).textTheme.headline2),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 1),
    ),
  );
}