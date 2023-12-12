import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/app_constants.dart';
import 'package:holy_trinity_healthcare/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utils.dart';
import 'main_forms.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  _redirect() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String container = "";

    String form = prefs.getString(AppConstants.form) ?? '';
    List<String> keys = Utils.getKeys(form);

    for (String key in keys) {
      key = key.replaceAll(' ', '');
      container = prefs.getString(key) ?? '';
      if (container.isNotEmpty) {
        break;
      }
    }
    Future.delayed(const Duration(seconds: 8), () {
      if (container.isNotEmpty) {
        Utils.navigateToScreen(
            context,
            MainForms(
              title: form,
            ));
      } else {
        Utils.navigateToScreen(context, const Home());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppConstants.splash), fit: BoxFit.cover)),
      ),
    );
  } //splash art updated
}
