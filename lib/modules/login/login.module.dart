import 'package:desafio_toro/libraries/session/data/session.repository.dart';
import 'package:desafio_toro/libraries/session/usecase/get_user.usecase.dart';
import 'package:desafio_toro/modules/home/home_module.dart';
import 'package:desafio_toro/modules/login/data/login.repository.dart';
import 'package:desafio_toro/modules/login/ui/signin/signin.view.dart';
import 'package:desafio_toro/modules/login/ui/signin/signin.viewmodel.dart';
import 'package:desafio_toro/modules/login/ui/signup/signup.view.dart';
import 'package:desafio_toro/modules/login/ui/signup/signup.viewmodel.dart';
import 'package:desafio_toro/modules/login/usecase/resend_email.usecase.dart';
import 'package:desafio_toro/modules/login/usecase/signin.usecase.dart';
import 'package:desafio_toro/modules/login/usecase/signup.usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  //Binds
  static final List<Bind> viewmodels = [
    Bind.lazySingleton((i) => SignInViewmodel()),
    Bind.lazySingleton((i) => SignUpViewmodel()),
  ];

  static final List<Bind> repositories = [
    Bind.lazySingleton((i) => LoginRepository()),
  ];

  static final List<Bind> usecases = [
    Bind.lazySingleton((i) => SignInUsecase()),
    Bind.lazySingleton((i) => SignUpUsecase()),
    Bind.lazySingleton((i) => ResendEmailUsecase()),
  ];

  //Routes
  static final List<ModularRoute> childRoutes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => SignInView()),
    ChildRoute('/signup',
        child: (_, args) => SignUpView(), transition: TransitionType.downToUp),
  ];

  static final List<ModularRoute> moduleRoutes = [
    ModuleRoute('/home', module: HomeModule()),
  ];

  @override
  final List<Bind> binds = viewmodels + repositories + usecases;

  @override
  final List<ModularRoute> routes = childRoutes + moduleRoutes;
}
