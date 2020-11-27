import 'package:epengaduan/app/constants/colors.dart';
import 'package:epengaduan/app/constants/dimens.dart';
import 'package:epengaduan/app/constants/fonts.dart';
import 'package:flutter/material.dart';

showNoConnectionModal(context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Wrap(
        children: [
          Container(
            //height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: Dimens.sheetVertical,
              horizontal: Dimens.sheetHorizontal,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0),
              ),
            ),
            child: Column(
              children: [
                Container(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      child: Container(
                        child: Icon(Icons.close),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/offline.png",
                        height: MediaQuery.of(context).size.width / 3,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        "Tidak Ada Koneksi Internet",
                        style: FontBase.semiBold.copyWith(
                          fontSize: 16,
                          color: ColorBase.text,
                        ),
                      ),
                      Text(
                        "Cek koneksi internetmu dan silahakan coba lagi",
                        style: FontBase.regular.copyWith(
                          fontSize: 14,
                          color: ColorBase.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

showSendSuccesModal(context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Wrap(
        children: [
          Container(
            //height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: Dimens.sheetVertical,
              horizontal: Dimens.sheetHorizontal,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0),
              ),
            ),
            child: Column(
              children: [
                Container(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      child: Container(
                        child: Icon(Icons.close),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/succes.png",
                        height: MediaQuery.of(context).size.width / 3,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        "Sukses Mengirim Laporan",
                        style: FontBase.semiBold.copyWith(
                          fontSize: 16,
                          color: ColorBase.text,
                        ),
                      ),
                      Text(
                        "Laporan akan segera diproses oleh petugas",
                        style: FontBase.regular.copyWith(
                          fontSize: 14,
                          color: ColorBase.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

showSendFailedModal(context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Wrap(
        children: [
          Container(
            //height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: Dimens.sheetVertical,
              horizontal: Dimens.sheetHorizontal,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0),
              ),
            ),
            child: Column(
              children: [
                Container(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      child: Container(
                        child: Icon(Icons.close),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/failed.png",
                        height: MediaQuery.of(context).size.width / 3,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        "Gagal Mengirim Laporan",
                        style: FontBase.semiBold.copyWith(
                          fontSize: 16,
                          color: ColorBase.text,
                        ),
                      ),
                      Text(
                        "Gagal mengirim laporan. Silahkan coba lagi",
                        style: FontBase.regular.copyWith(
                          fontSize: 14,
                          color: ColorBase.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

showErrorModal(context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Wrap(
        children: [
          Container(
            //height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: Dimens.sheetVertical,
              horizontal: Dimens.sheetHorizontal,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0),
              ),
            ),
            child: Column(
              children: [
                Container(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      child: Container(
                        child: Icon(Icons.close),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/error.png",
                        height: MediaQuery.of(context).size.width / 3,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        "Error",
                        style: FontBase.semiBold.copyWith(
                          fontSize: 16,
                          color: ColorBase.text,
                        ),
                      ),
                      Text(
                        "Terjadi kesalahan. sialahkan coba lagi",
                        style: FontBase.regular.copyWith(
                          fontSize: 14,
                          color: ColorBase.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
