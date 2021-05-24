import 'package:desafio_toro/libraries/media_query_tools/media_query_tools.dart';
import 'package:flutter/material.dart';

class OutlineButtonWidget extends StatefulWidget {
  final String text;
  final double? width;
  final double? height;
  final Function()? onPressed;

  OutlineButtonWidget({
    Key? key,
    required this.onPressed,
    required this.text,
    this.width,
    this.height,
    child,
  }) : super(key: key);

  @override
  _OutlineButtonWidgetState createState() => _OutlineButtonWidgetState();
}

class _OutlineButtonWidgetState extends State<OutlineButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? MQuery.width(260),
      height: widget.height ?? MQuery.height(45),
      child: OutlinedButton(
        onPressed: widget.onPressed,
        child: FittedBox(
          child: Text(widget.text.toUpperCase()),
        ),
      ),
    );
  }
}
