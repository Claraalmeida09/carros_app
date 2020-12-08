import 'dart:async';
import 'package:carros_app/pages/carros/carro.dart';
import 'package:carros_app/pages/carros/carros_api.dart';
import 'file:///C:/Users/cllar/AndroidStudioProjects/carros_app/lib/utils/simple_bloc.dart';
import 'package:carros_app/pages/favoritos/carro_dao.dart';
import 'package:carros_app/utils/network.dart';

class CarrosBloc extends SimpleBloc<List<Carro>>{

  Future<List<Carro>> loadData(String tipo) async {
    try {

      bool networkOn = await isNetworkOn();

      if(! networkOn) {
        List<Carro> carros = await CarroDAO().findAllByTipo(tipo);
        add(carros);
        return carros;
      }
      List<Carro> carros = await CarrosApi.getCarros(tipo);

      if(carros.isNotEmpty) {
      final dao = CarroDAO();
      //Salvar todos os carros
        carros.forEach(dao.save);
      }

      add(carros);

      return carros;
    } catch (e) {
      print(e);
     addError(e);
    }
  }



}