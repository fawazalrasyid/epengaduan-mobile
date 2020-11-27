import 'package:epengaduan/app/constants/colors.dart';
import 'package:epengaduan/app/constants/dimens.dart';
import 'package:epengaduan/app/constants/fonts.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final title;

  Header({this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: ColorBase.blue,
          height: 120.0,
          padding: EdgeInsets.symmetric(horizontal: Dimens.defaultPadding),
          child: Row(
            children: [
              Container(
                child: title != null
                    ? Text(
                        title,
                        style: FontBase.bold.copyWith(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      )
                    : Image.asset(
                        "assets/images/ePengaduan-light.png",
                        width: 130.0,
                      ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: -1,
          child: Container(
            height: 30.0,
            decoration: BoxDecoration(
              color: Color(0xFFFAFAFA),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35.0),
                topRight: Radius.circular(35.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
