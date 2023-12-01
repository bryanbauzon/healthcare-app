import 'package:flutter/material.dart';

import '../constants/strings.dart';
import '../constants/widgets.dart';

class Forms extends StatefulWidget {

  const Forms({super.key, required this.title});
  final String title;

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            CustomWidgets.customAppBar(context, StringConstants.appName,
                StringConstants.appDescription),
             Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                widget.title,
                style:const TextStyle(fontSize: 40,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomWidgets.customButton(
                  context, StringConstants.saveForNow, () {}),
              CustomWidgets.customButton(context, StringConstants.submit, () {
                Navigator.pop(context);
                // if (_formKey.currentState!.validate()) {

                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('Processing Data')),
                //   );
                // }
              }),
            ],
          ),
        ));
  }
}
