import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../constants/widgets.dart';

class Forms extends StatefulWidget {

  const Forms({super.key, required this.title});
  final String title;

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  final _formKey = GlobalKey<FormState>();

  void validateForm(){
    Navigator.pop(context);
    // if (_formKey.currentState!.validate()) {
    //
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('Processing Data')),
    //   );
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            CustomWidgets.customAppBar(context, AppConstants.appName,
                AppConstants.appDescription),
             Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                widget.title,
                style:const TextStyle(fontSize: AppConstants.headerFontSize,
                fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child:CustomWidgets.vitalSignsForm(context)
              ),
            ))
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomWidgets.customButton(
                  context, AppConstants.saveForNow, () {}),
              CustomWidgets.customButton(context, AppConstants.submit,validateForm),
            ],
          ),
        ));
  }
}
