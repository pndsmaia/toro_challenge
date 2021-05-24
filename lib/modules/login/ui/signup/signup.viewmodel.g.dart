// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup.viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignUpViewmodel on _SignUpViewmodelBase, Store {
  final _$isLoadingAtom = Atom(name: '_SignUpViewmodelBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$_SignUpViewmodelBaseActionController =
      ActionController(name: '_SignUpViewmodelBase');

  @override
  void setIsLoading(bool value) {
    final _$actionInfo = _$_SignUpViewmodelBaseActionController.startAction(
        name: '_SignUpViewmodelBase.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$_SignUpViewmodelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
