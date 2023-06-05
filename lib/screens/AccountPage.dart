import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../models/userinfo.dart';
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  @override
  State<AccountPage> createState() => _AccountPageState();
}

User sampleUser = User(
  username: 'sample_username',
  password: 'Aa@010101',
  email: 'sample@sample.com',
  balance: '۰',
  phoneNumber: '۰۹۱۲۳۴۵۶۷۸۹',
  birthDate: Jalali(1370, 1, 1),
  firstName: 'محمد',
  lastName: 'محمدی',
  nationalID: '0920513',
);

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    var pageHeight = MediaQuery.of(context).size.height;
    var pageWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                //replace with our own icon data.
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              elevation: 1.5,
              bottom: TabBar(
                indicatorColor: Theme.of(context).colorScheme.primary,
                splashFactory: NoSplash.splashFactory,
                tabs: [
                  Tab(
                    icon: const Icon(Icons.person),
                    child: Text(
                      'حساب کاربری',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
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
                ],
              ),
            )
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    color: Colors.transparent,
                    child: const CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage('assets/images/user.png'),
                    ),
                  ),
                  Text(
                    sampleUser.username,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Divider(
                    height: 20.0,
                    color: Theme.of(context).colorScheme.primary,
                    thickness: 1.5,
                  ),
                  Card(
                      margin: const EdgeInsets.all(10.0),
                      elevation: 2.5,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10.0),
                        height: 140.0,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.person_pin),
                                const SizedBox(width: 5.0,),
                                Text(
                                  'اطلاعات حساب کاربری',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.email, size: 16.0,),
                                const SizedBox(width: 5.0,),
                                Text(
                                  'ایمیل',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(width: 50.0,),
                                Text(
                                  sampleUser.email,
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                                const SizedBox(width: 30.0,),
                                InkWell(
                                  onTap: () {
                                    showDialogToEditEmail(context);
                                    // if (_emailEdited) {
                                    //   ScaffoldMessenger.of(context).showSnackBar(
                                    //     const SnackBar(content: Text('hi there')),
                                    //   );
                                    // }
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'ویرایش',
                                        style: Theme.of(context).textTheme.labelMedium,
                                      ),
                                      const Icon(
                                        Icons.edit_rounded,
                                        size: 16.0,
                                        color: Colors.blueAccent,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.money, size: 16.0,),
                                const SizedBox(width: 5.0,),
                                Text(
                                  'موجودی حساب',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(width: 50.0,),
                                Text(
                                  '${sampleUser.balance} ریال',
                                  style: Theme.of(context).textTheme.headlineMedium,
                                ),
                                const SizedBox(width: 30.0),
                                const GoToTransfersTab(),
                              ],
                            )
                          ],
                        ),
                      )
                  ),
                  Card(
                      margin: const EdgeInsets.all(10.0),
                      elevation: 2.5,
                      child: Container(
                        alignment: Alignment.center,
                        padding : const EdgeInsets.all(10.0),
                        height: 210.0,
                        child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.person_sharp),
                                  const SizedBox(width: 5.0,),
                                  Text(
                                    'اطلاعات شخصی',
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(width: 80.0,),
                                  InkWell(
                                    onTap: () {},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          'ویرایش اطلاعات',
                                          //TODO: change the widget to form fields
                                          style: Theme.of(context).textTheme.labelMedium,
                                        ),
                                        const Icon(
                                          Icons.edit_rounded,
                                          size: 16.0,
                                          color: Colors.blueAccent,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0,),
                              buildRowForUserInfo(context, 'نام و نام خانوادگی',
                                  sampleUser.getFullName()),
                              const SizedBox(height: 20.0,),
                              buildRowForUserInfo(context, 'کد ملی',
                                  (sampleUser.getNationalID())),
                              const SizedBox(height: 20.0,),
                              buildRowForUserInfo(context, 'شماره تماس',
                                  (sampleUser.getPhoneNumber())),
                              const SizedBox(height: 20.0,),
                              buildRowForUserInfo(context, 'تاریخ تولد',
                                  (sampleUser.getBirthDateString())),
                            ]
                        ),
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(
                              width: 2.0,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.key,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 5.0,),
                            TextButton(
                              onPressed: () => showDialogToEditPassword(context),
                              child: Text(
                                'ویرایش رمز عبور',
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                ],
              ),
            ),
            const Center(
              child: Text('تراکنش‌ها'),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                    children: [
                      Card(
                          margin: const EdgeInsets.all(10.0),
                          elevation: 2.5,
                          child: Container(
                              padding: const EdgeInsets.all(10.0),
                              height: pageHeight * 0.3,
                              child: Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.search),
                                          const SizedBox(width: 5.0,),
                                          Text(
                                            'جستجوی سفارش',
                                            style: Theme.of(context).textTheme.titleLarge,
                                          ),
                                        ]
                                    ),
                                    const SizedBox(height: 5.0,),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          const Icon(Icons.info_outline),
                                          const SizedBox(width: 5.0,),
                                          Text(
                                            'برای جستجو در لیست سفرها پرکردن حداقل یک فیلد کافیست.',
                                            style: Theme.of(context).textTheme.bodyMedium,
                                          ),
                                        ]
                                    ),
                                    const SizedBox(height: 20.0,),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: pageWidth * 0.8,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                labelText: 'شماره سفارش',
                                                alignLabelWithHint: true,
                                                labelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]
                                    ),
                                  ]
                              )
                          )
                      )
                    ]
                )
            ),
          ],
        ),
      ),
    );
  }
}


