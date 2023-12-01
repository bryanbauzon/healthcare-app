import 'package:flutter/material.dart';

import '../constants/strings.dart';
import '../constants/widgets.dart';
import 'nurses_document.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
        children: [
          CustomWidgets.customAppBar(
              context, StringConstants.appName, StringConstants.appDescription),
           // Padding(
           //    padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
           //    child:
           //        Image.asset(
           //          'images/logo.png',
           //          width: 620,
           //          height: 420,
           //        ),
           //    ),
          const Text(
            'WELCOME!',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Expanded(child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top:20, left: 25, right: 25),
              child: Column(
                children: [

                  const Text(
                    StringConstants.dummyDescriptionLong,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  CustomWidgets.customMenuTiles(
                      context, StringConstants.nursesDocument, true, () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NursesDocument()));
                  }, Icons.account_tree_outlined),
                  CustomWidgets.comingSoonMenuTiles(context),

                  CustomWidgets.comingSoonMenuTiles(context),
                  CustomWidgets.comingSoonMenuTiles(context),

                ],
              ),
            )
          ),),

        ],
      ),
    );
  }
}
