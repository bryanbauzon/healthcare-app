import 'package:flutter/material.dart';

class AppConstants {
  static const String logo = 'images/logo.png';
  static const String splash = 'images/splashScreen.png';
  static const String greetings = 'WELCOME!';
  static const String appName = 'Holy Trinity Healthcare ';
  static const String appDescription =
      'Meeting the needs of today' 's patients at home';

  static const String forms = 'Forms';

  static const String saveForNow = 'Save For Now';
  static const String submit = 'Submit';
  static const String nursesDocument = 'NURSES DOCUMENT';
  static const String dummyDescriptionShort =
      'Compiled nurses document for new patient care';
  static const String appDescriptionDetailed =
      'The HIPAA Privacy Rule requires appropriate safeguards to protect the privacy of protected health information and sets limits and conditions on the uses and disclosures that may be made of such information without an authorization.';
  static const String comingSoon = 'COMING SOON!';

  static const String vitalSign = 'VITAL SIGNS';

  static const String personalInfo = 'Personal Info';
  //Fields
  static const String fName = 'First name';
  static const String mName = 'Middle name';
  static const String lName = 'Last name';
  static const String birthday = 'Birthday';
  static const String age = 'Age';
  static const String address = 'Address';
  static const String temperature = 'Temperature';
  static const String painLevelToday = 'Pain Level Today';
  static const String bodyLocationToday = 'Location of Pain';
  static const String painLevelLastVisit = 'Pain Level Last Visit';
  static const String bodyLocationTLastVisit = 'Location of Pain Last Visit';
  static const String medicationPlan = 'Medication Plan';
  static const String oxygenStat = 'Oxygen Status';

  static const double headerFontSize = 40;
  static const double menuTitleFontSize = 30;
  static const double formTitle = 25;

  static const List<String> typeInputNumberList = <String>[
    age,
    systolic,
    diastolic,
    oxygenStat,
    birthday,
    temperature
  ];
  static const List<String> keysVitalSigns = [
    lName,
    fName,
    mName,

    birthday,
    age,
    address,
    temperature,
    'rSystolicArm',
    'rDiastolicArm',
    'lSystolicArm',
    'lDiastolicArm',
    heartRate,
    respiratoryRate,
    diminished,
    oxygenStat,
    shortOfBreath,
    oxygenUse,
    painLevelToday,
    bodyLocationToday,
    painLevelLastVisit,
    bodyLocationTLastVisit,
    medicationPlan
  ];

  static const String bloodPressure = 'Blood Pressure';
  static const String bloodPressureRightArm = 'Right Arm';
  static const String bloodPressureLeftArm = 'Left Arm';
  static const String systolic = 'Systolic';
  static const String diastolic = 'Diastolic';

  static const String respiratoryRate = 'Respiratory Rate';
  static const List<String> respiratoryRateList = <String>[
    'Within Normal Limits',
    'Labored',
    'Wheezing',
    'Rales',
    'Diminished'
  ];
  static const String diminished = 'Diminished';
  static const List<String> diminishedList = <String>[
    'Right Upper Lobe',
    'Right Middle Lobe',
    'Right Lower Lobe',
    'Left Upper Lobe',
    'Left Middle Lobe',
    'Left Lower Lobe'
  ];

  static const String shortOfBreath = 'Shortness Of Breath';
  static const List<String> shortOfBreathList = <String>[
    'Minimal',
    'Moderate',
    'At Rest'
  ];

  static const String oxygenUse = 'Oxygen Use';
  static const List<String> oxygenUseList = <String>[
    'Continues',
    'Intermittent'
  ];

  static const String heartRate = 'Heart Rate';
  static const List<String> heartRateList = <String>['Regular', 'Irregular'];

  static const String saving = 'Saving...';
  static const String nothingToSave = 'There is nothing to save...';
  static const List<String> actions = ['save','submit'];

  static const String month = 'month';
  static const String day = 'day';
  static const String year = 'year';

  static const String selectDate = 'Select Date';

  static const EdgeInsetsGeometry formPadding =  EdgeInsets.all(10);
}
