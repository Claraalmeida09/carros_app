import 'dart:async';

import 'package:carros_app/pages/api_response.dart';
import 'file:///C:/Users/cllar/AndroidStudioProjects/carros_app/lib/utils/simple_bloc.dart';
import 'package:carros_app/pages/login/login_api.dart';
import 'package:carros_app/pages/login/usuarios.dart';

class LoginBloc extends SimpleBloc<bool>{

  Future<ApiResponse<Usuario>> login(String login, String senha) async {
    add(true);
    ApiResponse response = await LoginApi.login(login, senha);
    add(false);

    return response;
  }
}