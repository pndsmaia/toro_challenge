import 'package:desafio_toro/libraries/common/colors.dart';
import 'package:desafio_toro/libraries/media_query_tools/media_query_tools.dart';
import 'package:flutter/material.dart';

class ToroText {
  static TextStyle get title =>
      TextStyle(fontSize: MQuery.text(14), color: purple[200]);

  static TextStyle get text => TextStyle(
        fontSize: MQuery.text(13),
        color: purple[200],
        fontWeight: FontWeight.w300,
      );

  static TextStyle get textButtons => TextStyle(
        fontSize: MQuery.text(16),
        color: purple[200],
        fontWeight: FontWeight.w300,
      );
}
