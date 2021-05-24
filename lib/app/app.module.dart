import 'package:desafio_toro/app/Splash/splash.view.dart';
import 'package:desafio_toro/modules/home/home_module.dart';
import 'package:desafio_toro/modules/login/login.module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  //Routes
  static final List<ModularRoute> childRoutes = [
    ChildRoute(Modular.initialRoute, child: (context, args) => SplashView()),
  ];

  static final List<ModularRoute> moduleRoutes = [
    ModuleRoute('/login', module: LoginModule()),
    ModuleRoute('/home', module: HomeModule()),
  ];

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = childRoutes + moduleRoutes;
}
