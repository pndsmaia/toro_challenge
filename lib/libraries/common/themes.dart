import 'package:desafio_toro/libraries/common/colors.dart';
import 'package:flutter/material.dart';

class ToroTheme {
  static final ElevatedButtonThemeData elevatedButton = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: purple,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
  );

  static final FloatingActionButtonThemeData floatingButton =
      FloatingActionButtonThemeData(backgroundColor: purple);

  static final TextButtonThemeData textButton = TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: purple,
      textStyle: TextStyle(color: purple, decoration: TextDecoration.underline),
    ),
  );

  static final OutlinedButtonThemeData outlineButton = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: purple),
      primary: purple,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
  );
}
