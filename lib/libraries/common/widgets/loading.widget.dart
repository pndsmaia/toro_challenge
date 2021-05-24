import 'package:desafio_toro/libraries/common/animations.dart';
import 'package:desafio_toro/libraries/common/colors.dart';
import 'package:desafio_toro/libraries/media_query_tools/media_query_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class LoadingWidget extends StatefulWidget {
  final bool isBasic;
  final double? width;
  final double? height;
  final String? text;

  const LoadingWidget({
    Key? key,
    this.isBasic = true,
    this.width,
    this.height,
    this.text,
  }) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  Artboard? _loadingArtboard;
  RiveAnimationController? controller;

  @override
  void initState() {
    super.initState();
    rootBundle.load(ToroAnimations.loading).then(
      (data) async {
        final RiveFile file = RiveFile.import(data);
        final Artboard artboard = file.mainArtboard;
        artboard.addController(controller = SimpleAnimation('a1'));
        setState(() => _loadingArtboard = artboard);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MQuery.configure(context);
    if (widget.isBasic)
      return Container(
        color: blackWhite.shade200.withOpacity(0.5),
        width: MQuery.widthPercent(100),
        height: MQuery.heightPercent(100),
        child: Center(
          child: Center(
            child: _loadingArtboard == null
                ? Container()
                : Container(
                    width: MQuery.width(100),
                    height: MQuery.height(100),
                    child: Rive(artboard: _loadingArtboard!),
                  ),
          ),
        ),
      );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: blackWhite.shade200.withOpacity(0.5),
        width: MQuery.widthPercent(100),
        height: MQuery.heightPercent(100),
        child: Center(
          child: Container(
            width: widget.width ?? MQuery.width(300, max: 328),
            height: widget.height ?? MQuery.height(118),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: blackWhite,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: MQuery.height(12)),
                  child: Center(
                    child: _loadingArtboard == null
                        ? Container()
                        : Container(
                            width: MQuery.width(45, min: 35),
                            height: MQuery.height(45, min: 35),
                            child: Rive(artboard: _loadingArtboard!),
                          ),
                  ),
                ),
                Container(
                  width: MQuery.width(300.0),
                  child: Text(
                    widget.text ?? 'Carregando...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.5,
                      fontSize: MQuery.textScale(14, min: 12),
                      color: blackWhite[200],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
