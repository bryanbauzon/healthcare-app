import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/colors.dart';
import 'package:holy_trinity_healthcare/constants/strings.dart';
import 'package:holy_trinity_healthcare/constants/widgets.dart';

import 'screens/forms.dart';

void main() {
  runApp(const MaterialApp(home: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            CustomWidgets.customAppBar(context, StringConstants.appName,
                StringConstants.appDescription),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Forms()));
          },
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.theme,
          child: const Icon(Icons.add),
        ));
  }
}
