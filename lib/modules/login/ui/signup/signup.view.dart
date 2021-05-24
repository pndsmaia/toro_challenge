import 'package:brasil_fields/brasil_fields.dart';
import 'package:desafio_toro/libraries/common/firebase/firebase_analytics.dart';
import 'package:desafio_toro/libraries/common/firebase/firebase_crashlytics.dart';
import 'package:desafio_toro/libraries/common/handlers/handle_function.handler.dart';
import 'package:desafio_toro/libraries/common/text_styles.dart';
import 'package:desafio_toro/libraries/common/widgets/elevated_button.widget.dart';
import 'package:desafio_toro/libraries/common/widgets/error_alert.widget.dart';
import 'package:desafio_toro/libraries/common/widgets/loading.widget.dart';
import 'package:desafio_toro/libraries/common/widgets/page_container.widget.dart';
import 'package:desafio_toro/libraries/common/widgets/text_form_field.widget.dart';
import 'package:desafio_toro/libraries/media_query_tools/media_query_tools.dart';
import 'package:desafio_toro/modules/login/ui/signup/signup.viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends ModularState<SignUpView, SignUpViewmodel>
    with HandleFunction {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Stack(
        children: [
          PageContainerWidget(
            height: MQuery.height(
                MQuery.avaliableHeight(_appBar.preferredSize.height)),
            appBar: _appBar,
            child: Column(
              children: [
                Text(
                  'Crie sua conta de forma rápida e fácil!',
                  style: ToroText.title,
                ),
                Spacer(),
                _form(),
                Spacer(),
                _signUpButton(),
              ],
            ),
          ),
          if (store.isLoading)
            LoadingWidget(isBasic: false, text: 'Cadastrando...'),
        ],
      );
    });
  }

  PreferredSizeWidget get _appBar {
    return AppBar(
      title: Text('Cadastro'),
      centerTitle: true,
    );
  }

  Widget _form() {
    return Container(
      height: MQuery.height(500),
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
          controller: _nameController,
          labelText: 'Nome completo',
          keyboardType: TextInputType.name,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por Favor, preencha o campo.';
            }
            return null;
          },
        ),
        SizedBox(
          height: MQuery.height(20),
        ),
        TextFormFieldWidget(
          controller: _cpfController,
          labelText: 'CPF',
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CpfInputFormatter(),
          ],
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por Favor, preencha o campo.';
            }
            return null;
          },
        ),
        SizedBox(
          height: MQuery.height(20),
        ),
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
        SizedBox(
          height: MQuery.height(20),
        ),
        TextFormFieldWidget(
          controller: _rePasswordController,
          labelText: 'Repetir Senha',
          obscureText: true,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Por Favor, preencha o campo.';
            } else if (_passwordController.text != _rePasswordController.text) {
              return 'Suas senhas não coincidem!';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _signUpButton() {
    return Container(
      margin:
          EdgeInsets.only(top: MQuery.height(20), bottom: MQuery.height(16)),
      child: ElevatedButtonWidget(
        text: 'Abrir conta',
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            bool? isCreated = false;
            String auxCpf = _cpfController.text.replaceAll('.', '');

            isCreated = await handle(
              mainFunc: () => store.signUp(
                name: _nameController.text,
                cpf: auxCpf.replaceAll('-', ''),
                email: _emailController.text,
                password: _passwordController.text,
              ),
              successEvent: 'LOGIN_SIGNUP_SUCESS',
              errorEvent: 'LOGIN_SIGNUP_ERROR',
              errorMessage: 'ERROR TO CREATE ACCOUNT',
            );
            if (isCreated != null && isCreated) Modular.to.pop();
          }
        },
      ),
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
        if (e.code == "email-already-in-use") {
          ErrorAlert.show(
            context: context,
            isGenericError: false,
            text: 'Ops, parece que você já possui uma conta.',
            error: e.code.toString(),
          );
        } else if (e.code == "invalid-email") {
          ErrorAlert.show(
            context: context,
            isGenericError: false,
            text: 'Este email não é válido',
            error: e.code.toString(),
          );
        } else if (e.code == "operation-not-allowed") {
          ErrorAlert.show(
            context: context,
            isGenericError: false,
            text: 'Operação não permitida!',
            error: e.code.toString(),
          );
        } else if (e.code == "weak-password") {
          ErrorAlert.show(
            context: context,
            isGenericError: false,
            text: 'A senha informada é fraca, por favor inserir outra senha.',
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
      String message = e.toString();
      if (message.contains('cpf-in-use')) {
        await FbAnalytics.sendEvent(event: errorEvent);
        await FbCrashlytics.sendNonFatalCrash(e, s, message: errorMessage);
        ErrorAlert.show(
          context: context,
          text: 'O CPF já está em uso',
          isGenericError: false,
          error: 'cpf-in-use',
        );
      }
    } catch (e, s) {
      await FbAnalytics.sendEvent(event: errorEvent);
      await FbCrashlytics.sendNonFatalCrash(e, s, message: errorMessage);
      ErrorAlert.show(
          context: context, isGenericError: false, error: e.toString());
    }
  }
}
