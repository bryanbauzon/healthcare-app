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
  String displayMessage ='Retrieving data...';

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {

      if (widget.bDay.text.isNotEmpty) {
        setState(() {
          isSelected = true;

          widget.age.text = Utils.getAgeByBirthdate(selectedDate).toString();
        });
      }else{
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
        widget.age.text = Utils.getAgeByBirthdate(selectedDate).toString();
        widget.bDay.text = Utils.formatDate(selectedDate, false);
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
        Row(
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
        widget.isFormScreen ? Padding(
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
                          style: const TextStyle(fontSize: 20),
                        )
                      ],
                    )
            ],
          ),
        ):Container(),
        CustomWidgets.customTextFormField(
            context, AppConstants.address, widget.address),
      ],
    );
  }
}
