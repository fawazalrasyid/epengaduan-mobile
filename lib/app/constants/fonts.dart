import 'package:epengaduan/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontBase {
  static final bold = GoogleFonts.nunito(
    fontWeight: FontWeight.w700,
    color: ColorBase.text,
  );

  static final semiBold = GoogleFonts.nunito(
    fontWeight: FontWeight.w600,
    color: ColorBase.text,
  );

  static final regular = GoogleFonts.nunito(
    fontWeight: FontWeight.w400,
    color: ColorBase.text,
  );
}
