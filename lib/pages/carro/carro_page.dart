import 'package:carros_app/pages/carro/carro.dart';
import 'package:carros_app/pages/carro/loripsum_api.dart';
import 'package:carros_app/widgets/text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatefulWidget {
  Carro carro;


  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loripsumApiBloc = LoripsumBloc();


  @override
  void initState() {
    super.initState();
    _loripsumApiBloc.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMapa,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _onClickVideo,
          ),
          PopupMenuButton<String>(
            onSelected: (String value) => _onClickPopupMenu(value),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'Editar',
                  child: Text('Editar'),
                ),
                PopupMenuItem(
                  value: 'Deletar',
                  child: Text('Deletar'),
                ),
                PopupMenuItem(
                  value: 'Share',
                  child: Text('Share'),
                ),
              ];
            },
          )
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            Image.network(widget.carro.urlFoto),
            _bloco1(),
            Divider(color: Colors.grey,),
            _bloco2(),

          ],
        ));
  }

  Row _bloco1() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(widget.carro.nome, fontSize: 20, bold: true),
                    text(widget.carro.tipo, fontSize: 16),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 40,
                      ),
                      onPressed: _onClickFavorito),
                  IconButton(
                      icon: Icon(
                        Icons.share,
                        size: 40,
                      ),
                      onPressed: _onClickShare),
                ],
              )
            ],
          );
  }

  void _onClickMapa() {}

  void _onClickVideo() {}

  _onClickPopupMenu(String value) {
    switch (value) {
      case 'Editar':
        print('Editar!!!');
        break;
      case 'Deletar':
        print('Deletar!!!');
        break;
      case 'Share':
        print('Share!!!');
        break;
    }
  }

  void _onClickFavorito() {}

  void _onClickShare() {}

  _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text(widget.carro.descricao, fontSize: 16, bold: true),
        SizedBox(height: 20,),
        StreamBuilder<String>(
          stream: _loripsumApiBloc.stream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else
              return text(snapshot.data, fontSize: 16);
          },

        )

      ],
    );
  }

  @override
  void dispose() {
    super.dispose();

    _loripsumApiBloc.dispose();
  }
}
