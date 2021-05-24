import 'package:desafio_toro/libraries/media_query_tools/media_query_tools.dart';
import 'package:flutter/material.dart';

class PageContainerWidget extends StatelessWidget {
  final Widget? child;
  final PreferredSizeWidget? appBar;
  final double? width;
  final double? height;

  const PageContainerWidget(
      {Key? key, this.child, this.appBar, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          height: height ?? MQuery.heightPercent(100),
          width: width ?? MQuery.widthPercent(100),
          padding: EdgeInsets.symmetric(
            horizontal: MQuery.width(16),
            vertical: MQuery.height(30),
          ),
          child: child,
        ),
      ),
    );
  }
}
