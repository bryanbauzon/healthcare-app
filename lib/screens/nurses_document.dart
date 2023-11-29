import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/colors.dart';

import '../constants/strings.dart';
import '../constants/widgets.dart';

class NursesDocument extends StatefulWidget {
  const NursesDocument({super.key});

  @override
  State<NursesDocument> createState() => _NursesDocument();
}

class _NursesDocument extends State<NursesDocument> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomWidgets.customAppBar(context, StringConstants.appName,
                StringConstants.appDescription),
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(StringConstants.nursesDocument,
                  style: TextStyle(fontSize: 25)),
            ),
            Wrap(
              children: [
                CustomWidgets.dummyDocument(context, 'Document 1'),
                CustomWidgets.dummyDocument(context, 'Document 2')
              ],
            ),
            Wrap(
              children: [
                CustomWidgets.dummyDocument(context, 'Document 3'),
                CustomWidgets.dummyDocument(context, 'Document 4')
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: AppColors.theme,
        foregroundColor: AppColors.white,
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
