import 'package:flutter_modular/flutter_modular.dart';

abstract class IUseCaseRequestResult<TRequest, TResult> extends Disposable {
  Future<TResult> execute(TRequest request);
}

abstract class IUseCaseResult<TResult> extends Disposable {
  Future<TResult> execute();
}
