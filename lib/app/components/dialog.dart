import 'package:epengaduan/app/constants/fonts.dart';
import 'package:flutter/material.dart';

alrtDialog(BuildContext context, String title, String content) {
  content != null
      ? showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                title != null ? title : "",
                style: FontBase.bold.copyWith(
                  color: Color(0xFF434343),
                  fontSize: 18.0,
                ),
              ),
              content: Text(
                content,
                style: FontBase.regular.copyWith(
                  color: Color(0xFF434343),
                  fontSize: 18.0,
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        )
      : showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                title != null ? title : "",
                style: FontBase.bold.copyWith(
                  color: Color(0xFF434343),
                  fontSize: 18.0,
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
}
