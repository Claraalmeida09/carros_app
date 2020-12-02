import 'dart:async';

import 'package:carros_app/pages/carro/carro.dart';
import 'package:carros_app/pages/carro/carros_api.dart';
import 'package:carros_app/pages/carro/simple_bloc.dart';

class CarrosBloc extends SimpleBloc<List<Carro>>{

  loadData(String tipo) async {
    try {
      List<Carro> carros = await CarrosApi.getCarros(tipo);
      add(carros);
    } catch (e) {
     addError(e);
    }
  }



}