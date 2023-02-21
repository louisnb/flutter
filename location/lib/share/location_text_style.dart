import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/share/location_style.dart';

class LocationTextStyle {
  static final baseTextStyle = GoogleFonts.getFont('Raleway')
                                  .copyWith(color: LocationStyle.colorPurple);

  static final regularTextStyle = baseTextStyle.copyWith(
    fontSize: 13
  );
  static final regularWhiteTextStyle = baseTextStyle.copyWith(
    color: Colors.white70,
    fontSize: 13
  );
  static final boldTextStyle = baseTextStyle.copyWith(
    fontWeight: FontWeight.bold
  );
  static final subTitleboldTextStyle = baseTextStyle.copyWith(
      fontWeight: FontWeight.bold
  );
  static final priceGreyTextStyle = baseTextStyle.copyWith(
      color: Colors.grey,
      fontSize: 13
  );
}