Row buildRowForUserInfo(BuildContext context, String title, String? value) {
  return Row(
    children: [
      const SizedBox(width: 5.0,),
      Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      const SizedBox(width: 50.0,),
      Text(
        value!,
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    ],
  );
}

Future<dynamic> showDialogToEditEmail(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return const CustomAlertDialogToEditEmail();
    },
  );
}

class CustomAlertDialogToEditEmail extends StatefulWidget {
  const CustomAlertDialogToEditEmail({super.key});

  final String emailRegex = "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$";

  @override
  State<CustomAlertDialogToEditEmail> createState() => _CustomAlertDialogToEditEmailState();
}

class _CustomAlertDialogToEditEmailState extends State<CustomAlertDialogToEditEmail> {

  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: const Text('ویرایش آدرس ایمیل'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          validator: (value) {
            RegExp regExp = RegExp(widget.emailRegex);
            if (value == null || value.isEmpty) {
              return 'لطفا ایمیل را وارد کنید.';
            } else if (!regExp.hasMatch(value)) {
              return 'ایمیل واردشده معتبر نیست.';
            }
            return null;
          },
          style: Theme.of(context).textTheme.headlineMedium,
          showCursor: true,
          decoration: const InputDecoration(
            alignLabelWithHint: true,
            labelText: 'ایمیل جدید',
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // TODO: show success message
              // TODO: update user email using setState
              sampleUser.setEmail(_controller.text);
              // setState(() {
              //   _AccountPageState._emailEdited = true;
              // });
              Navigator.of(context).pop();
            }
          },
          child: const Text('تایید'),
        ),
      ],
    );
  }
}

Future<dynamic> showDialogToEditPassword(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return const CustomAlertDialogToEditPassword();
    },
  );
}

class CustomAlertDialogToEditPassword extends StatefulWidget {
  const CustomAlertDialogToEditPassword({super.key});

  @override
  State<CustomAlertDialogToEditPassword> createState() => _CustomAlertDialogToEditPasswordState();
}

class _CustomAlertDialogToEditPasswordState extends State<CustomAlertDialogToEditPassword> {

  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  bool visibleCurrentPassword = false;
  bool visibleNewPassword = false;
  bool visibleConfirmNewPassword = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        title: const Text('ویرایش رمز عبور'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'لطفا رمز عبور فعلی را وارد کنید.';
                  } else if (value != sampleUser.password) {
                    return 'رمز عبور فعلی اشتباه است.';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.headlineMedium,
                obscureText: visibleCurrentPassword,
                showCursor: true,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'رمز عبور فعلی',
                  suffixIcon: IconButton(
                    iconSize: 16.0,
                    alignment: Alignment.bottomLeft,
                    icon: Icon(visibleCurrentPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        visibleCurrentPassword = !visibleCurrentPassword;
                      });
                    },
                  ),
                ),
              ),
              TextFormField(
                controller: _controller,
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
                style: Theme.of(context).textTheme.headlineMedium,
                obscureText: visibleNewPassword,
                showCursor: true,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'رمز عبور جدید',
                  suffixIcon: IconButton(
                    iconSize: 16.0,
                    alignment: Alignment.bottomLeft,
                    icon: Icon(visibleNewPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        visibleNewPassword = !visibleNewPassword;
                      });
                    },
                  ),
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'لطفا رمز عبور جدید را تکرار کنید.';
                  } else if (value.compareTo(_controller.text) != 0) {
                    return 'تکرار رمز عبور صحیح نمی‌باشد.';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.headlineMedium,
                obscureText: visibleConfirmNewPassword,
                showCursor: true,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'تکرار رمز عبور جدید',
                  suffixIcon: IconButton(
                    iconSize: 16.0,
                    alignment: Alignment.bottomLeft,
                    icon: Icon(visibleConfirmNewPassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        visibleConfirmNewPassword = !visibleConfirmNewPassword;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                sampleUser.password = _controller.text;
                Navigator.of(context).pop();
              }
            },
            child: const Text('تایید'),
          )
        ]
    );
  }
}

class GoToTransfersTab extends StatelessWidget {
  const GoToTransfersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        DefaultTabController.of(context).animateTo(1);
      },
      child: const Text(
        'افزایش موجودی  >',
        // TODO: update the balance in the next tab
        style: TextStyle(
          fontFamily: 'kalameh',
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}