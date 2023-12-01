import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holy_trinity_healthcare/screens/splash.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MaterialApp(home: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Splash();
  }
}
