import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/colors.dart';
import 'package:holy_trinity_healthcare/constants/app_constants.dart';
import 'package:holy_trinity_healthcare/model/user.dart';

import '../screens/login.dart';
import '../screens/main_forms.dart';
import '../utils/utils.dart';

class CustomWidgets {
  static Widget customAppBar(BuildContext context, String appName,
      String appDescription, bool isRegistration, User user) {
    bool isPhone = Utils.isMobile();

    return Container(
        height: isPhone ? 130 : 150,
        width: MediaQuery.of(context).size.width,
        color: AppColors.theme,
        child: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(
                    left: isPhone ? 20 : 30,
                    right: isPhone ? 20 : 30,
                    top: isPhone ? 8 : 10,
                    bottom: isPhone ? 8 : 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: isPhone ? 15 : 20),
                      child: Image.asset(
                        AppConstants.logo,
                        height: isPhone ? 40 : 80,
                        width: isPhone ? 40 : 80,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appName.toUpperCase(),
                          style: TextStyle(
                              fontSize: isPhone ? 15 : 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white),
                        ),
                        Text(
                          appDescription,
                          style: TextStyle(
                              fontSize: isPhone ? 12 : 15,
                              color: AppColors.white),
                        ),
                      ],
                    ),
                    Expanded(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                isPhone
                                    ? Container()
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${user.firstName.toUpperCase()} ${user.lastName.toUpperCase()}',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.white),
                                          ),
                                          Text(
                                            user.position,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: AppColors.white),
                                          ),
                                        ],
                                      ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: isPhone ? 1 : 10),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: InkWell(
                                      onLongPress: () {
                                        if (!isRegistration) {
                                          showSnackBar(context,
                                              'Click to logout your account.');
                                        }
                                      },
                                      onTap: () {
                                        if (isRegistration) {
                                          Navigator.pop(context);
                                        } else {
                                          Utils.navigateToScreen(
                                              context, const Login());
                                        }
                                      },
                                      child: Icon(
                                        !isRegistration
                                            ? Icons.logout
                                            : Icons.arrow_back_rounded,
                                        size: isPhone ? 20 : 50,
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )))
                  ],
                ))));
  }

  static Widget customButton(
      BuildContext context, String text, VoidCallback onTap, bool isEnabled) {
    bool isPhone = Utils.isMobile();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: isEnabled ? onTap : () {},
        child: Container(
            height: isPhone ? 45 : 60,
            width: 130,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.theme),
                borderRadius:
                    BorderRadius.all(Radius.circular(isPhone ? 0 : 10)),
                color: text == AppConstants.register
                    ? Colors.transparent
                    : (isEnabled ? AppColors.theme : AppColors.disabled)),
            child: Center(
              child: Text(
                text.toUpperCase(),
                style: TextStyle(
                    fontSize: isPhone ? 14 : 18,
                    fontWeight: FontWeight.bold,
                    color: text == AppConstants.register
                        ? AppColors.theme
                        : AppColors.white),
              ),
            )),
      ),
    );
  }

  static Widget customTextFormField(BuildContext context, String fieldName,
      TextEditingController controller) {
    return SizedBox(
      child: Padding(
        padding: AppConstants.formPadding,
        child: TextFormField(
          controller: controller,
          maxLines: Utils.maxLinesByLabel(fieldName),
          // readOnly: (fieldName == AppConstants.password),
          obscureText: (fieldName == AppConstants.password),
          keyboardType: Utils.getTextInputTypeByField(fieldName),
          decoration: fieldInputDecoration(fieldName),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required.';
            }
            return null;
          },
        ),
      ),
    );
  }

  static InputDecoration fieldInputDecoration(String fieldName) =>
      InputDecoration(
        hintText: fieldName,
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: AppColors.theme)),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.theme,
          ),
        ),
      );

  static Widget customMenuTiles(BuildContext context, String title,
      bool isEnabled, VoidCallback onTap, IconData ic) {
    bool isPhone = Utils.isMobile();
    return Padding(
      padding: EdgeInsets.all(isPhone ? 5 : 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: isPhone ? 150 : 220,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: isEnabled ? AppColors.enabled : AppColors.disabled,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(50)),
                  height: isPhone ? 60 : 80,
                  width: isPhone ? 60 : 80,
                  child: Icon(
                    ic,
                    color: isEnabled ? AppColors.enabled : AppColors.disabled,
                    size: 45,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize:
                                isPhone ? 20 : AppConstants.menuTitleFontSize,
                            fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          AppConstants.dummyDescriptionShort,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 15,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }

  static Widget comingSoonMenuTiles(BuildContext context) =>
      customMenuTiles(context, AppConstants.comingSoon, false, () {
        showSnackBar(context, AppConstants.comingSoon);
      }, Icons.warning_amber);

  static Widget documentTiles(
      BuildContext context, String title, bool isEnabled, User user) {
    bool isPhone = Utils.isMobile();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          if (isEnabled) {
            Utils.navigateToScreen(
                context,
                MainForms(
                  title: title,
                  user: user,
                ));
          }
        },
        child: Container(
            height: isPhone ? 150 : 210,
            width: 420,
            decoration: BoxDecoration(
              color: isEnabled ? AppColors.enabled : AppColors.disabled,
              borderRadius: BorderRadius.circular(isPhone ? 5 : 10),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Utils.documentTilesIcon(title),
                color: AppColors.white,
                size: isPhone ? 30 : 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  title,
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: isPhone ? 25 : 30,
                      fontWeight: FontWeight.bold),
                ),
              )
            ])),
      ),
    );
  }

  static void showSnackBar(BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );

  static Widget singeTextFormField(
      BuildContext context, String label, TextEditingController controller) {
    bool isPhone = Utils.isMobile();
    return SafeArea(
        child: Column(
      children: [
        setFormTitle(label),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: isPhone ? MediaQuery.of(context).size.width : 320,
            child: Padding(
              padding: EdgeInsets.only(left: isPhone ? 0 : 10),
              child:
                  CustomWidgets.customTextFormField(context, label, controller),
            ),
          ),
        )
      ],
    ));
  }

  static Widget loginTextFormField(
      BuildContext context, String label, TextEditingController controller) {
    bool isPhone = Utils.isMobile();

    return SafeArea(
        child: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: isPhone ? 10 : 20),
          child: setFormTitle(label),
        ),
        Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                  left: isPhone ? 10 : 20, right: isPhone ? 10 : 20),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CustomWidgets.customTextFormField(
                    context, label, controller),
              ),
            ))
      ],
    ));
  }

  static String changePlaceholderByLabel(String label) {
    if (label == AppConstants.memoryIssuesPlaceholder) {
      return AppConstants.memoryIssuesPlaceholder;
    }
    return label;
  }

  static Widget multipleTextField(
    BuildContext context,
    String fieldName,
    TextEditingController controller1,
    TextEditingController controller2,
  ) {
    bool isPhone = Utils.isMobile();
    String getPlaceholder(String fieldName, bool isRightField) {
      if (isRightField) {
        switch (fieldName) {
          case AppConstants.painLevelToday:
            return AppConstants.bodyLocationToday;
          case AppConstants.painLevelLastVisit:
            return AppConstants.bodyLocationTLastVisit;
          case AppConstants.cva:
            return AppConstants.rightWeakness;
        }
      } else {
        if (fieldName == AppConstants.cva) {
          return AppConstants.leftWeakness;
        }
        return fieldName;
      }

      return 'unhandled placeholder';
    }

    return SafeArea(
        child: Column(
      children: [
        setFormTitle(fieldName),
        Align(
          alignment: Alignment.centerLeft,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: isPhone ? 0 : 10, right: isPhone ? 0 : 20),
                  child: CustomWidgets.customTextFormField(
                      context, getPlaceholder(fieldName, false), controller1),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: isPhone ? 0 : 10),
                  child: CustomWidgets.customTextFormField(
                      context, getPlaceholder(fieldName, true), controller2),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }

  static Widget customTextArea(
      BuildContext context, String label, TextEditingController controller) {
    bool isPhone = Utils.isMobile();
    return SafeArea(
        child: Column(
      children: [
        setFormTitle(label),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.only(left: isPhone ? 0 : 10),
              child:
                  CustomWidgets.customTextFormField(context, label, controller),
            ),
          ),
        )
      ],
    ));
  }

  static Widget setFormTitle(String title) {
    bool isPhone = Utils.isMobile();
    return Padding(
      padding: EdgeInsets.only(left: isPhone ? 10 : 20, top: isPhone ? 0 : 10),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text(title,
              style: TextStyle(
                  fontSize: isPhone ? 18 : AppConstants.formTitle,
                  fontWeight: FontWeight.bold))),
    );
  }
}
