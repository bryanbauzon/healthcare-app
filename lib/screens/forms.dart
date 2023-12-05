import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../constants/widgets.dart';
import '../utils/utils.dart';
import 'home.dart';

class Forms extends StatefulWidget {
  const Forms({super.key, required this.title});
  final String title;

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final _formKey = GlobalKey<FormState>();

  final lName = TextEditingController();
  final fName = TextEditingController();
  final mName = TextEditingController();
  final bDay = TextEditingController();
  final age = TextEditingController();
  final address = TextEditingController();

  final rightArm = TextEditingController();
  final leftArm = TextEditingController();

  final hearRate = TextEditingController();
  final respiratoryRate = TextEditingController();
  final diminished = TextEditingController();
  final oxygenStats = TextEditingController();

  final shortnessOfBreath = TextEditingController();
  final oxygenUse = TextEditingController();

  final painLevelToday = TextEditingController();
  final locationPainLevelToday = TextEditingController();
  final painLevelPast = TextEditingController();
  final locationPainLevelPast = TextEditingController();

  final medicationPlan = TextEditingController();

  List<TextEditingController> controllerList = [];
  @override
  void initState() {
    super.initState();
    setTextEditingControllerList();
    _retrieveData();
  }

  void setTextEditingControllerList(){
    controllerList.add(lName);
    controllerList.add(fName);
    controllerList.add(mName);
    controllerList.add(bDay);
    controllerList.add(age);
    controllerList.add(address);

    controllerList.add(rightArm);
    controllerList.add(leftArm);
    controllerList.add(hearRate);
    controllerList.add(respiratoryRate);
    controllerList.add(diminished);
    controllerList.add(oxygenStats);
    controllerList.add(shortnessOfBreath);
    controllerList.add(oxygenUse);
    controllerList.add(painLevelToday);
    controllerList.add(locationPainLevelToday);

    controllerList.add(painLevelPast);
    controllerList.add(locationPainLevelPast);

    controllerList.add(medicationPlan);
  }

