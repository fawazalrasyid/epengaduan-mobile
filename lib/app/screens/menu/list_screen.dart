import 'dart:convert';

import 'package:epengaduan/app/components/header.dart';
import 'package:epengaduan/app/components/card.dart';
import 'package:epengaduan/app/components/error.dart';
import 'package:epengaduan/app/components/shimmer.dart';
import 'package:epengaduan/app/constants/colors.dart';
import 'package:epengaduan/app/constants/dimens.dart';
import 'package:epengaduan/app/constants/fonts.dart';
import 'package:epengaduan/app/screens/menu/detail_pengaduan_screen.dart';
import 'package:epengaduan/data/models/user.dart';
import 'package:epengaduan/data/models/pengaduan.dart';
import 'package:epengaduan/data/utils/api.dart';
import 'package:epengaduan/data/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  SharedPreferences prefs = Preferences.settings;
  User user;

  bool _buttonProses = true;
  bool _buttonTolak = false;
  bool _buttonSelesai = false;

  String statusParams = "proses";

  @override
  void initState() {
    getDataUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
          Header(
            title: "List Pengaduan",
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimens.defaultPadding),
            margin: EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    elevation: 0.0,
                    color: _buttonProses ? Colors.blue : Colors.transparent,
                    child: Text(
                      "Diproses",
                      style: FontBase.semiBold.copyWith(
                        fontSize: 16,
                        color: _buttonProses ? Colors.white : ColorBase.text,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _buttonProses = !_buttonProses;
                        _buttonTolak = false;
                        _buttonSelesai = false;
                        statusParams = "proses";
                      });
                    },
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    elevation: 0.0,
                    color: _buttonTolak ? Colors.red : Colors.transparent,
                    child: Text(
                      "Ditolak",
                      style: FontBase.semiBold.copyWith(
                        fontSize: 16,
                        color: _buttonTolak ? Colors.white : ColorBase.text,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _buttonProses = false;
                        _buttonTolak = !_buttonTolak;
                        _buttonSelesai = false;
                        statusParams = "tolak";
                      });
                    },
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(
                        color: Colors.amber,
                      ),
                    ),
                    elevation: 0.0,
                    color: _buttonSelesai ? Colors.amber : Colors.transparent,
                    child: Text(
                      "Selesai",
                      style: FontBase.semiBold.copyWith(
                        fontSize: 16,
                        color: _buttonSelesai ? Colors.white : ColorBase.text,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _buttonProses = false;
                        _buttonTolak = false;
                        _buttonSelesai = !_buttonSelesai;
                        statusParams = "selesai";
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimens.defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder<Pengaduan>(
                  future: fetchDataPengaduan(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 2,
                          itemBuilder: (BuildContext context, int index) {
                            return ShimmerItem();
                          },
                        ),
                      );
                    } else if (snapshot.hasData) {
                      if (snapshot.data.data.length == 0) {
                        return Center(
                          child: showErrorNoData(context),
                        );
                      } else {
                        return MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.data.length >= 2
                                ? 2
                                : snapshot.data.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailPengaduanScreen(
                                        pengaduan: snapshot.data,
                                        index: index,
                                      ),
                                    ),
                                  );
                                },
                                child: CardItem(
                                  title: snapshot.data.data[index].laporan,
                                  tglPengaduan: DateFormat.yMd().format(
                                      snapshot.data.data[index].tglPengaduan),
                                  status: snapshot.data.data[index].status,
                                ),
                              );
                            },
                          ),
                        );
                      }
                    } else {
                      return Center(
                        child: showErrorCollectData(context),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 32.0),
        ]),
      ),
    );
  }

  void getDataUser() async {
    user = User.fromJson(jsonDecode(prefs.get('user')));
  }

  Future<Pengaduan> fetchDataPengaduan() async {
    var queryParameters = {
      'nik': '${user.data.nik}',
      'status': statusParams,
    };

    String queryString = Uri(queryParameters: queryParameters).query;

    final _response = await http.get(
      Api.pengaduan + '?' + queryString,
    );

    if (_response.statusCode == 200) {
      final response = pengaduanFromJson(_response.body);

      switch (response.statusCode) {
        case 200:
          print("sukses menarik data pengaduan");
          break;
        case 401:
          print("data tidak ditemukan");
          break;
        default:
          print("gagal menarik data");
          break;
      }

      return response;
    } else {
      return null;
    }
  }
}
