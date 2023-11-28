import 'package:flutter/material.dart';

import '../constants/strings.dart';
import '../constants/widgets.dart';

class Forms extends StatefulWidget {
  const Forms({super.key});

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        CustomWidgets.customAppBar(context, StringConstants.formScreen, true),
        Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomWidgets.customButton(
                          context, StringConstants.saveForNow),
                      CustomWidgets.customButton(
                          context, StringConstants.submit),
                    ],
                  ),
                )))
      ],
    ));
  }
}
