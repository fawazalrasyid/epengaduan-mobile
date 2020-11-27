import 'package:epengaduan/app/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Dimens.cardMargin),
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.blueGrey[50],
            highlightColor: Colors.grey[50],
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(Dimens.cardRadius),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.blueGrey[100],
            highlightColor: Colors.grey[100],
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(Dimens.cardPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 12.0,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 12.0,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: 12.0,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
