import 'package:desafio_toro/libraries/common/request_result.usecase.dart';
import 'package:desafio_toro/libraries/session/data/session.repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GetUserUsecase extends IUseCaseResult<User> {
  final SessionRepository _sessionRepository = Modular.get();

  @override
  Future<User> execute() async {
    return Future.value(_sessionRepository.getUser);
  }

  @override
  void dispose() {}
}
