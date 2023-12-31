import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/app_constants.dart';
import 'package:holy_trinity_healthcare/constants/widgets.dart';
import 'package:holy_trinity_healthcare/model/user.dart';
import 'package:holy_trinity_healthcare/screens/forms/personal_details.dart';
import 'package:holy_trinity_healthcare/utils/utils.dart';

import '../services/repository.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isExists = false;
  bool registered = false;

  bool isPhone = Utils.isMobile();

  String btnString = AppConstants.register;
  bool btnFlag = true;

  @override
  void initState() {
    initDb();
    super.initState();
  }

  void initDb() async {
    await Repository.instance.database;
  }

  //Personal Details
  final TextEditingController lName = TextEditingController();
  final TextEditingController fName = TextEditingController();
  final TextEditingController mName = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController empId = TextEditingController();
  final TextEditingController position = TextEditingController();

  final User user = User(
      lastName: '',
      firstName: '',
      middleName: '',
      address: '',
      empId: '',
      position: '',
      password: '');

  final _formKey = GlobalKey<FormState>();
  void showMessage(String message) =>
      CustomWidgets.showSnackBar(context, message);

  void navigateToLogin() => Navigator.pop(context);
  TextEditingController controller = TextEditingController();
  Widget textWidget(String text, bool isHeader) {
    return Align(
        alignment: isHeader ? Alignment.center : Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            text,
            style: TextStyle(
                fontSize: isPhone ? 20 : (isHeader ? 40 : 25),
                fontWeight: FontWeight.bold),
          ),
        ));
  }

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

  void createUser() async {
    User user = User(
        lastName: lName.text,
        firstName: fName.text,
        middleName: mName.text,
        address: address.text,
        empId: empId.text,
        position: position.text,
        password: empId.text);

    await Repository.instance.insert(user: user);
  }

  Future<bool> checkIfUserExists() async {
    return await Repository.instance.checkIfUserExists(empId: empId.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomWidgets.customAppBar(context, AppConstants.appName,
                  AppConstants.appDescription, true, user),
              Padding(
                  padding: EdgeInsets.only(
                      top: 50,
                      left: isPhone ? 10 : 30,
                      right: isPhone ? 10 : 30),
                  child: Column(
                    children: [
                      textWidget(AppConstants.registration.toUpperCase(), true),
                      Container(
                        height: isPhone ? 10 : 100,
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
                    ],
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          CustomWidgets.customButton(context, btnString, () async {
        FocusScope.of(context).unfocus();
        if (_formKey.currentState!.validate()) {
          bool flag = await checkIfUserExists();

          if (!flag) {
            createUser();
            registered = true;
          } else {
            setState(() {
              isExists = true;
              btnString = 'User already exists!';
              btnFlag = false;
            });

            Future.delayed(const Duration(seconds: 3), () {
              if (isExists) {
                setState(() {
                  isExists = false;
                  btnString = AppConstants.register;
                  btnFlag = true;
                });
              }
            });
          }

          if (registered) {
            showMessage('Successfully Registered');
            setState(() {
              btnString = 'Please wait...';
              btnFlag = false;
            });
            Future.delayed(const Duration(seconds: 2), () {
              navigateToLogin();
            });
          }
        }
      }, btnFlag),
    );
  }
}
