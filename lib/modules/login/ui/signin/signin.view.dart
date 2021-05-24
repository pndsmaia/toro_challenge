import 'package:desafio_toro/libraries/common/colors.dart';
import 'package:desafio_toro/libraries/common/firebase/firebase_analytics.dart';
import 'package:desafio_toro/libraries/common/firebase/firebase_crashlytics.dart';
import 'package:desafio_toro/libraries/common/handlers/handle_function.handler.dart';
import 'package:desafio_toro/libraries/common/images.dart';
import 'package:desafio_toro/libraries/common/widgets/elevated_button.widget.dart';
import 'package:desafio_toro/libraries/common/widgets/error_alert.widget.dart';
import 'package:desafio_toro/libraries/common/widgets/loading.widget.dart';
import 'package:desafio_toro/libraries/common/widgets/outline_button.widget.dart';
import 'package:desafio_toro/libraries/common/widgets/page_container.widget.dart';
import 'package:desafio_toro/libraries/common/widgets/text_form_field.widget.dart';
import 'package:desafio_toro/libraries/media_query_tools/media_query_tools.dart';
import 'package:desafio_toro/modules/login/ui/signin/signin.viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends ModularState<SignInView, SignInViewmodel>
    with HandleFunction {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String loadingMessage = 'Entrando...';

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Stack(
        children: [
          PageContainerWidget(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _headerImg(),
                Spacer(),
                _headerDescription(),
                Spacer(),
                _form(),
                Spacer(),
                _signInButton(),
                _signUpButton(),
                Spacer(),
                TextButton(child: Text('Esqueceu sua senha?'), onPressed: () {})
              ],
            ),
          ),
          if (store.isLoading)
            LoadingWidget(isBasic: false, text: loadingMessage),
        ],
      );
    });
  }

  Widget _headerImg() {
    return Container(
      margin: EdgeInsets.only(top: MQuery.height(100)),
      padding: EdgeInsets.symmetric(horizontal: MQuery.width(50)),
      child: Image.asset(ToroImg.torologo),
    );
  }

  Widget _headerDescription() {
    return Container(
      margin: EdgeInsets.only(bottom: MQuery.height(20)),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: blackWhite[200],
            fontWeight: FontWeight.bold,
            fontSize: MQuery.text(13),
          ),
          children: [
            TextSpan(text: 'O jeito mais fácil de '),
            TextSpan(text: 'investir ', style: TextStyle(color: purple)),
            TextSpan(text: 'na Bolsa.'),
          ],
        ),
      ),
    );
  }

  Widget _form() {
    return Container(
      height: MQuery.height(220),
      child: Form(
        key: _formKey,
        child: _fieldList(),
      ),
    );
  }

  Widget _fieldList() {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        TextFormFieldWidget(
          controller: _emailController,
          labelText: 'Email',
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            RegExp emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (value == null || value.isEmpty) {
              return 'Por Favor, preencha o campo.';
            } else if (emailPattern.hasMatch(value)) {
              return null;
            }
            return 'O email está incorreto.';
          },
        ),
        SizedBox(
          height: MQuery.height(20),
        ),
        TextFormFieldWidget(
          controller: _passwordController,
          labelText: 'Senha',
          obscureText: true,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Por Favor, preencha o campo.';
            } else if (value.length < 6) {
              return 'A senha deve possuir 6 caracteres';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _signInButton() {
    return Container(
      margin:
          EdgeInsets.only(top: MQuery.height(20), bottom: MQuery.height(16)),
      child: ElevatedButtonWidget(
        text: 'Entrar',
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            loadingMessage = 'Entrando...';
            bool? isLogged = false;

            isLogged = await handle(
              mainFunc: () => store.signin(
                email: _emailController.text,
                password: _passwordController.text,
              ),
              successEvent: 'LOGIN_SIGNIN_SUCESS',
              errorEvent: 'LOGIN_SIGNIN_ERROR',
              errorMessage: 'ERROR TO MAKE SIGNIN',
            );
            if (isLogged != null && isLogged)
              Modular.to.pushReplacementNamed('/login/home');
          }
        },
      ),
    );
  }

  Widget _signUpButton() {
    return OutlineButtonWidget(
      text: 'Abra sua conta',
      onPressed: () {
        Modular.to.pushNamed('/login/signup');
      },
    );
  }

  @override
  Future handle({
    BuildContext? buildContext,
    int tentatives = 0,
    int maxTentatives = 0,
    required Function() mainFunc,
    required String successEvent,
    required String errorEvent,
    required String errorMessage,
    errorReturn,
  }) async {
    try {
      store.setIsLoading(true);
      dynamic mainReturn = await mainFunc();
      await FbAnalytics.sendEvent(event: successEvent);
      store.setIsLoading(false);
      return mainReturn;
    } on FirebaseAuthException catch (e, s) {
      if (tentatives < maxTentatives) {
        tentatives++;
        Future.delayed(Duration(seconds: 3)).then(
          (_) async {
            return await handle(
              tentatives: tentatives,
              maxTentatives: maxTentatives,
              buildContext: buildContext,
              mainFunc: mainFunc,
              successEvent: successEvent,
              errorEvent: errorEvent,
              errorMessage: errorMessage,
              errorReturn: errorReturn,
            );
          },
        );
      } else {
        store.setIsLoading(false);
        await FbAnalytics.sendEvent(event: errorEvent);
        await FbCrashlytics.sendNonFatalCrash(e, s, message: errorMessage);
        if (e.code == "wrong-password") {
          ErrorAlert.show(
            context: context,
            isGenericError: false,
            text:
                'Email e/ou senha estão incorreto(s).\n\nPor favor, verifique e tente novamente.',
            error: e.code.toString(),
          );
        } else if (e.code == "invalid-email") {
          ErrorAlert.show(
            context: context,
            isGenericError: false,
            text:
                'Email e/ou senha estão incorreto(s).\n\nPor favor, verifique e tente novamente.',
            error: e.code.toString(),
          );
        } else if (e.code == "user-disabled") {
          ErrorAlert.show(
            context: context,
            isGenericError: false,
            text:
                'O usuário foi desabilitado.\n\nPor favor, entre em contato com o suporte.',
            error: e.code.toString(),
          );
        } else if (e.code == "user-not-found") {
          ErrorAlert.show(
            context: context,
            isGenericError: false,
            text:
                'O email digitado não foi encontrado.\n\nPor favor, verifique o seu email.',
            error: e.code.toString(),
          );
        } else if (e.code == "too-many-requests") {
          ErrorAlert.show(
            context: context,
            isGenericError: false,
            text:
                'Parece que alguém tentou entrar várias vezes na sua conta.\n\nPor questões de segurança, aguarde um pouco e tente novamente mais tarde.',
            error: e.code.toString(),
          );
        } else {
          ErrorAlert.show(
            context: context,
            isGenericError: false,
            error: e.code.toString(),
          );
        }
        return errorReturn;
      }
    } on Exception catch (e, s) {
      store.setIsLoading(false);
      if (e.toString().contains('email-not-verified')) {
        await FbAnalytics.sendEvent(event: errorEvent);
        await FbCrashlytics.sendNonFatalCrash(e, s, message: errorMessage);
        ErrorAlert.show(
          context: context,
          text: 'O email precisa ser verificado.\n\nDeseja Reenviar o email?',
          actions: [
            OutlineButtonWidget(
                width: MQuery.width(90),
                text: 'Reenviar',
                onPressed: () async {
                  loadingMessage = 'Reenviando...';
                  Modular.to.pop();
                  store.setIsLoading(true);
                  await store.resendEmail();
                  store.setIsLoading(false);
                }),
            Spacer(),
            ElevatedButtonWidget(
              width: MQuery.width(90),
              text: 'ok',
              onPressed: () => Modular.to.pop(),
            ),
          ],
          isGenericError: false,
          error: e.toString(),
        );
      }
    } catch (e, s) {
      store.setIsLoading(false);
      await FbAnalytics.sendEvent(event: errorEvent);
      await FbCrashlytics.sendNonFatalCrash(e, s, message: errorMessage);
      ErrorAlert.show(
          context: context, isGenericError: false, error: e.toString());
    }
  }
}
