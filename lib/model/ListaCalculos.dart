class ListaCalculos {
  int id;
  String nomePosto;
  double precoAlcool;
  double precoGasolina;
  String data;

  ListaCalculos();

  ListaCalculos.fromMap(Map map) {
    id = map['c_id'];
    nomePosto = map['c_nome_posto'];
    precoAlcool = map['c_preco_alcool'];
    precoGasolina = map['c_preco_gasolina'];
    data = map['c_data'];
  }

  Map toMap () {
    Map<String, dynamic> map = {
      'c_nome_posto': nomePosto,
      'c_preco_alcool': precoAlcool,
      'c_preco_gasolina': precoGasolina,
      'c_data': data
    };

    if (id != null) map['c_id'] = id;

    return map;
  }

  @override
  String toString() {
    return 'ListaCalculos[ id: $id, nomePosto: $nomePosto, precoAlcool: $precoAlcool, precoGasolin: $precoGasolina, data: $data ]';
  }
}