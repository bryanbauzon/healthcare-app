import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/colors.dart';

import '../screens/forms.dart';

class CustomWidgets {
  static Widget customAppBar(
          BuildContext context, String appName, bool isForm) =>
      Container(
          height: 90,
          width: MediaQuery.of(context).size.width,
          color: AppColors.theme,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appName,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white),
                ),
                !isForm
                    ? IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Forms()));
                        },
                        icon: const Icon(Icons.add),
                        style: ButtonStyle(
                            iconColor:
                                MaterialStateProperty.all(AppColors.white)),
                      )
                    : Container()
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
          border: InputBorder.none,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      );
}
