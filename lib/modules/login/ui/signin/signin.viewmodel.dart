import 'package:desafio_toro/modules/login/usecase/resend_email.usecase.dart';
import 'package:desafio_toro/modules/login/usecase/signin.usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'signin.viewmodel.g.dart';

class SignInViewmodel = _SignInViewmodelBase with _$SignInViewmodel;

abstract class _SignInViewmodelBase with Store {
  final SignInUsecase _signInUsecase = Modular.get();
  final ResendEmailUsecase _resendEmailUsecase = Modular.get();

  @observable
  bool isLoading = false;

  @action
  void setIsLoading(value) => isLoading = value;

  Future<bool> signin({required String email, required String password}) async {
    bool result = false;
    try {
      result =
          await _signInUsecase.execute({'email': email, 'password': password});
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> resendEmail() async {
    try {
      return await _resendEmailUsecase.execute();
    } catch (e) {
      rethrow;
    }
  }
}
