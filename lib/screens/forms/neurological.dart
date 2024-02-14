import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/widgets.dart';

import '../../constants/app_constants.dart';
import '../../constants/colors.dart';
import '../../utils/utils.dart';

class Neurological extends StatefulWidget {
  const Neurological(
      {super.key,
      required this.memoryIssues,
      required this.psychologicalIssues,
      required this.cLeftSidedWeakness,
      required this.cRightSidedWeakness,
      required this.sinceWhen,
      required this.mobility,
      required this.aDls,
      required this.riskFall,
      required this.medicalEquipmentUsed,
      required this.dmeStatus,
      required this.reason,
      required this.cardiacIssues,
      required this.peripheralPulses,
      required this.edema,
      required this.isDiuretic,
      required this.inVDiagnostics});

  final TextEditingController memoryIssues;
  final TextEditingController psychologicalIssues;
  final TextEditingController cLeftSidedWeakness;
  final TextEditingController cRightSidedWeakness;
  final TextEditingController sinceWhen;
  final TextEditingController mobility;
  final TextEditingController aDls;
  final TextEditingController riskFall;
  final TextEditingController medicalEquipmentUsed;
  final TextEditingController dmeStatus;

  final TextEditingController reason;
  final TextEditingController cardiacIssues;
  final TextEditingController peripheralPulses;
  final TextEditingController edema;
  final TextEditingController isDiuretic;
  final TextEditingController inVDiagnostics;
  @override
  State<Neurological> createState() => _NeurologicalState();
}

class _NeurologicalState extends State<Neurological> {
  DateTime selectedDate = DateTime.now();
  String selectedDateStr = 'Retrieving data...';
  bool isDiminished = false;
  bool showReason = false;
  bool isPhone = Utils.isMobile();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      if (widget.sinceWhen.text.isNotEmpty) {
        setState(() {
          selectedDateStr = widget.sinceWhen.text;
        });
      } else {
        setState(() {
          selectedDateStr = AppConstants.selectDate;
        });
      }

      showReason =
          AppConstants.dmeStatusList[1].contains(widget.dmeStatus.text);
      if (!showReason) {
        setState(() {
          widget.reason.text = '';
        });
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1960, 8),
        lastDate: DateTime(DateTime.now().year + 1));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        selectedDateStr = Utils.formatDate(selectedDate, false);
        widget.sinceWhen.text = selectedDateStr;
      });
    }
  }

  Widget label(String label) => Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: (label == AppConstants.sob) ? Colors.red : Colors.black),
        ),
      );

  //Dropdown
  Widget customDropdown(String fieldName, TextEditingController controller) {
    bool isPhone = Utils.isMobile();
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

    bool dMEStatusChecker(String value) =>
        value.contains(AppConstants.dmeStatusList.last);

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
              showReason = dMEStatusChecker(value);
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
            showReason = dMEStatusChecker(value);
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
      child: SizedBox(
        width: isPhone ? MediaQuery.of(context).size.width : 320,
        child: Column(
          children: [
            CustomWidgets.setFormTitle(fieldName),
            Padding(
                padding: EdgeInsets.only(
                    left: isPhone ? 10 : 20, right: isPhone ? 10 : 20, top: 10),
                child: dropdownFieldChecker())
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomWidgets.customTextArea(
            context, AppConstants.memoryIssuesPlaceholder, widget.memoryIssues),
        CustomWidgets.customTextArea(context, AppConstants.psychologicalIssues,
            widget.psychologicalIssues),
        CustomWidgets.multipleTextField(context, AppConstants.cva,
            widget.cLeftSidedWeakness, widget.cRightSidedWeakness),
        Padding(
          padding: AppConstants.formPadding,
          child: Row(
            children: [
              label(AppConstants.sinceWhen),
              ElevatedButton(
                  onPressed: () => _selectDate(context),
                  style: ButtonStyle(foregroundColor:
                      MaterialStateProperty.resolveWith((states) {
                    return AppColors.theme;
                  })),
                  child: Text(selectedDateStr)),
            ],
          ),
        ),
        customDropdown(AppConstants.mobility, widget.mobility),
        CustomWidgets.customTextArea(context, AppConstants.adl, widget.aDls),
        customDropdown(AppConstants.riskFall, widget.riskFall),
        CustomWidgets.customTextArea(
            context, AppConstants.dme, widget.medicalEquipmentUsed),
        customDropdown(AppConstants.dmeStatus, widget.dmeStatus),
        // CustomWidgets.singeTextFormField(
        //     context, AppConstants.safetyUseOfDME, widget.safetyUseToDME),
        // CustomWidgets.singeTextFormField(
        //     context, AppConstants.unSafetyUseOfDME, widget.unSafetyUseToME),
        showReason
            ? CustomWidgets.customTextArea(
                context, AppConstants.reason, widget.reason)
            : Container(),
        CustomWidgets.singeTextFormField(
            context, AppConstants.cardiacIssues, widget.cardiacIssues),
        CustomWidgets.singeTextFormField(
            context, AppConstants.peripheralPulses, widget.peripheralPulses),
        CustomWidgets.customTextArea(context, AppConstants.edema, widget.edema),
        customDropdown(AppConstants.diuretic, widget.isDiuretic),
        CustomWidgets.customTextArea(
            context, AppConstants.ivd, widget.inVDiagnostics),
        label(AppConstants.sob)
      ],
    );
  }
}
