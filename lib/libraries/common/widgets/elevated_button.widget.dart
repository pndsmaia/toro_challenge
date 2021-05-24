import 'package:desafio_toro/libraries/media_query_tools/media_query_tools.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatefulWidget {
  final String text;
  final double? width;
  final double? height;
  final Function()? onPressed;

  ElevatedButtonWidget({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  _ElevatedButtonWidgetState createState() => _ElevatedButtonWidgetState();
}

class _ElevatedButtonWidgetState extends State<ElevatedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? MQuery.width(260),
      height: widget.height ?? MQuery.height(45),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        child: FittedBox(child: Text(widget.text.toUpperCase())),
      ),
    );
  }
}
