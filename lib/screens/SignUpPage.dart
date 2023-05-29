import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  final String title = 'ثبت‌نام';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  bool visiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1.5,
        title: Text(widget.title, style: Theme.of(context).textTheme.headline2),
      ),
      body: InkResponse(
        containedInkWell: false,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 100.0),
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
                  child: Text(
                      'به علی‌بابا خوش آمدید.',
                      style: Theme.of(context).textTheme.headline1
                  )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                child: TextField(
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
                child: TextField(
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
                          : Icons.visibility_off
                      ),
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
                child: TextField(
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
              // submit button
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  // heightFactor: 9,
                  child: ElevatedButton(
                    onPressed: () => _showSnackBar(context, 'ثبت‌نام با موفقیت انجام شد.'),
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(const Size(150.0, 50.0)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1000.0),
                        ),
                      ),
                    ),
                    child: Text(
                        'ثبت‌نام',
                        style: Theme.of(context).textTheme.headline1
                    ),
                  ),
                ),
              ),
              Expanded(flex: 1,child: Container(),),
            ],
          ),
      ),
    );
  }
}

void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
          message,
          style: Theme.of(context).textTheme.headline1,
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ),
  );
}