
import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/app_constants.dart';


class Utils{

  //Reference: https://api.flutter.dev/flutter/material/Icons-class.html
  static IconData documentTilesIcon(String title){
    if (title.contains(AppConstants.vitalSign)) {
      return Icons.monitor_heart_outlined;
    }
    return Icons.account_tree_outlined;
  }
  
  static void navigateToScreen(BuildContext context,Widget widget){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  widget));
  }

  static TextInputType getTextInputTypeByField(String field){
    TextInputType type = TextInputType.text;
    if(AppConstants.typeInputNumberList.contains(field)){
       type = TextInputType.number;
    }
    return type;
  }

  static List<String> retrieveDropdownListByFieldName(String fieldName){
    List<String> list = [];
      switch(fieldName){
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

  static bool isNotEmpty(String data){
    return data.trim().isNotEmpty;
  }

  static bool isListNotEmpty(List<String> list){
    for(String str in list){
      if(isNotEmpty(str)){
        return true;
      }
    }
    return false;
  }

}