import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/colors.dart';
import 'package:holy_trinity_healthcare/constants/widgets.dart';
import 'package:holy_trinity_healthcare/screens/main_forms.dart';
import 'package:holy_trinity_healthcare/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../model/user.dart';
import '../services/repository.dart';
import '../utils/utils.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController empId = TextEditingController();
  TextEditingController pass = TextEditingController();
  late User user;
  bool validateUserCredentials = true;
  bool isPhone = Utils.isMobile();

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  Future<bool> validateCredentials() async {
    return await Repository.instance
        .validateCredentials(empId: empId.text, password: pass.text);
  }

  Future<User> getUserDetails() async {
    return await Repository.instance
        .getUserDetails(empId: empId.text, password: pass.text);
  }

  Widget message() {
    String message = 'Incorrect Employee ID and/or Password. Please try again.';
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, top: 10),
        child: Text(
          message,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isPhone ? 12 : 20,
              color: Colors.red),
        ),
      ),
    );
  }

  late String form;
  void checkSharedPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String container = "";

    setState(() {
      form = prefs.getString(AppConstants.form) ?? '';
    });
    List<String> keys = Utils.getKeys(form);

    for (String key in keys) {
      key = key.replaceAll(' ', '');
      container = prefs.getString(key) ?? '';
      if (container.isNotEmpty) {
        break;
      }
    }

    if (container.isNotEmpty) {
      redirect('mainForm');
    } else {
      redirect('home');
    }
  }

  void redirect(String screen) {
    switch (screen) {
      case AppConstants.register:
        {
          empId.clear();
          pass.clear();
          setState(() {
            validateUserCredentials = true;
          });
          return Utils.navigateToScreen(context, const Register());
        }

      case 'checkSharedPref':
        {
          return checkSharedPref();
        }
      case 'mainForm':
        return Utils.navigateToScreen(
            context, MainForms(title: form, user: user));
      case 'home':
        return Utils.navigateToScreen(context, Home(user: user));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: EdgeInsets.only(
                    left: (isPhone) ? 20 : 30, right: (isPhone) ? 20 : 30),
                child: isPhone
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppConstants.logo,
                            height: isPhone ? 120 : 200,
                            width: isPhone ? 120 : 200,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: (isPhone) ? 5 : 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppConstants.appName.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: isPhone ? 22 : 50,
                                      color: AppColors.theme,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  AppConstants.appDescription,
                                  style: TextStyle(
                                      fontSize: isPhone ? 16 : 25,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppConstants.logo,
                            height: 200,
                            width: 200,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: (isPhone) ? 5 : 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppConstants.appName.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: isPhone ? 18 : 40,
                                      color: AppColors.theme,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  AppConstants.appDescription,
                                  style: TextStyle(
                                      fontSize: isPhone ? 12 : 25,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
              ),
              CustomWidgets.loginTextFormField(
                  context, AppConstants.username, empId),
              CustomWidgets.loginTextFormField(
                  context, AppConstants.password, pass),
              !validateUserCredentials ? message() : const Text(''),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomWidgets.customButton(context, AppConstants.register,
                        () => redirect(AppConstants.register), true),
                    CustomWidgets.customButton(context, AppConstants.login,
                        () async {
                      FocusScope.of(context).unfocus();

                      if (_formKey.currentState!.validate()) {
                        validateUserCredentials = await validateCredentials();
                        if (validateUserCredentials) {
                          user = await getUserDetails();
                          redirect('checkSharedPref');
                        }
                      }
                    }, true)
                  ],
                ),
              )
            ]),
          )),
    ));
  }
}
