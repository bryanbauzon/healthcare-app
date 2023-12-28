import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/colors.dart';
import 'package:holy_trinity_healthcare/constants/widgets.dart';
import 'package:holy_trinity_healthcare/screens/register.dart';

import '../constants/app_constants.dart';
import '../utils/utils.dart';
import 'home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void redirect(String screen) {
      switch (screen) {
        case AppConstants.register:
          return Utils.navigateToScreen(context, const Register());
      }
    }

    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                AppConstants.logo,
                height: 200,
                width: 200,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppConstants.appName,
                      style: TextStyle(
                          fontSize: 50,
                          color: AppColors.theme,
                          fontWeight: FontWeight.bold),

                    ),
                const Text(
                  AppConstants.appDescription,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold),)
                  ],
                ),
              )
            ],
          ),
        ),
        CustomWidgets.loginTextFormField(
            context, AppConstants.username, controller),
        CustomWidgets.loginTextFormField(
            context, AppConstants.password, controller),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomWidgets.customButton(context, AppConstants.register,
                  () => redirect(AppConstants.register), true),
              CustomWidgets.customButton(
                  context, AppConstants.login, () {

                Utils.navigateToScreen(context, const Home());
              }, true)
            ],
          ),
        )
      ]),
    ));
  }
}
