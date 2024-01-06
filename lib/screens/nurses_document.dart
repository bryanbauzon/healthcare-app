import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/colors.dart';
import 'package:holy_trinity_healthcare/screens/home.dart';
import 'package:holy_trinity_healthcare/utils/utils.dart';

import '../constants/app_constants.dart';
import '../constants/widgets.dart';
import '../model/user.dart';

class NursesDocument extends StatefulWidget {
  const NursesDocument({super.key, required this.user});

  final User user;
  @override
  State<NursesDocument> createState() => _NursesDocument();
}

class _NursesDocument extends State<NursesDocument> {
  bool isPhone = Utils.isMobile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomWidgets.customAppBar(context, AppConstants.appName,
                AppConstants.appDescription, false, widget.user),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Text(AppConstants.nursesDocument,
                  style: TextStyle(
                      fontSize: isPhone ? 30 : AppConstants.headerFontSize,
                      fontWeight: FontWeight.bold)),
            ),
            Wrap(
              children: [
                CustomWidgets.documentTiles(
                    context, AppConstants.vitalSign, true, widget.user),
                CustomWidgets.documentTiles(
                    context, AppConstants.neurological, true, widget.user)
              ],
            ),
            Wrap(
              children: [
                CustomWidgets.documentTiles(
                    context, 'Document 3', false, widget.user),
                CustomWidgets.documentTiles(
                    context, 'Document 4', false, widget.user)
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Utils.navigateToScreen(context, Home(user: widget.user));
        },
        backgroundColor: AppColors.theme,
        foregroundColor: AppColors.white,
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
