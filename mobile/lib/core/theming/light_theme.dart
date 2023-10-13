import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: const MaterialColor(
        0xFF0C277D,
        {
          100: Color(0xFFe3effb),
          200: Color(0xFFc7dff7)
        }
    ),
    errorColor: const Color(0xFFC41C1C),
    backgroundColor: Colors.white
  )
);