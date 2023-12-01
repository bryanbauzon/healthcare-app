import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/colors.dart';
import 'package:holy_trinity_healthcare/constants/strings.dart';
import 'package:holy_trinity_healthcare/screens/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,

            children:[
              Image.asset(StringConstants.logo, height: 220, width: 220,),
               Text(StringConstants.appName,
              style: TextStyle(
                color: AppColors.theme,
                fontSize: 32,
                fontWeight: FontWeight.bold
              ),
              ), const Text(StringConstants.appDescription,
                style: TextStyle(
                    fontSize: 28,
                ),
              )
            ]
        ),
      )
    );
  }
}
