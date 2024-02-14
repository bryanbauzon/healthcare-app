import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../constants/widgets.dart';
import '../model/user.dart';
import '../utils/utils.dart';
import 'nurses_document.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.user});
  final User user;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isPhone = Utils.isMobile();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomWidgets.customAppBar(context, AppConstants.appName,
              AppConstants.appDescription, false, widget.user),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 25, right: 25),
            child: Text(
              AppConstants.greetings,
              style: TextStyle(
                  fontSize: AppConstants.headerFontSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 18, right: 18, bottom: 10),
            child: Text(
              AppConstants.appDescriptionDetailed,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: isPhone ? 10 : 25,
                  right: isPhone ? 10 : 25,
                  bottom: 40),
              child: Column(
                children: [
                  CustomWidgets.customMenuTiles(
                      context, AppConstants.nursesDocument, true, () {
                    Utils.navigateToScreen(
                        context,
                        NursesDocument(
                          user: widget.user,
                        ));
                  }, Icons.account_tree_outlined),
                  CustomWidgets.comingSoonMenuTiles(context),
                  CustomWidgets.comingSoonMenuTiles(context),
                  CustomWidgets.comingSoonMenuTiles(context),
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }
}
