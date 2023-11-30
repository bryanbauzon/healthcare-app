import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/strings.dart';
import 'package:holy_trinity_healthcare/constants/widgets.dart';
import 'package:holy_trinity_healthcare/screens/nurses_document.dart';

void main() {
  runApp(const MaterialApp(home: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          CustomWidgets.customAppBar(
              context, StringConstants.appName, StringConstants.appDescription),

       const Padding(padding:  EdgeInsets.only(top:20, left: 25, right: 25),
        child:  Column(
          children: [
            Text('WELCOME!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(StringConstants.dummyDescriptionLong,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18
              ),
            ),
          ],
        )),
          CustomWidgets.customMenuTiles(
              context, StringConstants.nursesDocument, true, () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NursesDocument()));
          }, Colors.orange, Icons.account_tree_outlined),
          CustomWidgets.comingSoonMenuTiles(context),
          CustomWidgets.comingSoonMenuTiles(context),
        ],
      ),
    ));
  }
}
