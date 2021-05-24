import 'package:desafio_toro/libraries/common/colors.dart';
import 'package:desafio_toro/libraries/common/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Toro Challenge',
      theme: ThemeData(
        primaryColor: purple,
        elevatedButtonTheme: ToroTheme.elevatedButton,
        floatingActionButtonTheme: ToroTheme.floatingButton,
        textButtonTheme: ToroTheme.textButton,
        outlinedButtonTheme: ToroTheme.outlineButton,
      ),
    ).modular();
  }
}
