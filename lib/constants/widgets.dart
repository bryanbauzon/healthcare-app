import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/colors.dart';

class CustomWidgets {
  static Widget customAppBar(BuildContext context, String appName) => Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      color: AppColors.appBar,
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              appName,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.appBarTitle),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
              style: ButtonStyle(
                  iconColor: MaterialStateProperty.all(Colors.white)),
            )
          ],
        ),
      )));

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
