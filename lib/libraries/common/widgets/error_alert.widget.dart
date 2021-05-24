import 'package:desafio_toro/libraries/common/text_styles.dart';
import 'package:desafio_toro/libraries/common/widgets/app_box.widget.dart';
import 'package:desafio_toro/libraries/common/widgets/elevated_button.widget.dart';
import 'package:desafio_toro/libraries/media_query_tools/media_query_tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'outline_button.widget.dart';

class ErrorAlert {
  static Future<void> show({
    required BuildContext context,
    required bool isGenericError,
    required String error,
    bool? barrierDismissible,
    Function()? func,
    String? title,
    String? text,
    String? img,
    double? imgWidth,
    double? imgHeight,
    List<Widget>? actions,
    MainAxisAlignment? actionsAlignment,
  }) async {
    if (isGenericError) {
      await showDialog(
        context: context,
        barrierDismissible: barrierDismissible ?? false,
        builder: (context) => ErrorAlertWidget(
          title: title ?? 'Ops, Parece que tem algo errado...',
          text: text ??
              'Serviço indisponível, tente novamente mais tarde.\n\nEstamos trabalhando para trazer uma experiência ainda melhor para você.',
          img: img ?? '',
          actions: actions ??
              [
                OutlineButtonWidget(
                  text: 'Tentar novamente',
                  width: MQuery.width(193),
                  height: MQuery.height(60),
                  onPressed: () {},
                ),
                Spacer(),
                ElevatedButtonWidget(
                  text: 'ok'.toUpperCase(),
                  width: MQuery.width(193),
                  height: MQuery.height(60),
                  onPressed: () {
                    Modular.to.pop();
                  },
                )
              ],
          actionsAlignment: actionsAlignment ?? actionsAlignment,
          imgHeight: imgHeight,
          imgWidth: imgWidth,
        ),
      );
    } else {
      await showDialog(
        context: context,
        barrierDismissible: barrierDismissible ?? false,
        builder: (context) => ErrorAlertWidget(
          title: title ?? 'Ops, Parece que tem algo errado...',
          text: text ??
              'Serviço indisponível, tente novamente mais tarde.\n\nEstamos trabalhando para trazer uma experiência ainda melhor para você.',
          img: img ?? '',
          actions: actions,
          actionsAlignment: actionsAlignment,
          imgHeight: imgHeight,
          imgWidth: imgWidth,
        ),
      );
    }
  }
}

class ErrorAlertWidget extends StatefulWidget {
  final String? text;
  final String? img;
  final String? title;
  final double? imgWidth;
  final double? imgHeight;
  final List<Widget>? actions;
  final MainAxisAlignment? actionsAlignment;

  const ErrorAlertWidget({
    Key? key,
    required this.text,
    required this.title,
    this.img,
    this.imgWidth,
    this.imgHeight,
    this.actions,
    this.actionsAlignment,
  }) : super(key: key);

  @override
  _ErrorAlertWidgetState createState() => _ErrorAlertWidgetState();
}

class _ErrorAlertWidgetState extends State<ErrorAlertWidget> {
  @override
  Widget build(BuildContext context) {
    MQuery.configure(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBoxWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title ?? 'Ops, Parece que tem algo errado...',
              style: ToroText.title,
            ),
            Spacer(),
            Text(
              widget.text ??
                  'Serviço indisponível, tente novamente mais tarde.\n\nEstamos trabalhando para trazer uma experiência ainda melhor para você.',
              style: ToroText.text,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: widget.actions ??
                  [
                    ElevatedButtonWidget(
                      text: 'ok'.toUpperCase(),
                      width: MQuery.width(193),
                      height: MQuery.isPortrait
                          ? MQuery.height(45)
                          : MQuery.height(60),
                      onPressed: () {
                        Modular.to.pop();
                      },
                    )
                  ],
            )
          ],
        ),
      ),
    );
  }
}
