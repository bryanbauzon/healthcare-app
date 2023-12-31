import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/colors.dart';

import '../../constants/app_constants.dart';
import '../../constants/widgets.dart';
import '../../utils/utils.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails(
      {super.key,
      required this.lName,
      required this.fName,
      required this.mName,
      required this.bDay,
      required this.age,
      required this.address,
      required this.isFormScreen});

  final TextEditingController lName;
  final TextEditingController fName;
  final TextEditingController mName;
  final TextEditingController bDay;
  final TextEditingController age;
  final TextEditingController address;
  final bool isFormScreen;
  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  DateTime selectedDate = DateTime.now();
  bool isSelected = false;
  String displayMessage = 'Retrieving data...';

  bool isPhone = Utils.isMobile();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (widget.bDay.text.isNotEmpty) {
        int i = isPhone ? 4 : 5;
        setState(() {
          isSelected = true;
          displayMessage = widget.bDay.text;

          widget.age.text = Utils.getAgeByBirthYear(int.parse(
                  widget.bDay.text.substring(widget.bDay.text.length - i)))
              .toString();
        });
      } else {
        setState(() {
          displayMessage = AppConstants.selectDate;
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

        isSelected = true;
        widget.bDay.text = Utils.formatDate(selectedDate, false);
        widget.age.text = Utils.getAgeByBirthYear(int.parse(
                widget.bDay.text.substring(widget.bDay.text.length - 5)))
            .toString();
      });
    }
  }

  Widget label(String label) => Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Text(
          '$label:',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomWidgets.setFormTitle(AppConstants.personalInfo),
        isPhone
            ? Column(
                children: [
                  CustomWidgets.customTextFormField(
                    context,
                    AppConstants.lName,
                    widget.lName,
                  ),
                  CustomWidgets.customTextFormField(
                      context, AppConstants.fName, widget.fName),
                  CustomWidgets.customTextFormField(
                      context, AppConstants.mName, widget.mName),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: CustomWidgets.customTextFormField(
                        context, AppConstants.lName, widget.lName),
                  ),
                  Expanded(
                    child: CustomWidgets.customTextFormField(
                        context, AppConstants.fName, widget.fName),
                  ),
                  Expanded(
                    child: CustomWidgets.customTextFormField(
                        context, AppConstants.mName, widget.mName),
                  )
                ],
              ),
        widget.isFormScreen
            ? (isPhone
                ? Padding(
                    padding: AppConstants.formPadding,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            label(AppConstants.birthday),
                            ElevatedButton(
                                onPressed: () => _selectDate(context),
                                style: ButtonStyle(foregroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  return AppColors.theme;
                                })),
                                child: Text(!isSelected
                                    ? displayMessage
                                    : widget.bDay.text)),
                          ],
                        ),
                        !isSelected
                            ? Container()
                            : Row(
                                children: [
                                  label(AppConstants.age),
                                  Text(
                                    Utils.ageFormatter(widget.age.text),
                                    style:
                                        TextStyle(fontSize: isPhone ? 10 : 20),
                                  )
                                ],
                              )
                      ],
                    ),
                  )
                : Padding(
                    padding: AppConstants.formPadding,
                    child: Row(
                      children: [
                        label(AppConstants.birthday),
                        ElevatedButton(
                            onPressed: () => _selectDate(context),
                            style: ButtonStyle(foregroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              return AppColors.theme;
                            })),
                            child: Text(!isSelected
                                ? displayMessage
                                : widget.bDay.text)),
                        !isSelected
                            ? Container()
                            : Row(
                                children: [
                                  label(AppConstants.age),
                                  Text(
                                    Utils.ageFormatter(widget.age.text),
                                    style:
                                        TextStyle(fontSize: isPhone ? 10 : 20),
                                  )
                                ],
                              )
                      ],
                    ),
                  ))
            : Container(),
        CustomWidgets.customTextFormField(
            context, AppConstants.address, widget.address),
      ],
    );
  }
}
