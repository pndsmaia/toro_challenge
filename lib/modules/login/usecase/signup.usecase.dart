import 'package:desafio_toro/libraries/common/models/user.model.dart';
import 'package:desafio_toro/libraries/common/models/user_position.model.dart';
import 'package:desafio_toro/libraries/common/request_result.usecase.dart';
import 'package:desafio_toro/modules/login/data/login.repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpUsecase extends IUseCaseRequestResult<Map<String, dynamic>, bool> {
  final LoginRepository _loginRepository = Modular.get();

  @override
  Future<bool> execute(Map<String, dynamic> request) async {
    bool result = false;
    try {
      result = await _loginRepository.signUp(
        email: request['email'] ?? '',
        password: request['password'] ?? '',
        user: UserModel(
          id: '',
          name: request['name'],
          cpf: request['cpf'],
          email: request['email'],
          userPosition: UserPositionModel(
            checkingAccountAmount: 0.0,
            positions: [],
            consolidated: 0.0,
          ),
        ),
      );
    } catch (e) {
      rethrow;
    }
    return result;
  }

  @override
  void dispose() {}
}
