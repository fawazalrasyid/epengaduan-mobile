import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:epengaduan/app/constants/colors.dart';
import 'package:epengaduan/app/components/sheet.dart';
import 'package:epengaduan/app/screens/menu/account_screen.dart';
import 'package:epengaduan/app/screens/menu/home_screen.dart';
import 'package:epengaduan/app/screens/menu/list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  int _selectedIndex = 0;

  void _onTabItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          HomeScreen(),
          ListScreen(),
          AccountScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60.0,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: ColorBase.bottomNavBgColor,
          selectedItemColor: ColorBase.selectedItem,
          unselectedItemColor: ColorBase.unselectedItem,
          currentIndex: _selectedIndex,
          onTap: _onTabItem,
          iconSize: 30.0,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              activeIcon: Icon(
                Icons.home_rounded,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list_alt_outlined,
              ),
              activeIcon: Icon(
                Icons.list_alt_rounded,
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_outlined,
              ),
              activeIcon: Icon(
                Icons.account_circle_rounded,
              ),
              label: "",
            )
          ],
        ),
      ),
    );
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.none:
        showNoConnectionModal(context);
        break;
      default:
        print("Connected!");
        break;
    }
  }
}
