import 'dart:async';

import 'package:carros_app/pages/carro/carro.dart';
import 'package:carros_app/pages/carro/carros_api.dart';
import 'package:mobx/mobx.dart';

part 'carros_model.g.dart';

class CarrosModel = CarrosModelBase with _$CarrosModel;

abstract class CarrosModelBase with Store {

  @observable
  List<Carro> carros;
  @observable
  Exception error;

  @action
  loadData(String tipo) async {
    try {
      error = null;

      this.carros = await CarrosApi.getCarros(tipo);

    } catch (e) {
     error = e;
    }
  }



}