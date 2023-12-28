import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/app_constants.dart';
import 'package:holy_trinity_healthcare/constants/widgets.dart';
import 'package:holy_trinity_healthcare/screens/forms/personal_details.dart';
import 'package:holy_trinity_healthcare/screens/login.dart';

import '../utils/utils.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Personal Details
  final TextEditingController lName = TextEditingController();
  final TextEditingController fName = TextEditingController();
  final TextEditingController mName = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController empId = TextEditingController();
  final TextEditingController position = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  TextEditingController controller = TextEditingController();
  Widget textWidget(String text, bool isHeader) => Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          text,
          style: TextStyle(
              fontSize: isHeader ? 40 : 25, fontWeight: FontWeight.bold),
        ),
      ));

  Widget textField(
          String label, TextEditingController controller, bool isExpanded) =>
      SizedBox(
          width: !isExpanded ? MediaQuery.of(context).size.width : 280,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                textWidget(label, false),
                CustomWidgets.customTextFormField(context, label, controller)
              ],
            ),
          ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomWidgets.customAppBar(context, AppConstants.appName,
                  AppConstants.appDescription, true),
              Padding(
                  padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                  child: Column(
                    children: [
                      textWidget(AppConstants.registration, true),
                      Container(
                        height: 100,
                      ),
                      PersonalDetails(
                        lName: lName,
                        fName: fName,
                        mName: mName,
                        bDay: controller,
                        age: controller,
                        address: address,
                        isFormScreen: false,
                      ),
                      textField(AppConstants.username, empId, false),
                      textField(AppConstants.position, position, false),
                      textField(AppConstants.password, empId, false),
                      CustomWidgets.customButton(context, AppConstants.register,
                          () {
                        // if (_formKey.currentState!.validate()) {}
                            Utils.navigateToScreen(context, const Login());
                      }, true)
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
