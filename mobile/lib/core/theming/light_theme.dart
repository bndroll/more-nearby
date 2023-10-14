import 'package:flutter/material.dart';

final lightTheme = ThemeData.light(useMaterial3: true).copyWith(
  colorScheme:  const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF0C277D),
        onPrimary: Color(0xFF0C277D),
        secondary: Color(0xFFF0F4F8),
        onSecondary: Color(0xFFF0F4F8),
        error: Colors.deepOrangeAccent,
        onError: Colors.deepOrangeAccent,
        background: Colors.white,
        onBackground: Colors.white,
        surface: Colors.white,
        onSurface: Colors.white
    ),
    bottomSheetTheme: const BottomSheetThemeData(
        surfaceTintColor: Colors.transparent,
        dragHandleColor: Colors.transparent,
        modalBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        modalBarrierColor: Colors.transparent
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Color(0xFFF0F4F8)),
        textStyle: MaterialStatePropertyAll(TextStyle(
          color: Color(0xFF555E68),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        )),
        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 12, vertical: 2)),
        side: MaterialStatePropertyAll(
          BorderSide.none
        ),
        shadowColor: MaterialStatePropertyAll(Colors.transparent),
        elevation: MaterialStatePropertyAll(0),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))))
      )
    )
  );