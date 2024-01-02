import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/app_constants.dart';
import 'package:intl/intl.dart';

class Utils {
  //Reference: https://api.flutter.dev/flutter/material/Icons-class.html
  static IconData documentTilesIcon(String title) {
    if (title.contains(AppConstants.vitalSign)) {
      return Icons.monitor_heart_outlined;
    } else if (title.contains(AppConstants.neurological)) {
      return Icons.document_scanner;
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

  static int maxLinesByLabel(String label) {
    switch (label) {

      case AppConstants.psychologicalIssues ||
           AppConstants.memoryIssuesPlaceholder ||
           AppConstants.medicationPlan:
        return 7;
      case AppConstants.dme ||
           AppConstants.reason :
        return 3;
      case AppConstants.edema ||
           AppConstants.ivd:
        return 4;
    }
    return 1;
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
      case AppConstants.painLevelToday ||
           AppConstants.painLevelLastVisit:{
       for(var i = 1; i <= 10; i++){
         list.add(i.toString());
       }
      }
      case AppConstants.mobility || AppConstants.riskFall || AppConstants.diuretic:
        return AppConstants.yesOrNo;
      case AppConstants.dmeStatus:
        return AppConstants.dmeStatusList;
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
    if (isPdf) {
      //add_jm() to add time
      return DateFormat.yMMMMd('en_US').add_jm().format(date);
    }
    return DateFormat.yMMMMd('en_US').format(date);
  }

  static int getSpecificValueByDateTime(DateTime dt, String valueToGet) {
    switch (valueToGet) {
      case AppConstants.year:
        return int.parse(DateFormat.y('en_US').format(dt));
      case AppConstants.month:
        return int.parse(DateFormat('M').format(dt));
      case AppConstants.day:
        return int.parse(DateFormat('d').format(dt));
    }
    return 0;
  }

  static int convertStringToInt(String str) => int.parse(str);
  static int getAgeByBirthdate(DateTime bDate) {
    DateTime now = DateTime.now();
    int currMonth = getSpecificValueByDateTime(now, AppConstants.month);
    int currDay = getSpecificValueByDateTime(now, AppConstants.day);
    int currYear = getSpecificValueByDateTime(now, AppConstants.year);

    int birthMonth = getSpecificValueByDateTime(bDate, AppConstants.month);
    int birthDay = getSpecificValueByDateTime(bDate, AppConstants.day);
    int birthYear = getSpecificValueByDateTime(bDate, AppConstants.year);

    if (birthYear < currYear) {
      if (currMonth > birthMonth) {
        return currYear - birthYear;
      } else if (currMonth == birthMonth) {
        if (birthDay > currDay) {
          return (currYear - birthYear) - 1;
        }
        return currYear - birthYear;
      }
    }
    return 0;
  }

  static String ageFormatter(String age) {
    if (convertStringToInt(age) > 1) {
      return '$age years old.';
    }
    return '$age year old.';
  }

  static List<String> getKeys(String form) {
    switch (form) {
      case AppConstants.vitalSign:
        return AppConstants.keysVitalSigns;
      case AppConstants.neurological:
        return AppConstants.keysNeurological;
    }

    return [];
  }
}
