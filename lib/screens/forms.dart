import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/screens/forms/personalDetails.dart';
import 'package:holy_trinity_healthcare/screens/forms/vital_signs.dart';
import 'package:holy_trinity_healthcare/screens/home.dart';
import 'package:holy_trinity_healthcare/screens/pdf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../constants/widgets.dart';
import '../utils/utils.dart';

class Forms extends StatefulWidget {
  const Forms({super.key, required this.title});
  final String title;

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final _formKey = GlobalKey<FormState>();

  late TextEditingController lName = TextEditingController();
  late TextEditingController fName = TextEditingController();
  late TextEditingController mName = TextEditingController();
  late TextEditingController bDay = TextEditingController();
  late TextEditingController age = TextEditingController();
  late TextEditingController address = TextEditingController();

  late TextEditingController rSystolicArm = TextEditingController();
  late TextEditingController rDiastolicArm = TextEditingController();
  late TextEditingController lSystolicArm = TextEditingController();
  late TextEditingController lDiastolicArm = TextEditingController();

  late TextEditingController heartRate = TextEditingController();
  late TextEditingController respiratoryRate = TextEditingController();
  late TextEditingController diminished = TextEditingController();
  late TextEditingController oxygenStats = TextEditingController();

  late TextEditingController shortnessOfBreath = TextEditingController();
  late TextEditingController oxygenUse = TextEditingController();

  late TextEditingController painLevelToday = TextEditingController();
  late TextEditingController locationPainLevelToday = TextEditingController();
  late TextEditingController painLevelPast = TextEditingController();
  late TextEditingController locationPainLevelPast = TextEditingController();

  late TextEditingController medicationPlan = TextEditingController();
  late TextEditingController temperature = TextEditingController();
  List<TextEditingController> controllerList = [];

  bool isDiminished = false;
  List<String> fieldData = [];

  bool saveForNowEnabled = true;
  String action = '';

  @override
  void initState() {
    super.initState();

    setTextEditingControllerList();
    _retrieveData();
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
    rSystolicArm.dispose();
    rDiastolicArm.dispose();
    lSystolicArm.dispose();
    lDiastolicArm.dispose();
    heartRate.dispose();
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
    temperature.dispose();
  }

  void setTextEditingControllerList() {
    setState(() {
      //TODO
      controllerList = [
        lName,
        fName,
        mName,
        bDay,
        age,
        address,
        temperature,
        rSystolicArm,
        rDiastolicArm,
        lSystolicArm,
        lDiastolicArm,
        heartRate,
        respiratoryRate,
        diminished,
        oxygenStats,
        shortnessOfBreath,
        oxygenUse,
        painLevelToday,
        locationPainLevelToday,
        painLevelPast,
        locationPainLevelPast,
        medicationPlan

      ];
    });
  }

  //DATA RETRIEVAL
  _retrieveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String value = "";
    for (int i = 0; i < AppConstants.keysVitalSigns.length; i++) {
      value = prefs.getString(
              Utils.removeEmptyString(AppConstants.keysVitalSigns[i])) ??
          '';
      if (Utils.isNotEmpty(value)) {
        if (Utils.removeEmptyString(AppConstants.keysVitalSigns[i]) ==
                Utils.removeEmptyString(AppConstants.respiratoryRate) &&
            value == AppConstants.diminished) {
          setState(() {
            isDiminished = true;
          });
        }
        setState(() {
          controllerList[i].text = value;
        });
      }
    }

    setFieldData();
  }

  _removeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = "";
    String key = "";
    for (int i = 0; i < AppConstants.keysVitalSigns.length; i++) {
      key = Utils.removeEmptyString(AppConstants.keysVitalSigns[i]);
      value = prefs.getString(key) ?? '';
      if (Utils.isNotEmpty(value)) {
        await prefs.remove(key);
      }
    }
  }

  void setFieldData() {
    setState(() {
      fieldData = [
        lName.text,
        fName.text,
        mName.text,
        bDay.text,
        age.text,
        address.text,
        temperature.text,
        rSystolicArm.text,
        rDiastolicArm.text,
        lSystolicArm.text,
        lDiastolicArm.text,
        heartRate.text,
        respiratoryRate.text,
        diminished.text,
        oxygenStats.text,
        shortnessOfBreath.text,
        oxygenUse.text,
        painLevelToday.text,
        locationPainLevelToday.text,
        painLevelPast.text,
        locationPainLevelPast.text,
        medicationPlan.text,
      ];
    });
  }

  void saveVitalSigns() {
    setFieldData();

    //set the [save for now] button to disabled to prevent users to click Save button multiple times in a row.
    setState(() {
      saveForNowEnabled = false;
    });
    Future.delayed(const Duration(seconds: 4), () {
      //enabled the button after 4 seconds
      setState(() {
        saveForNowEnabled = true;
      });
    });

    if (Utils.isListNotEmpty(fieldData)) {
      // CustomWidgets.showSnackBar(context, AppConstants.saving);
      saveDataToSharedPref(fieldData);
    } else {
      if (action == AppConstants.actions[0]) {
        CustomWidgets.showSnackBar(context, AppConstants.nothingToSave);
      }
    }
  }

  Future<void> saveDataToSharedPref(List<String> values) async {
    final SharedPreferences prefs = await _prefs;

    if (AppConstants.keysVitalSigns.length == values.length) {
      for (int i = 0; i < values.length; i++) {
        if (values[i].isNotEmpty) {
          prefs.setString(
              Utils.removeEmptyString(AppConstants.keysVitalSigns[i]),
              values[i]);
        }
      }
    }
  }

  void validateForm() {
    setState(() {
      action = AppConstants.actions[0]; //save
    });
    saveVitalSigns();
    // _removeData();
    Utils.navigateToScreen(context, const Home());
  }

  void convertToPdf() {
    setState(() {
      action = AppConstants.actions[1]; //submit
    });

    if (_formKey.currentState!.validate()) {
      saveVitalSigns();
      if (Utils.isListNotEmpty(fieldData)) {
        Utils.navigateToScreen(
            context,
            PdfViewer(
              data: fieldData,
            ));
        _removeData();
      }
    }
  }

  Widget vitalSignsForms() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PersonalDetails(
              lName: lName,
              fName: fName,
              mName: mName,
              bDay: bDay,
              age: age,
              address: address),
          VitalSigns(
              temperature: temperature,
              rSystolicArm: rSystolicArm,
              rDiastolicArm: rDiastolicArm,
              lSystolicArm: lSystolicArm,
              lDiastolicArm: lDiastolicArm,
              heartRate: heartRate,
              respiratoryRate: respiratoryRate,
              diminished: diminished,
              oxygenStats: oxygenStats,
              shortnessOfBreath: shortnessOfBreath,
              oxygenUse: oxygenUse,
              painLevelToday: painLevelToday,
              locationPainLevelToday: locationPainLevelToday,
              painLevelPast: painLevelPast,
              locationPainLevelPast: locationPainLevelPast,
              medicationPlan: medicationPlan)
        ],
      );

  Widget retrieveFormFields() {
    if (widget.title.contains(AppConstants.vitalSign)) {
      return vitalSignsForms();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
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
              SafeArea(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 50),
                      child: Form(key: _formKey, child: retrieveFormFields())))
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomWidgets.customButton(context, AppConstants.saveForNow,
                  validateForm, saveForNowEnabled),
              CustomWidgets.customButton(
                  context, AppConstants.submit, convertToPdf, true),
            ],
          ),
        ));
  }
}
