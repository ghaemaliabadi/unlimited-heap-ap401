import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../models/userinfo.dart';
import 'AccountPage.dart';
import 'LoginPage.dart';
import 'ProjectMainPage.dart';
import 'SellerPage.dart';
import 'SignUpPage.dart';

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
        title: Text(widget.title, style: Theme.of(context).textTheme.displayMedium),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 50),
                Text("صفحات پروژه:",
                    // add style to text and manually set font size to 36
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontSize: 36)),
            buildElevatedButtonWithRedirect(
                context, 'ثبت‌نام', SignUpPage()),
            buildElevatedButtonWithRedirect(
                context, 'ورود', LoginPage()),
            buildElevatedButtonWithRedirect(
                context, 'صفحه اصلی پروژه', ProjectMainPage()),
            buildElevatedButtonWithRedirect(
                context, 'حساب کاربری', AccountPage(
              // user: User(
              //   username: 'sample_username',
              //   password: 'Aa@010101',
              //   email: 'sample@sample.com',
              //   balance: '۰',
              //   phoneNumber: '۰۹۱۲۳۴۵۶۷۸۹',
              //   birthDate: Jalali(1370, 1, 1),
              //   firstName: 'محمد',
              //   lastName: 'محمدی',
              //   nationalID: '0920513',
              // )
            )),
            buildElevatedButtonWithRedirect(
                context, 'صفحه فروشندگان', SellerPage(
              user: User(
                username: "some",
                password: "some",
                email: "some",
                firstName: "all"
              ),
            )),
          ],
        ),
      ),
    );
  }
}

Column buildElevatedButtonWithRedirect(
    BuildContext context, String title, StatefulWidget state) {
  return Column(
    children: [
      const SizedBox(height: 16),
      ElevatedButton(
        // redirect to login page with navigator
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => state,
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
          title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    ],
  );
}
