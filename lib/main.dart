import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/strings.dart';
import 'package:holy_trinity_healthcare/constants/widgets.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Column(
        children: [
          CustomWidgets.customAppBar(context, StringConstants.appName),
          Container(
            color: Colors.amber,
            child: const Center(
              child: Text('Hello'),
            ),
          )
        ],
      )),
    );
  }
}
