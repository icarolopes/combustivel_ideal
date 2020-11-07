import 'package:combustivel_ideal/helper/ListaCalculosHelper.dart';
import 'package:combustivel_ideal/model/ListaCalculos.dart';
import 'package:combustivel_ideal/page/Lista.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerAlcool = TextEditingController();
  TextEditingController _controllerGasolina = TextEditingController();
  TextEditingController _controllerPosto = TextEditingController();
  String _textoResultado = "";
  String _textoValidacao = "";
  String _nomePosto = "";

  ListaCalculosHelper helper = ListaCalculosHelper();

  void _calcular() {
    double precoAlcool = double.tryParse( _controllerAlcool.text );
    double precoGasolina = double.tryParse( _controllerGasolina.text );

    if( precoAlcool == null || precoGasolina == null ){
      setState(() {
        _textoValidacao = "Número inválido, digite números maiores que 0 e utilizando (.) ";
      });
    }else{

      /*
      * Se o preço do álcool divido pelo preço da gasolina
      * for >= a 0.7 é melhor abastecer com gasolina
      * senão é melhor utilizar álcool
      * */
      if( (precoAlcool / precoGasolina) >= 0.7 ){
        setState(() {
          _textoResultado = "Melhor abastecer com gasolina";
        });
      }else{
        setState(() {
          _textoResultado = "Melhor abastecer com alcool";
        });
      }

      setState(() {
        _nomePosto = _controllerPosto.text;
      });

      _saveCalculo();
      _limparCampos();
      _requestPop();
    }
  }

  void _limparCampos(){
    _controllerGasolina.text = "";
    _controllerAlcool.text = "";
    _controllerPosto.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: buildAppBar(),
      body: buildBody()
    );
  }

  Widget buildAppBar () {
    return AppBar(
      title: Text('Combustivel Ideal'),
      backgroundColor: Colors.blue,
      centerTitle: true,
      actions: <Widget>[
        IconButton (
          icon: Icon(Icons.history),
          color: Colors.white,
          onPressed: _showList,
        )
      ],
    );
  }

  Widget buildBody() {
    return SingleChildScrollView (
      padding: EdgeInsets.all(15),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget> [
          buildLogo(),
          buildTexto(),
          buildCamposNomePosto('Nome do posto', _controllerPosto),
          buildCamposPreco('Preço do alcool', _controllerAlcool),
          buildCamposPreco('Preço do gasolina', _controllerGasolina),
          btnCalcular(),
          buildResultado()
        ],
      )
    );
  }

  Widget buildLogo() {
    return Padding (
      padding: EdgeInsets.only(bottom: 32),
      child: Image.asset('images/logo.png')
    );
  }

  Widget buildTexto() {
    return Padding (
      padding: EdgeInsets.only(bottom: 32),
      child: Text (
        'Saiba qual a melhor opção para abastecimento do seu carro',
        textAlign: TextAlign.center,
        style: TextStyle (
          fontSize: 32.0
        )
      )
    );
  }

  Widget btnCalcular() {
    return Padding (
      padding: EdgeInsets.only(top: 20),
      child: RaisedButton (
        color: Colors.blue,
        textColor: Colors.white,
        padding: EdgeInsets.all(15),
        child: Text (
          'Calcular',
          style: TextStyle (
            fontSize: 20
          )
        ),
        onPressed: _calcular
      )
    );
  }

  Widget buildCamposNomePosto(String label, TextEditingController controller) {
    return TextField (
      keyboardType: TextInputType.text,
      decoration: InputDecoration (
        labelText: label
      ),
      style: TextStyle (
        fontSize: 22
      ),
      controller: controller
    );
  }

  Widget buildCamposPreco(String label, TextEditingController controller) {
    return TextField (
      keyboardType: TextInputType.number,
      decoration: InputDecoration (
        labelText: label
      ),
      style: TextStyle (
        fontSize: 22
      ),
      controller: controller
    );
  }

  Widget buildResultado() {
    return Padding (
      padding: EdgeInsets.only(top: 20),
      child: Text (
        _textoValidacao,
        style: TextStyle (
          fontSize: 22,
          fontWeight: FontWeight.bold
        )
      )
    );
  }

  Future<bool> _requestPop () {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog (
          title: Text(_nomePosto),
          content: Text(_textoResultado),
          actions: <Widget> [
            FlatButton (
              child: Text('OK!'),
              onPressed: () {
                Navigator.pop(context);
              }
            )
          ]
        );
      }
    );
    return Future.value(false);
  }

  void _showList()  {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => Lista()
      )
    );
  }

  String _data () {
    var now = new DateTime.now();
    return DateFormat('dd-MM-yyyy - kk:mm').format(now);
    // var horas = DateFormat('kk:mm').format(now);
    // return data;  
  }

  void _saveCalculo() {
    ListaCalculos listaCalculos = ListaCalculos();
    listaCalculos.nomePosto = _controllerPosto.text;
    listaCalculos.precoAlcool = double.parse(_controllerAlcool.text);
    listaCalculos.precoGasolina = double.parse(_controllerGasolina.text);
    listaCalculos.data = _data();
    helper.insert(listaCalculos);
  }
}
