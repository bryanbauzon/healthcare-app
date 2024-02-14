import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:holy_trinity_healthcare/screens/splash.dart';

import 'screens/login.dart';
import 'utils/utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MaterialApp(home: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isPhone = Utils.isMobile();
    return isPhone ? const Login() : const Splash();
  }
}
