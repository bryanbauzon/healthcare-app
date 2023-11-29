import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/colors.dart';

class CustomWidgets {
  static Widget customAppBar(
          BuildContext context, String appName, String appDescription) =>
      Container(
          height: 95,
          width: MediaQuery.of(context).size.width,
          color: AppColors.theme,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  appName,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white),
                ),
                Text(
                  appDescription,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white),
                ),
              ],
            ),
          )));

  static Widget customButton(
      BuildContext context, String text, VoidCallback onTap) {
    return TextButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.theme),
          foregroundColor: MaterialStateProperty.all(AppColors.white)),
      onPressed: onTap,
      child: Text(text),
    );
  }

  static Widget customTextFormField(String fieldName) => TextFormField(
        decoration: InputDecoration(
          hintText: fieldName,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      );
}
