import 'dart:io';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:unlimited_heap_ap401/screens/SignUpPage.dart';

import '../models/trip.dart';
import '../models/userinfo.dart';
import 'PaymentSuccess.dart';
import 'ProjectMainPage.dart';
import 'SellerPage.dart';
import 'dart:convert' show utf8;

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  Trip? trip;

  LoginPage({
    Key? key,
    this.trip,
  }) : super(key: key);
  final String title = 'ورود';
  static const String ip = "127.0.0.1";
  static const int port = 1234;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool visiblePassword = false;
  bool isSeller = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.5,
        title: Text(widget.title,
            style: Theme.of(context).textTheme.displayMedium),
      ),
      body: InkWell(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 100.0),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
                  child: Text(
                    'آدرس ایمیل و رمز عبور خود را وارد کنید.',
                    style: Theme.of(context).textTheme.displayLarge,
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'لطفا ایمیل را وارد کنید.';
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.displaySmall,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'ایمیل',
                    // hintText: 'ایمیل',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: const Icon(Icons.email),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'لطفا رمز عبور را وارد کنید.';
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.displaySmall,
                  obscureText: visiblePassword,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'رمز عبور',
                    // hintText: 'رمز عبور',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(visiblePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          visiblePassword = !visiblePassword;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: isSeller,
                      onChanged: (value) {
                        isSeller = value!;
                        setState(() {});
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                    Text('ورود به عنوان فروشنده',
                        style: Theme.of(context).textTheme.displaySmall),
                  ],
                ),
              ),
              // submit button
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String serverResponse = await _checkLogin(
                            _emailController.text,
                            _passwordController.text,
                            isSeller);
                        if (context.mounted) {
                          if (serverResponse != "false") {
                            await _buildUser(serverResponse).then((value) async {
                              List<String> info = value.split("-");
                              await _getFirstName(serverResponse).then((firstName) {
                                User user = User(
                                  username: serverResponse,
                                  password: _passwordController.text,
                                  email: _emailController.text,
                                  balance: info[0],
                                  phoneNumber: (info[1] == "null"
                                      ? null
                                      : info[1]),
                                  birthDate: (info[2] == "null"
                                      ? null
                                      : Jalali(
                                      int.parse(info[2].split("/")[0]),
                                      int.parse(info[2].split("/")[1]),
                                      int.parse(info[2].split("/")[2]))),
                                  firstName: (firstName == "null" ? null : firstName),
                                  lastName: (info[3] == "null" ? null : info[3]),
                                  nationalID: (info[4] == "null" ? null : info[4]),
                                  accountType: isSeller ? "seller" : "customer",
                                );
                                // ignore: use_build_context_synchronously
                                _showSnackBar(
                                    context, 'ورود با موفقیت انجام شد.', false);
                                FocusManager.instance.primaryFocus?.unfocus();
                                Future.delayed(const Duration(milliseconds: 200),
                                        () {
                                      if (widget.trip != null) {
                                        widget.trip?.user = user;
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) => PaymentSuccess(
                                                    trip: widget.trip!)));
                                      } else {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) => (isSeller
                                                    ? SellerPage(user: user)
                                                    : ProjectMainPage(user: user))));
                                      }
                                    });
                              });
                            });

                          } else {
                            _showSnackBar(
                                context, 'ایمیل یا رمز عبور اشتباه است.', true);
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                        }
                      }
                    },
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(150.0, 50.0)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1000.0),
                        ),
                      ),
                    ),
                    child: Text(
                      'ورود',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => SignUpPage(
                              trip: widget.trip,
                            )));
                  },
                  child: Text(
                    'حساب کاربری ندارید؟ برای ثبت‌نام کلیک کنید',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String message, bool isError) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: (isError
            ? Theme.of(context)
                .textTheme
                .displaySmall
                ?.copyWith(color: Colors.red)
            : Theme.of(context).textTheme.displaySmall),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ),
  );
}

Future<String> _checkLogin(String email, String password, bool isSeller) async {
  String response = "false";
  await Socket.connect(LoginPage.ip, LoginPage.port).then((serverSocket) {
    print("Connected!");
    serverSocket.write("login-$isSeller-$email-$password*");
    serverSocket.flush();
    print("Sent data!");
    serverSocket.listen((socket) {
      response = utf8.decode(socket);
      print(response);
    });
  });
  return Future.delayed(const Duration(milliseconds: 300), () => response);
}

Future<String> _getFirstName(String username) async {
  String response = "false";
  await Socket.connect(LoginPage.ip, LoginPage.port).then((serverSocket) {
    print("Connected!");
    serverSocket.write("getFirstName-$username*");
    serverSocket.flush();
    print("Sent data!");
    serverSocket.listen((socket) {
      response = utf8.decode(socket);
      print(response);
    });
  });
  return Future.delayed(const Duration(milliseconds: 100), () => response);
}

Future<String> _buildUser(String username) async {
  String response = "false";
  String out = "";
  await Socket.connect(LoginPage.ip, LoginPage.port).then((serverSocket) {
    print("Connected!");
    serverSocket.write("getUser-$username*");
    serverSocket.flush();
    print("Sent data!");
    serverSocket.listen((socket) {
      response = utf8.decode(socket);
      List<String> info = response.split("-");
      out = "${info[4]}-";
      out += "${info[5]}-";
      out += "${info[6]}-";
      out += "${info[8]}-";
      out +=info[9];
    });
  }
  );
  return Future.delayed(const Duration(milliseconds: 100), () => out);
}
