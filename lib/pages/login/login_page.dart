import 'dart:async';

import 'package:carros_app/pages/api_response.dart';
import 'package:carros_app/pages/carro/home_page.dart';
import 'package:carros_app/pages/login/login_api.dart';
import 'package:carros_app/pages/login/login_bloc.dart';
import 'package:carros_app/pages/login/usuarios.dart';

import 'package:carros_app/utils/alert.dart';
import 'package:carros_app/utils/push.dart';
import 'package:carros_app/widgets/app_button.dart';
import 'package:carros_app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _tLogin = TextEditingController();
  final _tSenha = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _focusSenha = FocusNode();

  final _bloc = LoginBloc();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future<Usuario> future = Usuario.get();
    future.then((Usuario user) {
      if(user != null) {
        push(context, HomePage(), replace: true);
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Carros',
        ),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            AppText(
              'Login',
              'Digite o login',
              controller: _tLogin,
              validator: _validateLogin,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              nextFocus: _focusSenha,
            ),
            SizedBox(
              height: 10,
            ),
            AppText(
              'Senha',
              'Digite sua senha',
              password: true,
              controller: _tSenha,
              validator: _validateSenha,
              keyboardType: TextInputType.number,
              focusNode: _focusSenha,
            ),
            SizedBox(
              height: 10,
            ),
            StreamBuilder<bool>(
              stream: _bloc.stream,
              initialData: false,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return AppButton(
                  'Login',
                  onPressed: _onClickLogin,
                  showProgress: snapshot.data,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  String _validateLogin(String text) {
    if (text.isEmpty) {
      return 'Digite o login';
    } else {
      return null;
    }
  }

  String _validateSenha(String text) {
    if (text.isEmpty) {
      return 'Digite a senha';
    }
    if (text.length < 3) {
      return 'A senha precisa possuir pelo menos 6 dígitos';
    }
    return null;
  }

  _onClickLogin() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    String login = _tLogin.text;
    String senha = _tSenha.text;

    print('Email: $login, senha: $senha');



    ApiResponse response = await _bloc.login(login, senha);

    if (response.ok) {
      Usuario user = response.result;
      print('>>>>> $user');
      push(context, HomePage());
    } else {
      alert(context, response.msg);
    }

  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
  }
}
