import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/constants/app_constants.dart';
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
          context, MaterialPageRoute(builder: (context) => const Home()));
    });
  }

//test
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppConstants.Splash), fit: BoxFit.cover)),
      ),
    );
  } //splash art updated
}
