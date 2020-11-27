import 'package:epengaduan/app/constants/colors.dart';
import 'package:epengaduan/app/screens/onboarding/splash_screen.dart';
import 'package:epengaduan/data/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initPreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'ePengaduan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: ColorBase.aqua,
        primaryColor: ColorBase.blue,
        primaryColorDark: ColorBase.navy,
      ),
      home: SplashScreen(),
    );
  }
}

void initPreferences() async {
  await Preferences.getInstance();
}
