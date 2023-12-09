import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/app_constants.dart';
import 'package:intl/intl.dart';

class Utils {
  //Reference: https://api.flutter.dev/flutter/material/Icons-class.html
  static IconData documentTilesIcon(String title) {
    if (title.contains(AppConstants.vitalSign)) {
      return Icons.monitor_heart_outlined;
    }
    return Icons.account_tree_outlined;
  }

  static void navigateToScreen(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static TextInputType getTextInputTypeByField(String field) {
    TextInputType type = TextInputType.text;
    if (AppConstants.typeInputNumberList.contains(field)) {
      type = TextInputType.number;
    }
    return type;
  }

  static List<String> retrieveDropdownListByFieldName(String fieldName) {
    List<String> list = [];
    switch (fieldName) {
      case AppConstants.respiratoryRate:
        return AppConstants.respiratoryRateList;
      case AppConstants.heartRate:
        return AppConstants.heartRateList;
      case AppConstants.diminished:
        return AppConstants.diminishedList;
      case AppConstants.shortOfBreath:
        return AppConstants.shortOfBreathList;
      case AppConstants.oxygenUse:
        return AppConstants.oxygenUseList;
    }
    return list;
  }

  static bool isNotEmpty(String data) {
    return data.isNotEmpty;
  }

  static bool isListNotEmpty(List<String> list) {
    for (String str in list) {
      if (isNotEmpty(str)) {
        return true;
      }
    }
    return false;
  }

  static String removeEmptyString(String str) => str.replaceAll(' ', '').trim();
  static String stringCapitalize(String s) {
    if (s.trim().isEmpty) {
      return '';
    }
    return s
        .split(' ')
        .map((element) =>
            "${element[0].toUpperCase()}${element.substring(1).toLowerCase()}")
        .join(" ");
  }

  static String getFullName(String ln, String fn, String mn) {
    return '$ln, $fn $mn';
  }

  static String formatDate(DateTime date, bool isPdf) {
    if(isPdf){
      //add_jm() to add time
      return DateFormat.yMMMMd('en_US').add_jm().format(date);
    }
    return DateFormat.yMMMMd('en_US').format(date);
  }
  static String getSpecificValueByDateTime(DateTime dt, String valueToGet){
    switch(valueToGet){
      case AppConstants.year:
        return DateFormat.y('en_US').format(dt);
    }
    return '';
  }

  static int convertStringToInt(String str) => int.parse(str);
  static int getAgeByYear(String bYear){
    int currYear = convertStringToInt(
        getSpecificValueByDateTime(DateTime.now(),AppConstants.year)
    );
    int birthYear = convertStringToInt(bYear);

    return currYear - birthYear;
  }
}
