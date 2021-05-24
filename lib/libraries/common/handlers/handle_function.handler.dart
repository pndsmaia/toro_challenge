import 'package:flutter/material.dart';

abstract class HandleFunction {
  Future<dynamic> handle({
    BuildContext? buildContext,
    int tentatives = 0,
    int maxTentatives = 0,
    required dynamic Function() mainFunc,
    required String successEvent,
    required String errorEvent,
    required String errorMessage,
    dynamic errorReturn,
  });
}
