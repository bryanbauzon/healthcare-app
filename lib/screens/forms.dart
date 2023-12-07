import 'package:flutter/material.dart';
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

  late TextEditingController rightArm = TextEditingController();
  late TextEditingController leftArm = TextEditingController();

  late TextEditingController hearRate = TextEditingController();
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
    temperature.dispose();
  }

  void setTextEditingControllerList() {
    setState(() {
      controllerList = [
        lName,
        fName,
        mName,
        bDay,
        age,
        address,
        rightArm,
        leftArm,
        hearRate,
        respiratoryRate,
        diminished,
        oxygenStats,
        shortnessOfBreath,
        oxygenUse,
        painLevelToday,
        locationPainLevelToday,
        painLevelPast,
        locationPainLevelPast,
        medicationPlan,
        temperature
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

  void setFieldData(){
    setState(() {
      fieldData = [
        lName.text,
        fName.text,
        mName.text,
        bDay.text,
        age.text,
        address.text,
        temperature.text,
        rightArm.text,
        leftArm.text,
        hearRate.text,
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
    Future.delayed(const Duration(seconds:4),(){
      //enabled the button after 4 seconds
      setState(() {
        saveForNowEnabled = true;
      });
    });

    if (Utils.isListNotEmpty(fieldData)) {
      // CustomWidgets.showSnackBar(context, AppConstants.saving);
      saveDataToSharedPref(fieldData);
    } else {
     if(action == AppConstants.actions[0]){
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
      action = AppConstants.actions[0];//save
    });
    saveVitalSigns();
  }

  void convertToPdf() {
    setState(() {
      action = AppConstants.actions[1];//submit
    });

    if (_formKey.currentState!.validate()) {
      saveVitalSigns();
      if (Utils.isListNotEmpty(fieldData)) {
        Utils.navigateToScreen(
            context,
            PdfViewer(
              data: fieldData,
            ));
       _removeData();// <- uncomment this line to destroy the data
      }
    }
  }

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
      if (widget.title.contains(AppConstants.vitalSign)) {
        if (fieldName.contains(AppConstants.respiratoryRate)) {
          isDiminished = false;
          if (value.contains(AppConstants.respiratoryRateList.last)) {
            isDiminished = true;
          }
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

  Widget vitalSignsForms() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomWidgets.personalInfo(
              context, lName, fName, mName, bDay, age, address),
          CustomWidgets.singeTextFormField(context, AppConstants.temperature,temperature),
          CustomWidgets.bloodPressure(context, rightArm, leftArm),
          customDropdown(AppConstants.heartRate, hearRate),
          customDropdown(AppConstants.respiratoryRate, respiratoryRate),
          isDiminished
              ? customDropdown(
                  AppConstants.respiratoryRateList.last, diminished)
              : Container(),
          CustomWidgets.singeTextFormField(context,AppConstants.oxygenUse, oxygenStats),
          customDropdown(AppConstants.shortOfBreath, shortnessOfBreath),
          customDropdown(AppConstants.oxygenUse, oxygenUse),
          CustomWidgets.painLevelFields(context, AppConstants.painLevelToday,
              painLevelToday, locationPainLevelToday),
          CustomWidgets.painLevelFields(
              context,
              AppConstants.painLevelLastVisit,
              painLevelPast,
              locationPainLevelPast),
          CustomWidgets.medicationPlan(context, medicationPlan),
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
              Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 50),
                  child: Form(key: _formKey, child: retrieveFormFields()))
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomWidgets.customButton(
                  context, AppConstants.saveForNow, validateForm,saveForNowEnabled),
              CustomWidgets.customButton(
                  context, AppConstants.submit, convertToPdf, true),
            ],
          ),
        ));
  }
}
