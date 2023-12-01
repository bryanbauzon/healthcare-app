
import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/strings.dart';
import 'package:holy_trinity_healthcare/constants/widgets.dart';
import 'package:holy_trinity_healthcare/screens/forms.dart';

class Utils{

  //Reference: https://api.flutter.dev/flutter/material/Icons-class.html
  static IconData documentTilesIcon(String title){
    if (title.contains(StringConstants.vitalSign)) {
      return Icons.monitor_heart_outlined;
    }
    return Icons.account_tree_outlined;
  }
  
  static void redirectToForms(BuildContext context,String title){
    if (title.contains(StringConstants.vitalSign)) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  Forms(title: title)));
    } else {
      CustomWidgets.showSnackBar(context, StringConstants.comingSoon);
    }
  }

  static TextInputType getTextInputTypeByField(String field){
    TextInputType type = TextInputType.text;
    if(field.contains(StringConstants.age)){
       type = TextInputType.number;
    }else if(field.contains(StringConstants.birthday)){
      type = TextInputType.datetime;
    }
    return type;
  }
}