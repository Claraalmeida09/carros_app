import 'dart:async';

import 'package:carros_app/pages/carro/carro.dart';
import 'package:carros_app/pages/carro/carro_page.dart';
import 'package:carros_app/pages/carro/carros_api.dart';
import 'package:carros_app/pages/carro/carros_model.dart';

import 'package:carros_app/utils/push.dart';
import 'package:carros_app/utils/text_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CarrosListView extends StatefulWidget {
  String tipo;
  CarrosListView(this.tipo);

  @override
  _CarrosListViewState createState() => _CarrosListViewState();
}

class _CarrosListViewState extends State<CarrosListView> with AutomaticKeepAliveClientMixin<CarrosListView>{

  List<Carro> carros;

  final _model = CarrosModel();
  String get tipo => widget.tipo;


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fetch();
    }

void _fetch() {
  _model.loadData(tipo);
}


  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Observer(
      builder: (context) {
        List<Carro> carros = _model.carros;

        if (_model.error != null) {
          return TextError("Não foi possível buscar os carros \n\n Clique aqui para tentar novamente", onPressed: _fetch,);
        }

        if (carros == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }



        return _listView(carros);
      },
    );
  }


  _listView(List<Carro> carros) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros.length,
        itemBuilder: (BuildContext context, int index) {
          Carro c = carros[index];

          return Card(
            color: Colors.grey[100],
            child: Container(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      c.urlFoto ?? "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png",
                      width: 250,
                    ),
                  ),
                  Text(
                    c.nome,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    "descrição...",
                    style: TextStyle(fontSize: 16),
                  ),
                  ButtonBarTheme(
                    data: Theme.of(context).buttonBarTheme,
                    child: ButtonBar(
                      children: [
                        FlatButton(
                          child: const Text('DETALHES'),
                          onPressed: () => _onClickCarro(c),
                        ),
                        FlatButton(
                          child: const Text('SHARE'),
                          onPressed: () {
                            /* ... */
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickCarro(Carro c) {
    push(context, CarroPage(c));
  }
}
