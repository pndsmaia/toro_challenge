import 'package:desafio_toro/libraries/common/request_result.usecase.dart';
import 'package:desafio_toro/modules/login/data/login.repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ResendEmailUsecase extends IUseCaseResult<bool> {
  final LoginRepository _loginRepository = Modular.get();
  @override
  Future<bool> execute() async {
    try {
      return await _loginRepository.resendEmail();
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {}
}
