import 'dart:convert';

import 'package:epengaduan/app/components/dialog.dart';
import 'package:epengaduan/app/components/sheet.dart';
import 'package:epengaduan/app/constants/colors.dart';
import 'package:epengaduan/app/constants/dimens.dart';
import 'package:epengaduan/app/constants/fonts.dart';
import 'package:epengaduan/data/models/user.dart';
import 'package:epengaduan/data/utils/api.dart';
import 'package:epengaduan/data/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPengaduanScreen extends StatefulWidget {
  @override
  _AddPengaduanScreenState createState() => _AddPengaduanScreenState();
}

class _AddPengaduanScreenState extends State<AddPengaduanScreen> {
  final TextEditingController laporanController = new TextEditingController();

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
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Buat Pengaduan",
          style: FontBase.bold.copyWith(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimens.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32.0),
            Text(
              "Form Pengaduan",
              style: FontBase.bold.copyWith(
                fontSize: 18,
                color: ColorBase.text,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              "Silahakan tulis permasalahan yang ingin anda laporkan pada form dibawah.",
              style: FontBase.regular.copyWith(
                fontSize: 16,
                color: ColorBase.text,
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimens.cardRadius),
                color: ColorBase.card,
              ),
              child: TextFormField(
                controller: laporanController,
                maxLines: 8,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(Dimens.cardPadding),
                  hintText: "Ketik laporan anda disini",
                  hintStyle: FontBase.regular.copyWith(
                    color: ColorBase.hintText,
                    fontSize: 16.0,
                  ),
                ),
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
                  validateField(
                    laporan: laporanController.text,
                  );
                },
                child: Text(
                  "Kirim",
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
    );
  }

  void validateField({String laporan}) async {
    if (laporan.isNotEmpty) {
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
      await doSendPengaduan(laporan);
    } else {
      alrtDialog(
          context, "Laporan Gagal Terkirim!", "field isi laporan harus diisi!");
    }
  }

  void getDataUser() async {
    user = User.fromJson(jsonDecode(prefs.get('user')));
  }

  Future doSendPengaduan(String laporan) async {
    DateTime now = DateTime.now();
    String curentDate = DateFormat('y-M-d').format(now);
    print(curentDate);

    final _response = await http.post(
      Api.pengaduan,
      body: {
        "nik": "${user.data.nik}",
        "tgl_pengaduan": "$curentDate",
        "isi_laporan": "$laporan",
      },
    );

    Navigator.pop(context);

    if (_response.statusCode == 200) {
      var response = jsonDecode(_response.body);
      switch (response['status_code']) {
        case 200:
          FocusScope.of(context).requestFocus(FocusNode());
          laporanController.clear();
          showSendSuccesModal(context);
          break;
        case 401:
          FocusScope.of(context).requestFocus(FocusNode());
          showSendFailedModal(context);
          break;
        default:
          FocusScope.of(context).requestFocus(FocusNode());
          showErrorModal(context);
          break;
      }
    }
  }
}
