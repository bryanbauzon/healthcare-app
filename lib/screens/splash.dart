import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/app_constants.dart';
import 'package:holy_trinity_healthcare/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/utils.dart';
import 'forms.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState()  {
    super.initState();
    _redirect();
  }

  _redirect() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String container = "";
    for(String key in AppConstants.keysVitalSigns){
      key = key.replaceAll(' ', '');
      container =  prefs.getString(key) ?? '';
      if(container.isNotEmpty){
        break;
      }
    }
    Future.delayed(const Duration(seconds: 5), () {
      if(container.isNotEmpty){
        Utils.navigateToScreen(context, const Forms(title: AppConstants.vitalSign,));
      }else{
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
