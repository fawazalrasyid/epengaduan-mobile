import 'dart:convert';

import 'package:epengaduan/app/components/header.dart';
import 'package:epengaduan/app/components/card.dart';
import 'package:epengaduan/app/components/error.dart';
import 'package:epengaduan/app/components/shimmer.dart';
import 'package:epengaduan/app/constants/colors.dart';
import 'package:epengaduan/app/constants/dimens.dart';
import 'package:epengaduan/app/constants/fonts.dart';
import 'package:epengaduan/app/screens/menu/add_pengaduan_screen.dart';
import 'package:epengaduan/app/screens/menu/detail_pengaduan_screen.dart';
import 'package:epengaduan/data/models/user.dart';
import 'package:epengaduan/data/models/pengaduan.dart';
import 'package:epengaduan/data/utils/api.dart';
import 'package:epengaduan/data/utils/preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Header(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: Dimens.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pengaduan Terbaru",
                    style: FontBase.bold.copyWith(
                      fontSize: 18,
                      color: ColorBase.text,
                    ),
                  ),
                  SizedBox(height: 16),
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: Dimens.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Menu",
                    style: FontBase.bold.copyWith(
                      fontSize: 18,
                      color: ColorBase.text,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: Dimens.defaultPadding),
              margin: EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      child: Container(
                        height: 110,
                        padding: EdgeInsets.all(Dimens.cardPadding),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimens.cardRadius),
                          color: ColorBase.card,
                          image: DecorationImage(
                            image: AssetImage("assets/images/add.png"),
                            fit: BoxFit.scaleDown,
                            alignment: AlignmentDirectional.centerEnd,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Buat \nPengaduan",
                              style: FontBase.bold.copyWith(
                                fontSize: 16,
                                color: ColorBase.text,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddPengaduanScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getDataUser() async {
    user = User.fromJson(jsonDecode(prefs.get('user')));
  }

  Future<Pengaduan> fetchDataPengaduan() async {
    var queryParameters = {
      'nik': '${user.data.nik}',
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
