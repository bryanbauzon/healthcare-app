import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../constants/colors.dart';
import '../constants/widgets.dart';
import '../utils/utils.dart';

class Forms extends StatefulWidget {

  const Forms({super.key, required this.title});
  final String title;

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  final _formKey = GlobalKey<FormState>();
  bool isDiminished = false;
  void validateForm(){
    Navigator.pop(context);
   //  if (_formKey.currentState!.validate()) {
   //
   //    ScaffoldMessenger.of(context).showSnackBar(
   //      const SnackBar(content: Text('Processing Data')),
   //    );
   //  }
  }
  @override
  Widget build(BuildContext context) {

   Widget customDropdown(String fieldName){
     List<String> list = Utils.retrieveDropdownListByFieldName(fieldName);
     return  Align(
         alignment: Alignment.centerLeft,
         child:  Column(
           children: [
             CustomWidgets.setFormTitle(fieldName),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child:  DropdownButtonFormField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppColors.theme
                            )
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.theme,
                          ),
                        ),
                      ),
                      hint: Text(fieldName),
                      items: list.map<DropdownMenuItem<String>>((String val){
                        return DropdownMenuItem<String>
                          (value: val, child: Text(val));
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                        if(fieldName.contains(AppConstants.respiratoryRate)){
                          isDiminished = false;
                          if(value!.contains(AppConstants.respiratoryRateList.last)){
                            isDiminished = true;
                          }
                        }
                        });
                      },
                      validator: (value){
                        if (value == null || value.isEmpty) {
                          return 'This field is required.';
                        }
                        return null;
                      },
              ),
            )
           ],

       ),
     );
   };


    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomWidgets.customAppBar(context, AppConstants.appName,
                  AppConstants.appDescription),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  widget.title,
                  style:const TextStyle(fontSize: AppConstants.headerFontSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 50),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomWidgets.personalInfo(context),
                        CustomWidgets.bloodPressure(context),
                        customDropdown(AppConstants.heartRate),
                        customDropdown(AppConstants.respiratoryRate),
                        isDiminished? customDropdown(AppConstants.respiratoryRateList.last):Container(),

                        CustomWidgets.oxygenStats(context),
                        customDropdown(AppConstants.sortOfBreath),
                        customDropdown(AppConstants.oxygenUse),

                        CustomWidgets.painLevelFields(context, AppConstants.painLevelToday),
                        CustomWidgets.painLevelFields(context, AppConstants.painLevelLastVisit),
                        CustomWidgets.medicationPlan(context),
                      ],
                    )
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomWidgets.customButton(
                  context, AppConstants.saveForNow, () {
                    Navigator.of(context).pop();
                    CustomWidgets.showSnackBar(context, AppConstants.saving);
              }),
              CustomWidgets.customButton(context, AppConstants.submit,validateForm),
            ],
          ),
        ));
  }
}
