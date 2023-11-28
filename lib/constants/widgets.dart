import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/colors.dart';

class CustomWidgets {
  static Widget customAppBar(BuildContext context, String appName) => Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      color: AppColors.appBar,
      child: SafeArea(
        child: Center(
            child: Text(
          appName,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.appBarTitle),
        )),
      ));

  static Widget customButton(String text) {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.cyan),
          foregroundColor: MaterialStateProperty.all(Colors.white)),
      onPressed: () {
        debugPrint('Received click');
      },
      child: Text(text),
    );
  }
}
