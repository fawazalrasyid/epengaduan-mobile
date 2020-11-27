import 'dart:convert';

import 'package:epengaduan/app/components/dialog.dart';
import 'package:epengaduan/app/constants/colors.dart';
import 'package:epengaduan/app/constants/dimens.dart';
import 'package:epengaduan/app/constants/fonts.dart';
import 'package:epengaduan/app/screens/onboarding/login_screen.dart';
import 'package:epengaduan/data/utils/api.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nikController = new TextEditingController();
  final TextEditingController namaController = new TextEditingController();
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController telpController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController cpasswordController = new TextEditingController();

  bool _securePassText = true;
  bool _secureCpassText = true;

  showHidePassword() {
    setState(() {
      _securePassText = !_securePassText;
    });
  }

  showHideCpassword() {
    setState(() {
      _secureCpassText = !_secureCpassText;
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
                SizedBox(height: 64.0),
                Text(
                  "Register dan mulai \nbuat laporan",
                  style: FontBase.bold.copyWith(
                    color: ColorBase.text,
                    fontSize: 22.0,
                  ),
                ),
                SizedBox(height: 32.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Nik",
                      style: FontBase.semiBold.copyWith(
                        color: ColorBase.text,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: nikController,
                      style: FontBase.regular.copyWith(
                        color: ColorBase.text,
                        fontSize: 16.0,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding: EdgeInsets.all(16.0),
                        hintText: "Masukkan nik",
                        hintStyle: FontBase.regular.copyWith(
                          color: ColorBase.hintText,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      "Nama",
                      style: FontBase.semiBold.copyWith(
                        color: ColorBase.text,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: namaController,
                      style: FontBase.regular.copyWith(
                        color: ColorBase.text,
                        fontSize: 16.0,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding: EdgeInsets.all(16.0),
                        hintText: "Masukkan nama",
                        hintStyle: FontBase.regular.copyWith(
                          color: ColorBase.hintText,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
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
                      "Telepon",
                      style: FontBase.semiBold.copyWith(
                        color: ColorBase.text,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: telpController,
                      style: FontBase.regular.copyWith(
                        color: ColorBase.text,
                        fontSize: 16.0,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding: EdgeInsets.all(16.0),
                        hintText: "Masukkan telepon",
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
                      obscureText: _securePassText,
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
                            icon: Icon(_securePassText
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
                    SizedBox(height: 16.0),
                    Text(
                      "Konfirmasi Password",
                      style: FontBase.semiBold.copyWith(
                        color: ColorBase.text,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: cpasswordController,
                      obscureText: _secureCpassText,
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
                            icon: Icon(_secureCpassText
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: showHideCpassword),
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
                        nik: nikController.text,
                        nama: namaController.text,
                        username: usernameController.text,
                        telp: telpController.text,
                        password: passwordController.text,
                        cpassword: cpasswordController.text,
                      );
                    },
                    child: Text(
                      "Register",
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
                          text: "Sudah memiliki akun?",
                          style: FontBase.semiBold.copyWith(
                            color: ColorBase.text,
                            fontSize: 14.0,
                          ),
                        ),
                        TextSpan(
                          text: " Login!",
                          style: FontBase.semiBold.copyWith(
                            color: ColorBase.blue,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 64.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateField({
    String nik,
    String nama,
    String username,
    String telp,
    String password,
    String cpassword,
  }) async {
    if (nik.isNotEmpty &&
        nama.isNotEmpty &&
        username.isNotEmpty &&
        telp.isNotEmpty &&
        password.isNotEmpty &&
        cpassword == password) {
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
      await doRegister(nik, nama, username, telp, password);
    } else if (cpassword != password) {
      alrtDialog(
        context,
        "Registrasi Gagal!",
        "password dan konfirmasi password tidak sama!",
      );
    } else {
      alrtDialog(context, "Registrasi Gagal!", "semua field harus di isi!");
    }
  }

  Future doRegister(
    String nik,
    String nama,
    String username,
    String telp,
    String password,
  ) async {
    final _response = await http.post(
      Api.register,
      body: {
        "nik": "$nik",
        "nama": "$nama",
        "username": "$username",
        "password": "$password",
        "telp": "$telp",
      },
    );

    Navigator.pop(context);

    if (_response.statusCode == 200) {
      var response = json.decode(_response.body);
      switch (response["status_code"]) {
        case 200:
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  "Registrasi Sukses!",
                  style: FontBase.bold.copyWith(
                    color: ColorBase.text,
                    fontSize: 18.0,
                  ),
                ),
                content: Text(
                  "Silahkan login menggunakan username dan password yang telah di dafatarkan",
                  style: FontBase.regular.copyWith(
                    color: ColorBase.text,
                    fontSize: 18.0,
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              );
            },
          );
          break;
        case 401:
        case 422:
          FocusScope.of(context).requestFocus(FocusNode());
          alrtDialog(context, "Registrasi Gagal!", "username telah digunakan!");
          break;
        default:
          FocusScope.of(context).requestFocus(FocusNode());
          alrtDialog(context, "Registrasi Gagal!", null);
          break;
      }
    }
  }
}
