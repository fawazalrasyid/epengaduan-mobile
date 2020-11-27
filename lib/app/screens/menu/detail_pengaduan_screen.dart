import 'package:epengaduan/app/constants/colors.dart';
import 'package:epengaduan/app/constants/dimens.dart';
import 'package:epengaduan/app/constants/fonts.dart';
import 'package:epengaduan/data/models/pengaduan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailPengaduanScreen extends StatefulWidget {
  final Pengaduan pengaduan;
  final index;

  const DetailPengaduanScreen({Key key, this.pengaduan, this.index})
      : super(key: key);

  @override
  _DetailPengaduanScreenState createState() => _DetailPengaduanScreenState();
}

class _DetailPengaduanScreenState extends State<DetailPengaduanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Detail Pengaduan",
          style: FontBase.bold.copyWith(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Dimens.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Satus : ",
                    style: FontBase.bold.copyWith(
                      fontSize: 18,
                      color: ColorBase.text,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  buildStatusText(widget.pengaduan.data[widget.index].status)
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                "Laporan",
                style: FontBase.bold.copyWith(
                  fontSize: 18,
                  color: ColorBase.text,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                "Tanggal laporan : " +
                    DateFormat.yMd().format(
                        widget.pengaduan.data[widget.index].tglPengaduan),
                style: FontBase.semiBold.copyWith(
                  fontSize: 16,
                  color: ColorBase.text,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "Isi laporan : ",
                style: FontBase.semiBold.copyWith(
                  fontSize: 16,
                  color: ColorBase.text,
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(Dimens.cardPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.cardRadius),
                  color: ColorBase.card,
                ),
                child: Text(
                  widget.pengaduan.data[widget.index].laporan ?? "",
                  style: FontBase.regular.copyWith(
                    fontSize: 16,
                    color: ColorBase.text,
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              Text(
                "Tanggapan",
                style: FontBase.bold.copyWith(
                  fontSize: 18,
                  color: ColorBase.text,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                widget.pengaduan.data[widget.index].tglTanggapan != null
                    ? "Tanggal tanggapan : " +
                        DateFormat.yMd().format(
                            widget.pengaduan.data[widget.index].tglTanggapan)
                    : "Tanggal tanggapan : ",
                style: FontBase.semiBold.copyWith(
                  fontSize: 16,
                  color: ColorBase.text,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                "Isi tanggapan : ",
                style: FontBase.semiBold.copyWith(
                  fontSize: 16,
                  color: ColorBase.text,
                ),
              ),
              SizedBox(height: 8.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(Dimens.cardPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.cardRadius),
                  color: ColorBase.card,
                ),
                child: Text(
                  widget.pengaduan.data[widget.index].tanggapan ??
                      "Laporan belum ditanggapi oleh petugas.",
                  style: FontBase.regular.copyWith(
                    fontSize: 16,
                    color: ColorBase.text,
                  ),
                ),
              ),
              SizedBox(height: 32.0),
            ],
          ),
        ),
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
