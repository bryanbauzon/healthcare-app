
import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/app_constants.dart';
import 'package:holy_trinity_healthcare/constants/widgets.dart';
import 'package:holy_trinity_healthcare/screens/forms.dart';

class Utils{

  //Reference: https://api.flutter.dev/flutter/material/Icons-class.html
  static IconData documentTilesIcon(String title){
    if (title.contains(AppConstants.vitalSign)) {
      return Icons.monitor_heart_outlined;
    }
    return Icons.account_tree_outlined;
  }
  
  static void redirectToForms(BuildContext context,String title){
    if (title.contains(AppConstants.vitalSign)) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  Forms(title: title)));
    } else {
      CustomWidgets.showSnackBar(context, AppConstants.comingSoon);
    }
  }

  static TextInputType getTextInputTypeByField(String field){
    TextInputType type = TextInputType.text;
    if(field.contains(AppConstants.age)){
       type = TextInputType.number;
    }else if(field.contains(AppConstants.birthday)){
      type = TextInputType.datetime;
    }
    return type;
  }
}