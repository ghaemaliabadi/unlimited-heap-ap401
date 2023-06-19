import 'package:flutter/material.dart';

class EditUserInfoPage extends StatefulWidget {
  const EditUserInfoPage({super.key});

  @override
  State<EditUserInfoPage> createState() => _EditUserInfoPageState();
}

class _EditUserInfoPageState extends State<EditUserInfoPage> {

  @override
  Widget build(BuildContext context) {
    var pageHeight = MediaQuery.of(context).size.height;

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
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 35.0),
          child: Column(
            children: [
              TextFormField(
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
              TextFormField(
                style: Theme.of(context).textTheme.displaySmall,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'کد ملی',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: pageHeight * 0.03,),
              TextFormField(
                style: Theme.of(context).textTheme.displaySmall,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'شماره تماس',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
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
      )
    );
  }
}
