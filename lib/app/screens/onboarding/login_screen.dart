import 'dart:convert';

import 'package:epengaduan/app/constants/colors.dart';
import 'package:epengaduan/app/constants/dimens.dart';
import 'package:epengaduan/app/constants/fonts.dart';
import 'package:epengaduan/app/screens/index/index_screen.dart';
import 'package:epengaduan/app/components/dialog.dart';
import 'package:epengaduan/app/screens/onboarding/register_screen.dart';
import 'package:epengaduan/data/models/user.dart';
import 'package:epengaduan/data/utils/api.dart';
import 'package:epengaduan/data/utils/preferences.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  bool _secureText = true;
  String usernames, pass;

  showHidePassword() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.defaultPadding),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight:
                  MediaQuery.of(context).size.height - Dimens.verticalPadding,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 70.0,
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    "assets/images/eP.png",
                  ),
                ),
                SizedBox(height: 32.0),
                Text(
                  "Masuk dan mulai \nbuat laporan",
                  style: FontBase.bold.copyWith(
                    color: ColorBase.text,
                    fontSize: 22.0,
                  ),
                ),
                SizedBox(height: 64.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Username",
                      style: FontBase.semiBold.copyWith(
                        color: ColorBase.text,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: usernameController,
                      style: FontBase.regular.copyWith(
                        color: ColorBase.text,
                        fontSize: 16.0,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding: EdgeInsets.all(16.0),
                        hintText: "Masukkan username",
                        hintStyle: FontBase.regular.copyWith(
                          color: ColorBase.hintText,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      "Password",
                      style: FontBase.semiBold.copyWith(
                        color: ColorBase.text,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: passwordController,
                      onSaved: (val) => pass = val,
                      obscureText: _secureText,
                      style: FontBase.regular.copyWith(
                        color: ColorBase.text,
                        fontSize: 16.0,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding: EdgeInsets.all(16.0),
                        suffixIcon: IconButton(
                            icon: Icon(_secureText
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: showHidePassword),
                        hintText: "Masukkan password",
                        hintStyle: FontBase.regular.copyWith(
                          color: ColorBase.hintText,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
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
                      validateField(
                        username: usernameController.text,
                        password: passwordController.text,
                      );
                    },
                    child: Text(
                      "Login",
                      textAlign: TextAlign.center,
                      style: FontBase.bold.copyWith(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "Belum mempunyai akun?",
                          style: FontBase.semiBold.copyWith(
                            color: ColorBase.text,
                            fontSize: 14.0,
                          ),
                        ),
                        TextSpan(
                          text: " Register!",
                          style: FontBase.semiBold.copyWith(
                            color: ColorBase.blue,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateField({String username, String password}) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(ColorBase.blue),
                ),
                SizedBox(width: 16.0),
                Text(
                  "Loading...",
                  style: FontBase.semiBold.copyWith(
                    color: ColorBase.text,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          );
        },
      );
      await doLogin(username, password);
    } else {
      alrtDialog(
          context, "Login Gagal!", "username dan password harus di isi!");
    }
  }

  Future doLogin(String username, String password) async {
    final _response = await http.post(
      Api.login,
      body: {
        "username": "$username",
        "password": "$password",
      },
    );

    Navigator.pop(context);

    if (_response.statusCode == 200) {
      SharedPreferences prefs = Preferences.settings;
      User response = userFromJson(_response.body);

      switch (response.statusCode) {
        case 200:
          prefs.setString('accessToken', response.data.password);
          prefs.setString('user', jsonEncode(response.toJson()));

          // Toast.show(
          //   'Selamat Datang ${response.data.nama}',
          //   context,
          //   duration: Toast.LENGTH_SHORT,
          //   gravity: Toast.BOTTOM,
          // );

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => IndexScreen(),
            ),
            (Route<dynamic> route) => false,
          );
          break;
        case 401:
        case 422:
          FocusScope.of(context).requestFocus(FocusNode());
          alrtDialog(context, "Login Gagal!", "username atau password salah!");
          break;
        default:
          FocusScope.of(context).requestFocus(FocusNode());
          alrtDialog(context, "Login Gagal!", null);
          break;
      }
    }
  }
}
