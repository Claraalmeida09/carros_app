import 'dart:async';

import 'package:carros_app/pages/carro/carro.dart';
import 'package:carros_app/pages/carro/carros_api.dart';
import 'file:///C:/Users/cllar/AndroidStudioProjects/carros_app/lib/utils/simple_bloc.dart';

class CarrosBloc extends SimpleBloc<List<Carro>>{

  Future<List<Carro>> loadData(String tipo) async {
    try {
      List<Carro> carros = await CarrosApi.getCarros(tipo);
      add(carros);

      return carros;
    } catch (e) {
     addError(e);
    }
  }



}