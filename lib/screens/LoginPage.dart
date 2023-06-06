import 'package:flutter/material.dart';
import 'package:unlimited_heap_ap401/screens/ProjectMainPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  final String title = 'ورود';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool visiblePassword = false;
  final _formKey = GlobalKey<FormState>();

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
              // submit button
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showSnackBar(context, 'ورود با موفقیت انجام شد.');
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ProjectMainPage()));
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
                  onTap: () {},
                  child: Text(
                    'فراموشی رمز عبور',
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

void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: Theme.of(context).textTheme.displaySmall,
      ),
      duration: const Duration(seconds: 1),
      backgroundColor: Theme.of(context).colorScheme.secondary,
    ),
  );
}
