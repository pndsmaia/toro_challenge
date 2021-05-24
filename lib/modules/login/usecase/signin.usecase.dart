import 'package:desafio_toro/libraries/common/request_result.usecase.dart';
import 'package:desafio_toro/modules/login/data/login.repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignInUsecase extends IUseCaseRequestResult<Map<String, String>, bool> {
  final LoginRepository _loginRepository = Modular.get();

  @override
  Future<bool> execute(Map<String, String> request) async {
    bool result = false;
    try {
      result = await _loginRepository.signIn(
          email: request['email'] ?? '', password: request['password'] ?? '');
    } catch (e) {
      rethrow;
    }
    return result;
  }

  @override
  void dispose() {}
}
