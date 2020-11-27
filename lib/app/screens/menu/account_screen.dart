import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:epengaduan/app/components/header.dart';
import 'package:epengaduan/app/constants/colors.dart';
import 'package:epengaduan/app/constants/dimens.dart';
import 'package:epengaduan/app/constants/fonts.dart';
import 'package:epengaduan/app/constants/urls.dart';
import 'package:epengaduan/app/screens/onboarding/login_screen.dart';
import 'package:epengaduan/data/utils/preferences.dart';
import 'package:epengaduan/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  SharedPreferences prefs = Preferences.settings;

  User user;

  @override
  void initState() {
    getDataUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Header(
            title: "Akun",
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimens.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: FractionalOffset.center,
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: '$BASE_IMG_URL${user.data.imagePath}',
                        imageBuilder: (context, imageProvider) => Container(
                          height: MediaQuery.of(context).size.width / 3.5,
                          width: MediaQuery.of(context).size.width / 3.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          height: MediaQuery.of(context).size.width / 3.5,
                          width: MediaQuery.of(context).size.width / 3.5,
                          padding: EdgeInsets.all(Dimens.defaultPadding),
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: MediaQuery.of(context).size.width / 3.5,
                          width: MediaQuery.of(context).size.width / 3.5,
                          padding: EdgeInsets.all(Dimens.defaultPadding),
                          child: Icon(Icons.wifi_off),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        user.data.nama,
                        style: FontBase.bold.copyWith(
                          color: ColorBase.text,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 64.0),
                Text(
                  "Nik",
                  style: FontBase.bold.copyWith(
                    color: ColorBase.text,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  user.data.nik,
                  style: FontBase.regular.copyWith(
                    color: ColorBase.text,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Username",
                  style: FontBase.bold.copyWith(
                    color: ColorBase.text,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  user.data.username,
                  style: FontBase.regular.copyWith(
                    color: ColorBase.text,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Telepon",
                  style: FontBase.bold.copyWith(
                    color: ColorBase.text,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  user.data.telp,
                  style: FontBase.regular.copyWith(
                    color: ColorBase.text,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 64.0),
                Material(
                  elevation: 0,
                  borderRadius: BorderRadius.circular(12.0),
                  color: ColorBase.blue,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 56.0,
                    padding: EdgeInsets.all(8.0),
                    onPressed: () {
                      signOut();
                    },
                    child: Text(
                      "Logout",
                      textAlign: TextAlign.center,
                      style: FontBase.bold.copyWith(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void getDataUser() async {
    user = User.fromJson(jsonDecode(prefs.get('user')));
  }

  void signOut() async {
    prefs.remove('accessToken');
    prefs.remove('user');

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) => LoginScreen(),
      ),
      (Route<dynamic> route) => false,
    );
  }
}
