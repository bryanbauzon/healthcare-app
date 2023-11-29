import 'package:flutter/material.dart';

import '../constants/strings.dart';
import '../constants/widgets.dart';

class Forms extends StatefulWidget {
  const Forms({super.key});

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomWidgets.customAppBar(
                  context, StringConstants.appName, true),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    children: [
                      CustomWidgets.customTextFormField('Test'),
                      CustomWidgets.customTextFormField('Test'),
                      CustomWidgets.customTextFormField('Test'),
                      CustomWidgets.customTextFormField('Test'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomWidgets.customButton(
                  context, StringConstants.saveForNow, () {}),
              CustomWidgets.customButton(context, StringConstants.submit, () {
                if (_formKey.currentState!.validate()) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              }),
            ],
          ),
        ));
  }
}
