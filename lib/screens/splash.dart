import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/app_constants.dart';


import '../utils/utils.dart';
import 'login.dart';

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

    Future.delayed(const Duration(seconds: 8), () {
      // if (container.isNotEmpty) {
        Utils.navigateToScreen(
            context,
            const Login());
      // } else {
      //   Utils.navigateToScreen(context, const Home());
      // }
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
