import 'package:flutter/material.dart';
import 'package:holy_trinity_healthcare/screens/splash.dart';

void main() {
  runApp(const MaterialApp(home: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Splash();
  }
}
