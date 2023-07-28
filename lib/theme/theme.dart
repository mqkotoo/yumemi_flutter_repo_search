import 'package:flutter/material.dart';

import 'package:yumemi_flutter_repo_search/color/shimmer_color.dart';

//light theme ----------------------------------
ThemeData lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: const Color(0xffFCFDF6),

  //appbar theme
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    backgroundColor: Color(0xffFCFDF6),
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Color(0xff000000),
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    iconTheme: IconThemeData(
      color: Color(0xff000000),
    ),
  ),

  //textField theme
  inputDecorationTheme: InputDecorationTheme(
    prefixIconColor: const Color(0xff9e9e9e),
    suffixIconColor: const Color(0xff9e9e9e),
    fillColor: const Color(0xffe1eedf),
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Colors.transparent,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Color(0xff9e9e9e),
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    isDense: true,
  ),

  // divider
  dividerColor: const Color(0x47000000),

  //RADIOボタンのアクティブ時の色
  radioTheme: RadioThemeData(
    fillColor:
        MaterialStateColor.resolveWith((states) => const Color(0xFFFF9800)),
  ),

  //shimmer,result countのテーマ
  extensions: <ThemeExtension<dynamic>>[
    ShimmerColor.light,
  ],
);

//dark theme ----------------------------------
ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color(0xff1A1C19),
  //appbar theme
  appBarTheme: const AppBarTheme(
    centerTitle: false,
    backgroundColor: Color(0xff1A1C19),
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Color(0xffffffff),
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    iconTheme: IconThemeData(
      color: Color(0xffffffff),
    ),
  ),

  //textField theme
  inputDecorationTheme: InputDecorationTheme(
    prefixIconColor: const Color(0xff9e9e9e),
    suffixIconColor: const Color(0xff9e9e9e),
    fillColor: const Color(0xff454f45),
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Colors.transparent,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(
        color: Color(0xff9e9e9e),
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    isDense: true,
  ),

  // divider
  dividerColor: const Color(0xff777777),

  //RADIOボタンのアクティブ時の色
  radioTheme: RadioThemeData(
    fillColor:
        MaterialStateColor.resolveWith((states) => const Color(0xFF536DFE)),
  ),

  // shimmer,result countのテーマ
  extensions: <ThemeExtension<dynamic>>[
    ShimmerColor.dark,
  ],
);
