import 'package:flutter/material.dart';

class EditUserInfoPage extends StatefulWidget {
  const EditUserInfoPage({super.key});

  @override
  State<EditUserInfoPage> createState() => _EditUserInfoPageState();
}

class _EditUserInfoPageState extends State<EditUserInfoPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var pageHeight = MediaQuery.of(context).size.height;
    var pageWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('ویرایش اطلاعات کاربری'),
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
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 35.0),
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'لطفا نام خود را وارد کنید.';
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.displaySmall,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'نام',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                ),
                SizedBox(height: pageHeight * 0.03,),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'لطفا نام خانوادگی خود را وارد کنید.';
                    }
                    return null;
                  },
                  style: Theme.of(context).textTheme.displaySmall,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'نام خانوادگی',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: pageHeight * 0.03,),
                // form for birthdate
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: pageWidth * 0.4,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفا کد ملی خود را وارد کنید.';
                          }
                          return null;
                        },
                        style: Theme.of(context).textTheme.displaySmall,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          labelText: 'کد ملی',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: pageWidth * 0.05,),
                    SizedBox(
                      width: pageWidth * 0.4,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'لطفا شماره تماس خود را وارد کنید.';
                          }
                          return null;
                        },
                        style: Theme.of(context).textTheme.displaySmall,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          labelText: 'شماره تماس',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('در حال ارسال اطلاعات...')),
                          );
                          Navigator.of(context).pop();
                        }
                      },
                      style: ButtonStyle(
                        minimumSize:
                        MaterialStateProperty.all(const Size(170.0, 50.0)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1000.0),
                          ),
                        ),
                      ),
                      child: Text('تایید اطلاعات',
                          style: Theme.of(context).textTheme.displayMedium),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ]
            ),
          ),
        ),
      )
    );
  }
}
