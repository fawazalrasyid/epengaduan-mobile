import 'package:epengaduan/app/constants/colors.dart';
import 'package:epengaduan/app/constants/fonts.dart';
import 'package:flutter/material.dart';

Widget showErrorNoData(BuildContext context) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/empety.png",
          height: MediaQuery.of(context).size.width / 5,
        ),
        SizedBox(height: 8.0),
        Text(
          "Belum ada data pengaduan",
          style: FontBase.regular.copyWith(
            fontSize: 14,
            color: ColorBase.text,
          ),
        ),
      ],
    ),
  );
}

Widget showErrorCollectData(BuildContext context) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/error.png",
          height: MediaQuery.of(context).size.width / 5,
        ),
        SizedBox(height: 8.0),
        Text(
          "Terjadi kesalahan saat mengambil data",
          style: FontBase.regular.copyWith(
            fontSize: 14,
            color: ColorBase.text,
          ),
        ),
      ],
    ),
  );
}
