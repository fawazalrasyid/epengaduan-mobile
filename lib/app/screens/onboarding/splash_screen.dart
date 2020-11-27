import 'dart:async';

import 'package:epengaduan/app/screens/index/index_screen.dart';
import 'package:epengaduan/app/screens/onboarding/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkIfLoggedIn();
    navigationPage();
  }

  navigationPage() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              isLoggedIn ? IndexScreen() : LoginScreen(),
        ),
      );
    });
  }

  void checkIfLoggedIn() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('accessToken');
    if (token != null) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 75,
                ),
                child: Image.asset("assets/images/ePengaduan.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
