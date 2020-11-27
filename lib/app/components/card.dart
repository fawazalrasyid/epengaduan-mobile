import 'package:epengaduan/app/constants/colors.dart';
import 'package:epengaduan/app/constants/dimens.dart';
import 'package:epengaduan/app/constants/fonts.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final String title;
  final String status;
  final String tglPengaduan;

  const CardItem({
    Key key,
    this.title,
    this.status,
    this.tglPengaduan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Dimens.cardPadding),
      margin: EdgeInsets.only(bottom: Dimens.cardMargin),
      decoration: BoxDecoration(
        color: ColorBase.card,
        borderRadius: BorderRadius.circular(Dimens.cardRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            style: FontBase.semiBold.copyWith(
              fontSize: 16,
              color: ColorBase.text,
            ),
          ),
          Text(
            tglPengaduan,
            style: FontBase.regular.copyWith(
              fontSize: 16,
              color: ColorBase.text,
            ),
          ),
          SizedBox(height: 8.0),
          buildStatusText(status),
        ],
      ),
    );
  }

  buildStatusText(String status) {
    if (status == "0" || status == "proses") {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          "Sedang di proses",
          style: FontBase.regular.copyWith(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      );
    } else if (status == "selesai") {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          "Selesai",
          style: FontBase.regular.copyWith(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          "Pengaduan di tolak",
          style: FontBase.regular.copyWith(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      );
    }
  }
}
