
import 'package:carros_app/pages/carro/carro.dart';
import 'package:carros_app/pages/login/usuarios.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class TipoCarro{
  static final String classicos = 'Classicos';
  static final String esportivos = 'Esportivos';
  static final String luxo = 'Luxo';
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {

    Usuario user = await Usuario.get();

    Map<String, String> headers = {
      "Content-Type": 'aplication/json',
      'Authorization': 'Bearer ${user.token}'
    };

    print(headers);

    var url = 'https://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo';

    print("GET > $url");

    var response = await http.get(url, headers: headers);

    String json = response.body;
    print(json);

    List list = convert.json.decode(json);

    List<Carro> carros = list.map<Carro>((map) => Carro.fromJson(map)).toList();

    return carros;
  }
}