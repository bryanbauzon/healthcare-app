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

  static Widget customMenuTiles(BuildContext context, String title,
          bool isEnabled, VoidCallback onTap, Color color, IconData ic) =>
      Padding(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  ic,
                  color: AppColors.white,
                  size: 45,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    title,
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )),
          ),
        ),
      );

  static Widget comingSoonMenuTiles(BuildContext context) =>
      customMenuTiles(context, 'Coming Soon', true, () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Coming Soon!')),
        );
      }, Colors.grey, Icons.warning);

  static Widget dummyDocument(BuildContext context, String title) => Padding(
        padding: const EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${title} in progress...')),
            );
          },
          child: Container(
              height: 80,
              width: 170,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(color: AppColors.white),
                ),
              )),
        ),
      );
}
