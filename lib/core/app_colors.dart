import 'package:flutter/material.dart';

class AppColors {
  ///* CSV */
  // cde8e0,68bea4,0ba47c,44b494,8cccb4,14a47d,34ab89,1fa484,44b48c
  //
  // /* Array */
  // ["cde8e0","68bea4","0ba47c","44b494","8cccb4","14a47d","34ab89","1fa484","44b48c"]
  static const MaterialColor secondary = MaterialColor(
    0xFF0BA47C,
    <int, Color>{
      50: Color(0xFFE8F7F2),
      100: Color(0xFFCDE8E0),
      200: Color(0xFFAED9CE),
      300: Color(0xFF8CCCB4),
      400: Color(0xFF68BEA4),
      500: Color(0xFF44B494),
      600: Color(0xFF34AB89),
      700: Color(0xFF1FA484),
      800: Color(0xFF14A47D),
      900: Color(0xFF0BA47C),
    },
  );

  /*/* CSV */
a9acaf,5b5c5c,8c8c93,1c2424,242424,483c7c,503c24,244024,282424,282424

/* Array */
["a9acaf","5b5c5c","8c8c93","1c2424","242424","483c7c","503c24","244024","282424","282424"]*/
  static const MaterialColor primary = MaterialColor(
    0xFF5B5C5C,
    <int, Color>{
      50: Color(0xFFE8E8E8),
      100: Color(0xFFCFCFCF),
      200: Color(0xFFB3B3B3),
      300: Color(0xFF8C8C93),
      400: Color(0xFF5B5C5C),
      500: Color(0xFF242424),
      600: Color(0xFF282424),
      700: Color(0xFF1C2424),
      800: Color(0xFF242424),
      900: Color(0xFF242424),
    },
  );
}
