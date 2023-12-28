import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/screens/forms/personal_details.dart';
import 'package:holy_trinity_healthcare/screens/forms/vital_signs.dart';
import 'package:holy_trinity_healthcare/screens/pdf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../constants/widgets.dart';
import '../utils/utils.dart';
import 'forms/neurological.dart';

class MainForms extends StatefulWidget {
  const MainForms({super.key, required this.title});
  final String title;

  @override
  State<MainForms> createState() => _MainFormsState();
}

class _MainFormsState extends State<MainForms> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final _formKey = GlobalKey<FormState>();
  String form = '';
//Personal Details
  late TextEditingController lName = TextEditingController();
  late TextEditingController fName = TextEditingController();
  late TextEditingController mName = TextEditingController();
  late TextEditingController bDay = TextEditingController();
  late TextEditingController age = TextEditingController();
  late TextEditingController address = TextEditingController();

  // Vital Signs
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

  // Neurological
  late TextEditingController memoryIssues = TextEditingController();
  late TextEditingController psychologicalIssues = TextEditingController();
  late TextEditingController cLeftSidedWeakness = TextEditingController();
  late TextEditingController cRightSidedWeakness = TextEditingController();
  late TextEditingController sinceWhen = TextEditingController();
  late TextEditingController mobility = TextEditingController();
  late TextEditingController aDls = TextEditingController();
  late TextEditingController riskFall = TextEditingController();
  late TextEditingController medicalEquipmentUsed = TextEditingController();
  late TextEditingController safetyUseToDME = TextEditingController();
  late TextEditingController unSafetyUseToME = TextEditingController();
  late TextEditingController reason = TextEditingController();
  late TextEditingController cardiacIssues = TextEditingController();
  late TextEditingController peripheralPulses = TextEditingController();
  late TextEditingController edema = TextEditingController();
  late TextEditingController isDiuretic = TextEditingController();
  late TextEditingController inVDiagnostics = TextEditingController();
  List<TextEditingController> controllerList = [];

  bool isDiminished = false;
  List<String> fieldData = [];

  bool saveForNowEnabled = true;
  String action = '';

  @override
  void initState() {
    super.initState();
    form = widget.title;
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

    memoryIssues.dispose();
    psychologicalIssues.dispose();
    cLeftSidedWeakness.dispose();
    cRightSidedWeakness.dispose();
    sinceWhen.dispose();
    mobility.dispose();
    aDls.dispose();
    riskFall.dispose();
    medicalEquipmentUsed.dispose();
    safetyUseToDME.dispose();
    unSafetyUseToME.dispose();
    reason.dispose();
    cardiacIssues.dispose();
    peripheralPulses.dispose();
    edema.dispose();
    isDiuretic.dispose();
    inVDiagnostics.dispose();
  }

  void setTextEditingControllerList() {
    if (form == AppConstants.vitalSign) {
      setState(() {
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
    } else if (form == AppConstants.neurological) {
      setState(() {
        controllerList = [
          lName,
          fName,
          mName,
          bDay,
          age,
          address,
          memoryIssues,
          psychologicalIssues,
          cLeftSidedWeakness,
          cRightSidedWeakness,
          sinceWhen,
          mobility,
          aDls,
          riskFall,
          medicalEquipmentUsed,
          safetyUseToDME,
          unSafetyUseToME,
          reason,
          cardiacIssues,
          peripheralPulses,
          edema,
          isDiuretic,
          inVDiagnostics
        ];
      });
    }
  }

  //DATA RETRIEVAL
  _retrieveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String value = "";

    if (form == AppConstants.vitalSign) {
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
    } else if (form == AppConstants.neurological) {
      for (int i = 0; i < AppConstants.keysNeurological.length; i++) {
        value = prefs.getString(
                Utils.removeEmptyString(AppConstants.keysNeurological[i])) ??
            '';
        if (Utils.isNotEmpty(value)) {
          setState(() {
            controllerList[i].text = value;
          });
        }
      }
    }

    setFieldData();
  }

  _removeData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = "";
    String key = "";
    List<String> keys = Utils.getKeys(form);
    for (int i = 0; i < keys.length; i++) {
      key = Utils.removeEmptyString(keys[i]);
      value = prefs.getString(key) ?? '';
      if (Utils.isNotEmpty(value)) {
        await prefs.remove(key);
      }
    }
  }

  void setFieldData() {
    if (form == AppConstants.vitalSign) {
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
    } else if (form == AppConstants.neurological) {
      setState(() {
        fieldData = [
          lName.text,
          fName.text,
          mName.text,
          bDay.text,
          age.text,
          address.text,
          memoryIssues.text,
          psychologicalIssues.text,
          cLeftSidedWeakness.text,
          cRightSidedWeakness.text,
          sinceWhen.text,
          mobility.text,
          aDls.text,
          riskFall.text,
          medicalEquipmentUsed.text,
          safetyUseToDME.text,
          unSafetyUseToME.text,
          reason.text,
          cardiacIssues.text,
          peripheralPulses.text,
          edema.text,
          isDiuretic.text,
          inVDiagnostics.text,
        ];
      });
    }
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

    List<String> keys = Utils.getKeys(form);

    for (int i = 0; i < values.length; i++) {
      if (values[i].isNotEmpty) {
        prefs.setString(Utils.removeEmptyString(keys[i]), values[i]);
      }
    }
    prefs.setString(AppConstants.form, form);
  }

  void validateForm() {
    setState(() {
      action = AppConstants.actions[0]; //save
    });
    saveVitalSigns();
    // _removeData();
    //Utils.navigateToScreen(context, const Home());
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
              form: form,
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
              address: address,
          isFormScreen: true,),
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

  Widget neurologicalForms() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PersonalDetails(
              lName: lName,
              fName: fName,
              mName: mName,
              bDay: bDay,
              age: age,
              address: address,
          isFormScreen: true,),
          Neurological(
              memoryIssues: memoryIssues,
              psychologicalIssues: psychologicalIssues,
              cLeftSidedWeakness: cLeftSidedWeakness,
              cRightSidedWeakness: cRightSidedWeakness,
              sinceWhen: sinceWhen,
              mobility: mobility,
              aDls: aDls,
              riskFall: riskFall,
              medicalEquipmentUsed: medicalEquipmentUsed,
              safetyUseToDME: safetyUseToDME,
              unSafetyUseToME: unSafetyUseToME,
              reason: reason,
              cardiacIssues: cardiacIssues,
              peripheralPulses: peripheralPulses,
              edema: edema,
              isDiuretic: isDiuretic,
              inVDiagnostics: inVDiagnostics)
        ],
      );
  Widget retrieveFormFields() {
    switch (widget.title) {
      case AppConstants.vitalSign:
        return vitalSignsForms();
      case AppConstants.neurological:
        return neurologicalForms();
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
                  context, AppConstants.appName, AppConstants.appDescription, false),
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
