import 'package:combustivel_ideal/helper/ListaCalculosHelper.dart';
import 'package:combustivel_ideal/model/ListaCalculos.dart';
import 'package:flutter/material.dart';

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {

  ListaCalculosHelper helper = ListaCalculosHelper();
  List<ListaCalculos> list = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ListaCalculos listaCalculos = ListaCalculos();

    // listaCalculos.nomePosto = 'Posto teste 01';
    // listaCalculos.precoAlcool = 3.15;
    // listaCalculos.precoGasolina = 4.85;
    // listaCalculos.data = '10/03/2019';

    // helper.insert(listaCalculos);

    _getLista();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: _buildAppBar(),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: list.length,
        itemBuilder: (ctx, index) {
          return _cardList(ctx, index);
        },
      )
    );
  }


  Widget _cardList(BuildContext ctx, int index) {
    return GestureDetector (
      child: Card (
        child: Padding (
          padding: EdgeInsets.all(15.0),
          child: Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              _textCard('Posto: ${list[index].nomePosto}'),
              _textCard('Preço do álcool: R\$ ${list[index].precoAlcool}'),
              _textCard('Preço da gasolina:R\$ ${list[index].precoGasolina}'),
              _textCard('Consulta realizada em: ${list[index].data}')
            ]
          )
        )
      )
    );
  }

  Widget _textCard(String texto) {
    return Text(
      texto,
      style: TextStyle (
        fontSize: 18.0,
        fontWeight: FontWeight.bold
      )
    );
  }

  Widget _buildAppBar () {
    return AppBar(
      title: Text('Combustivel Ideal'),
      backgroundColor: Colors.blue,
      centerTitle: true
    );
  }

  void _getLista () {
    helper.selectAll().then((lista) {
      setState(() {
        list = lista;
      });
    });
  }
}