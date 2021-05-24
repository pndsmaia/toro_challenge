import 'package:desafio_toro/libraries/common/colors.dart';
import 'package:desafio_toro/libraries/common/images.dart';
import 'package:desafio_toro/libraries/media_query_tools/media_query_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((_) {
      Modular.to.pushReplacementNamed('/login');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MQuery.configure(context);
    return Container(
      color: blackWhite,
      padding: EdgeInsets.symmetric(horizontal: MQuery.width(23)),
      child: Center(
        child: Image.asset(ToroImg.torologo),
      ),
    );
  }
}
