import 'package:desafio_toro/libraries/common/colors.dart';
import 'package:desafio_toro/libraries/media_query_tools/media_query_tools.dart';
import 'package:flutter/material.dart';

class AppBoxWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? child;
  final EdgeInsetsGeometry? padding;

  const AppBoxWidget(
      {Key? key, this.width, this.height, this.child, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width ?? MQuery.width(300),
        height: height ?? MQuery.width(400),
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: MQuery.height(60),
              horizontal: MQuery.width(50),
            ),
        decoration: BoxDecoration(
          color: blackWhite,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: blackWhite.shade200.withOpacity(0.25),
              offset: Offset(0, 4),
            )
          ],
        ),
        child: child ?? Container(),
      ),
    );
  }
}
