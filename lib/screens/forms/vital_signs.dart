import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../../constants/widgets.dart';
import '../../utils/utils.dart';

class VitalSigns extends StatefulWidget{
  const VitalSigns({super.key, required this.temperature, required this.rSystolicArm, required this.rDiastolicArm, required this.lSystolicArm, required this.lDiastolicArm, required this.heartRate, required this.respiratoryRate, required this.diminished, required this.oxygenStats, required this.shortnessOfBreath, required this.oxygenUse, required this.painLevelToday, required this.locationPainLevelToday, required this.painLevelPast, required this.locationPainLevelPast, required this.medicationPlan});

  final TextEditingController temperature;

  final TextEditingController rSystolicArm;
  final TextEditingController rDiastolicArm;
  final TextEditingController lSystolicArm;
  final TextEditingController lDiastolicArm;

  final TextEditingController heartRate;
  final TextEditingController respiratoryRate;
  final TextEditingController diminished;
  final TextEditingController oxygenStats;

  final TextEditingController shortnessOfBreath;
  final TextEditingController oxygenUse;
  final TextEditingController painLevelToday;
  final TextEditingController locationPainLevelToday;

  final TextEditingController painLevelPast;
  final TextEditingController locationPainLevelPast;
  final TextEditingController medicationPlan;

  @override
  State<VitalSigns> createState()=> _VitalSignsState();
}

class _VitalSignsState extends State<VitalSigns>{

  Widget label(String title)=>  Padding(
      padding: const EdgeInsets.only(left:20),
      child: Align(
          alignment: Alignment.centerLeft,
          child:Text(title,
            style:const TextStyle(fontSize: 20),)
      )
  );

  bool isDiminished = false;
  //Dropdown
  Widget customDropdown(String fieldName, TextEditingController controller) {
    List<String> list = Utils.retrieveDropdownListByFieldName(fieldName);
    int getIndex() {
      if (controller.text.isNotEmpty) {
        for (int i = 0; i < list.length; i++) {
          if (controller.text == list[i]) {
            return i;
          }
        }
      }
      return 0;
    }

    void validateVitalSignFields(String value) {
        if (fieldName.contains(AppConstants.respiratoryRate)) {
          isDiminished = false;
          if (value.contains(AppConstants.respiratoryRateList.last)) {
            isDiminished = true;
          }
      }
    }

    Widget dropdownFieldChecker() {
      if (controller.text.isNotEmpty) {
        return DropdownButtonFormField(
          value: list[getIndex()],
          decoration: CustomWidgets.fieldInputDecoration(fieldName),
          items: list.map<DropdownMenuItem<String>>((String val) {
            return DropdownMenuItem<String>(value: val, child: Text(val));
          }).toList(),
          onChanged: (String? value) {
            setState(() {
              validateVitalSignFields(value!);
              controller.text = value;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required.';
            }
            return null;
          },
        );
      }
      return DropdownButtonFormField(
        decoration: CustomWidgets.fieldInputDecoration(fieldName),
        items: list.map<DropdownMenuItem<String>>((String val) {
          return DropdownMenuItem<String>(value: val, child: Text(val));
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            validateVitalSignFields(value!);
            controller.text = value;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required.';
          }
          return null;
        },
      );
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          CustomWidgets.setFormTitle(fieldName),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: dropdownFieldChecker())
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomWidgets.singeTextFormField(
            context, AppConstants.temperature, widget.temperature),
        Column(
          children: [
            CustomWidgets.setFormTitle(AppConstants.bloodPressure),
            //RIGHT ARM
            label(AppConstants.bloodPressureRightArm),
            Row(
              children: [
                SizedBox(
                    width: 250,
                    child:CustomWidgets.customTextFormField(context, AppConstants.systolic, widget.rSystolicArm)
                ),

                SizedBox(
                    width: 250,
                    child:CustomWidgets.customTextFormField(context, AppConstants.diastolic, widget.rDiastolicArm)
                )
              ],
            ),
            //LEFT ARM
            label(AppConstants.bloodPressureLeftArm),
            Row(
              children: [
                SizedBox(
                    width: 250,
                    child:CustomWidgets.customTextFormField(context, AppConstants.systolic, widget.lSystolicArm)
                ),SizedBox(
                    width: 250,
                    child:CustomWidgets.customTextFormField(context, AppConstants.diastolic, widget.lDiastolicArm)
                )
              ],
            )
          ],
        ),
        customDropdown(AppConstants.heartRate, widget.heartRate),

        customDropdown(AppConstants.respiratoryRate, widget.respiratoryRate),
        isDiminished
            ? customDropdown(
            AppConstants.respiratoryRateList.last, widget.diminished)
            : Container(),
        CustomWidgets.singeTextFormField(
            context, AppConstants.oxygenStat, widget.oxygenStats),
        customDropdown(AppConstants.shortOfBreath, widget.shortnessOfBreath),
        customDropdown(AppConstants.oxygenUse, widget.oxygenUse),
        CustomWidgets.painLevelFields(context, AppConstants.painLevelToday,
            widget.painLevelToday, widget.locationPainLevelToday),
        CustomWidgets.painLevelFields(
            context,
            AppConstants.painLevelLastVisit,
            widget.painLevelPast,
            widget.locationPainLevelPast),
        CustomWidgets.medicationPlan(context, widget.medicationPlan),
      ],
    );
  }

}