  _retrieveData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String value = "";
    for(int i = 0; i < AppConstants.keysVitalSigns.length; i++){
        value = prefs.getString(AppConstants.keysVitalSigns[i].replaceAll(' ', '')) ?? '';
        if(Utils.isNotEmpty(value)){
          controllerList[i].text = value;
        }
    }
  }

  _removeData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = "";
    String key = "";
    for(int i = 0; i < AppConstants.keysVitalSigns.length; i++){
      key = AppConstants.keysVitalSigns[i].replaceAll(' ', '');
      value = prefs.getString(key) ?? '';
      if(Utils.isNotEmpty(value)){
        await prefs.remove(key);
      }
    }
  }

  void saveVitalSigns() {
    String lastNameStr = lName.text;
    String firstNameStr = fName.text;
    String middleNameStr = mName.text;
    String birthdayStr = bDay.text;
    String ageStr = age.text;
    String addressStr = address.text;

    String rightArmStr = rightArm.text;
    String leftArmStr = leftArm.text;
    String heartRateStr = hearRate.text;
    String respiratoryRateStr = respiratoryRate.text;

    String diminishedStr = diminished.text;
    String oxygenStatsStr = oxygenStats.text;
    String painLevelTodayStr = painLevelToday.text;
    String locationPainLevelTodayStr = locationPainLevelToday.text;
    String painLevelPastStr = painLevelPast.text;
    String locationPainLevelPastStr = locationPainLevelPast.text;
    String medicationPlanStr = medicationPlan.text;
    String shortnessOfBreathStr = shortnessOfBreath.text;
    String oxygenUseStr = oxygenUse.text;

    List<String> values = [
      lastNameStr,
      firstNameStr,
      middleNameStr,
      birthdayStr,
      ageStr,
      addressStr,
      rightArmStr,
      leftArmStr,
      heartRateStr,
      respiratoryRateStr,
      diminishedStr,
      oxygenStatsStr,
      shortnessOfBreathStr,
      oxygenUseStr,
      painLevelTodayStr,
      locationPainLevelTodayStr,
      painLevelPastStr,
      locationPainLevelPastStr,
      medicationPlanStr,
    ];

    if (Utils.isListNotEmpty(values)) {
      saveDataToSharedPref(values);
    }else{
      CustomWidgets.showSnackBar(context, AppConstants.nothingToSave);
    }
  }

  bool isDiminished = false;

  Future<void> saveDataToSharedPref(List<String> values)async{
    final SharedPreferences prefs = await _prefs;

    if(AppConstants.keysVitalSigns.length == values.length){

      for(int i = 0 ; i < values.length; i++){
        if(values[i].isNotEmpty){
          prefs.setString(AppConstants.keysVitalSigns[i].replaceAll(' ', ''), values[i]);
        }
      }

    }
  }

  @override
  void dispose() {
    super.dispose();

    lName.dispose();
    fName.dispose();
    mName.dispose();
    bDay.dispose();
    age.dispose();
    address.dispose();
    rightArm.dispose();
    leftArm.dispose();
    hearRate.dispose();
    respiratoryRate.dispose();
    diminished.dispose();
    shortnessOfBreath.dispose();
    oxygenUse.dispose();
    painLevelToday.dispose();
    locationPainLevelToday.dispose();
    painLevelPast.dispose();
    locationPainLevelPast.dispose();
    medicationPlan.dispose();
    oxygenStats.dispose();
  }

  void validateForm() {
    saveVitalSigns();
    CustomWidgets.showSnackBar(context, AppConstants.saving);
    // Navigator.pop(context);
    //  if (_formKey.currentState!.validate()) {
    //
    //    ScaffoldMessenger.of(context).showSnackBar(
    //      const SnackBar(content: Text('Processing Data')),
    //    );
    //  }
  }

  @override
  Widget build(BuildContext context) {
    Widget customDropdown(String fieldName, TextEditingController controller) {
      List<String> list = Utils.retrieveDropdownListByFieldName(fieldName);
      return Align(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            CustomWidgets.setFormTitle(fieldName),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: DropdownButtonFormField(
                decoration: CustomWidgets.fieldInputDecoration(fieldName),
                items: list.map<DropdownMenuItem<String>>((String val) {
                  return DropdownMenuItem<String>(value: val, child: Text(val));
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    if (fieldName.contains(AppConstants.respiratoryRate)) {
                      isDiminished = false;
                      if (value!
                          .contains(AppConstants.respiratoryRateList.last)) {
                        isDiminished = true;
                      }
                    }

                    controller.text = value!;
                  });
                },
                validator: (value) {
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
    }

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomWidgets.customAppBar(
                  context, AppConstants.appName, AppConstants.appDescription),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: AppConstants.headerFontSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomWidgets.personalInfo(
                            context, lName, fName, mName, bDay, age, address),
                        CustomWidgets.bloodPressure(context, rightArm, leftArm),
                        customDropdown(AppConstants.heartRate, hearRate),
                        customDropdown(
                            AppConstants.respiratoryRate, respiratoryRate),
                        isDiminished
                            ? customDropdown(
                                AppConstants.respiratoryRateList.last,
                                diminished)
                            : Container(),
                        CustomWidgets.oxygenStats(context, oxygenStats),
                        customDropdown(
                            AppConstants.shortOfBreath, shortnessOfBreath),
                        customDropdown(AppConstants.oxygenUse, oxygenUse),
                        CustomWidgets.painLevelFields(
                            context,
                            AppConstants.painLevelToday,
                            painLevelToday,
                            locationPainLevelToday),
                        CustomWidgets.painLevelFields(
                            context,
                            AppConstants.painLevelLastVisit,
                            painLevelPast,
                            locationPainLevelPast),
                        CustomWidgets.medicationPlan(context, medicationPlan),
                      ],
                    ),
                  ))
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomWidgets.customButton(context, AppConstants.saveForNow, validateForm),
              CustomWidgets.customButton(
                  context, AppConstants.submit, (){
                _removeData();
                Utils.navigateToScreen(context, const Home());
              }),
            ],
          ),
        ));
  }
}
