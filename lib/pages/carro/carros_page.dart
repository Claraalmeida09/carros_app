import 'dart:async';

import 'package:carros_app/pages/carro/carro.dart';
import 'package:carros_app/pages/carro/carro_page.dart';
import 'package:carros_app/pages/carro/carros_api.dart';
import 'package:carros_app/pages/carro/carros_bloc.dart';
import 'package:carros_app/pages/carro/carros_listview.dart';
import 'package:carros_app/utils/push.dart';
import 'file:///C:/Users/cllar/AndroidStudioProjects/carros_app/lib/widgets/text_error.dart';
import 'package:flutter/material.dart';

class CarrosPage extends StatefulWidget {
  String tipo;
  CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage> with AutomaticKeepAliveClientMixin<CarrosPage>{

  List<Carro> carros;

  final _bloc = CarrosBloc();
  String get tipo => widget.tipo;


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _bloc.loadData(tipo);
    }
    

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return StreamBuilder(
      stream: _bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return TextError("Não foi possível buscar os carros");
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Carro> carros = snapshot.data;

        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: CarrosListView(carros),);
      },
    );
  }

  Future<void> _onRefresh() {
    return _bloc.loadData(tipo);
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.dispose();
  }


}
