import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/colors.dart';

import '../constants/app_constants.dart';
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
            CustomWidgets.customAppBar(context, AppConstants.appName,
                AppConstants.appDescription),
            const Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(AppConstants.nursesDocument,
                  style: TextStyle(fontSize: AppConstants.headerFontSize,
                  fontWeight: FontWeight.bold
                  )),
            ),
            Wrap(
              children: [
                CustomWidgets.documentTiles(context, AppConstants.vitalSign,true),
                CustomWidgets.documentTiles(context, AppConstants.neurological,true)
              ],
            ),
            Wrap(
              children: [
                CustomWidgets.documentTiles(context, 'Document 3',false),
                CustomWidgets.documentTiles(context, 'Document 4',false)
              ],
            ),
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
