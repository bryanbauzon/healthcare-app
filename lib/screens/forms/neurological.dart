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
      required this.safetyUseToDME,
      required this.unSafetyUseToME,
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
  final TextEditingController safetyUseToDME;
  final TextEditingController unSafetyUseToME;
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
  String selectedDateStr = '';

  @override
  void initState() {
    super.initState();
    selectedDateStr = AppConstants.selectDate;
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
        CustomWidgets.singeTextFormField(
            context, AppConstants.mobility, widget.mobility),
        CustomWidgets.customTextArea(context, AppConstants.adl, widget.aDls),
        CustomWidgets.singeTextFormField(
            context, AppConstants.riskFall, widget.riskFall),
        CustomWidgets.customTextArea(
            context, AppConstants.dme, widget.medicalEquipmentUsed),
        CustomWidgets.singeTextFormField(
            context, AppConstants.safetyUseOfDME, widget.safetyUseToDME),
        CustomWidgets.singeTextFormField(
            context, AppConstants.unSafetyUseOfDME, widget.unSafetyUseToME),
        CustomWidgets.customTextArea(
            context, AppConstants.reason, widget.reason),
        CustomWidgets.singeTextFormField(
            context, AppConstants.cardiacIssues, widget.cardiacIssues),
        CustomWidgets.singeTextFormField(
            context, AppConstants.peripheralPulses, widget.peripheralPulses),
        CustomWidgets.customTextArea(context, AppConstants.edema, widget.edema),
        CustomWidgets.singeTextFormField(
            context, AppConstants.diuretic, widget.isDiuretic),
        CustomWidgets.singeTextFormField(
            context, AppConstants.ivd, widget.inVDiagnostics),
        label(AppConstants.sob)
      ],
    );
  }
}
