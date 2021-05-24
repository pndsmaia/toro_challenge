import 'package:desafio_toro/modules/login/usecase/signup.usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'signup.viewmodel.g.dart';

class SignUpViewmodel = _SignUpViewmodelBase with _$SignUpViewmodel;

abstract class _SignUpViewmodelBase with Store {
  final SignUpUsecase _signUpUsecase = Modular.get();

  @observable
  bool isLoading = false;

  @action
  void setIsLoading(bool value) => isLoading = value;

  Future<bool> signUp({
    required String name,
    required String cpf,
    required String email,
    required String password,
  }) async {
    bool result = false;
    try {
      result = await _signUpUsecase.execute({
        'name': name,
        'cpf': cpf,
        'email': email,
        'password': password,
      });
    } catch (e) {
      rethrow;
    }
    return result;
  }
}
