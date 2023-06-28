import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unlimited_heap_ap401/screens/SellerPage.dart';
import '../models/userinfo.dart';
import 'LoginPage.dart';
import 'ProjectMainPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  final String title = 'ثبت‌نام';
  final String emailRegex =
      "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}"
      "[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$";
  static const String ip = "10.0.2.2";
  static const int port = 1234;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool visiblePassword = false;
  bool isSeller = false;
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
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
              const SizedBox(height: 30.0),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
                  child: Text('به علی‌بابا خوش آمدید.',
                      style: Theme.of(context).textTheme.displayLarge)),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: TextFormField(
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'لطفا نام کاربری را وارد کنید.';
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.displaySmall,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'نام کاربری',
                    // hintText: 'نام کاربری',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    suffixIcon: const Icon(Icons.person),
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
                    } else if (value.length < 8) {
                      return 'رمز عبور باید حداقل ۸ کاراکتر باشد.';
                    } else if (!RegExp(
                            "(?=[A-Za-z0-9]+\$)^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.{8,}).*\$")
                        .hasMatch(value)) {
                      return 'رمز عبور باید شامل حروف کوچک و بزرگ انگلیسی و اعداد باشد.';
                    } else if (!RegExp("(1|0)+").hasMatch(value) &&
                        !('a'.allMatches(value).length >= 2)) {
                      return 'رمز عبور باید شامل حداقل دو حرف a یا یک عدد در مبنای دو باشد.';
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
                child: TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    RegExp regExp = RegExp(widget.emailRegex);
                    if (value == null || value.isEmpty) {
                      return 'لطفا ایمیل را وارد کنید.';
                    } else if (!regExp.hasMatch(value)) {
                      return 'ایمیل واردشده معتبر نیست.';
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
                    Text('ثبت‌نام به عنوان فروشنده',
                        style: Theme.of(context).textTheme.displaySmall),
                  ],
                ),
              ),
              // submit button
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  // heightFactor: 9,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String serverResponse = await _checkSignUp(
                            _usernameController.text,
                            _passwordController.text,
                            _emailController.text,
                            isSeller);
                        if (context.mounted) {
                          if (serverResponse == "true") {
                            User user = User(
                              username: _usernameController.text,
                              password: _passwordController.text,
                              email: _emailController.text,
                            );
                            _showSnackBar(
                                context, 'ثبت‌نام با موفقیت انجام شد.', false);
                            FocusManager.instance.primaryFocus?.unfocus();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                (
                                    isSeller
                                        ? const SellerPage()
                                        : ProjectMainPage(user: user)
                                )
                            )
                            );
                          } else if (serverResponse == "email") {
                            _showSnackBar(context,
                                'ایمیل وارد شده تکراری است. لطفا ایمیل دیگری انتخاب کنید.',
                                true);
                            FocusManager.instance.primaryFocus?.unfocus();
                          } else if (serverResponse == "un") {
                            _showSnackBar(context,
                                'نام کاربری وارد شده تکراری است. لطفا نام کاربری دیگری انتخاب کنید.',
                                true);
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
                    child: Text('ثبت‌نام',
                        style: Theme.of(context).textTheme.displayMedium),
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  },
                  child: Text(
                    'حساب کاربری دارید؟',
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
            ? Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.red)
            : Theme.of(context).textTheme.displaySmall
        ),
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ),
  );
}

Future<String> _checkSignUp(String username, String password, String email, bool isSeller) async {
  String response = "false";
  await Socket.connect(SignUpPage.ip, SignUpPage.port).then((serverSocket) {
    print("Connected!");
    serverSocket.write("signup-$isSeller-$username-$password-$email*");
    serverSocket.flush();
    print("Sent data!");
    serverSocket.listen((socket) {
      response = String.fromCharCodes(socket).trim().substring(2);
      print(response);
    });
  }
  );
  return Future.delayed(const Duration(milliseconds: 100), () => response);
}
