import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'utils.dart';

class CustomTextConfig extends TextTheme{
  final BuildContext context;

  CustomTextConfig(this.context);

  @override
  TextStyle get display1 => GoogleFonts.prompt(color: Colors.white, fontWeight: FontWeight.w500, shadows: [Shadow(blurRadius: 3,
      color: Colors.white54, offset: Offset(1.0, 1.0))], fontSize: 5.0 * SizeConfig.textMultiplier);

  @override
  TextStyle get display2 => GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 2.0 * SizeConfig.textMultiplier);


  @override
  TextStyle get display3 => GoogleFonts.ptSans(color: Colors.white, fontWeight: FontWeight.w500, shadows: [Shadow(blurRadius: 3,
        color: Colors.black54, offset: Offset(2.0, 2.0))], fontSize: 2.2 * SizeConfig.textMultiplier);

  @override
  TextStyle get display4 => GoogleFonts.ptSans(color: Colors.white, fontWeight: FontWeight.w500, shadows: [Shadow(blurRadius: 3,
      color: Colors.white54, offset: Offset(1.0, 1.0))], fontSize: 1.5 * SizeConfig.textMultiplier);

}