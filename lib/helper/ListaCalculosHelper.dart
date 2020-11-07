import 'package:combustivel_ideal/model/ListaCalculos.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ListaCalculosHelper {
  static final ListaCalculosHelper _instance = ListaCalculosHelper.internal();

  ListaCalculosHelper.internal();

  factory ListaCalculosHelper() => _instance;

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    final path = await getDatabasesPath();
    final pathDB = join(path, 'lista_calculos.db');

    final String sql = 'CREATE TABLE lista_calculos (c_id INTEGER PRIMARY KEY, c_nome_posto TEXT, c_preco_alcool REAL, c_preco_gasolina REAL, c_data TEXT)';

    return await openDatabase (
      pathDB,
      version: 3,
      onCreate: (Database db, int newerVersion) async {
        await db.execute(sql);
      }
    );
  }

  Future<ListaCalculos> insert(ListaCalculos listaCalculos) async {
    Database dbListaCalculos = await db;
    listaCalculos.id = await dbListaCalculos.insert('lista_calculos', listaCalculos.toMap());
    return listaCalculos;
  }

  Future<ListaCalculos> selectById(int id) async {
    Database dbListaCalculos = await db;
    List<Map> maps = await dbListaCalculos.query(
      'lista_calculos',
      columns: [
        'c_id',
        'c_nome',
        'c_email',
        'c_telefone',
        'c_instituicao',
        'c_path_img'
      ],
      where: 'c_id = ?',
      whereArgs: [id]
    );

    if (maps.length > 0) {
      return ListaCalculos.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List> selectAll() async {
    Database dbListaCalculos = await db;
    List list = await dbListaCalculos.rawQuery('SELECT * FROM lista_calculos');
    List<ListaCalculos> lsListaCalculos = List();
    for(Map map in list) {
      lsListaCalculos.add(ListaCalculos.fromMap(map));
    }
    return lsListaCalculos;
  }
  

  Future<int> update (ListaCalculos listaCalculos) async {
    Database dbListaCalculos = await db;
    return await dbListaCalculos.update(
      'lista_calculos',
      listaCalculos.toMap(),
      where: 'c_id = ?',
      whereArgs: [listaCalculos.id]
    );
  }

  Future<int> delete(int id) async {
    Database dbListaCalculos = await db;
    return await dbListaCalculos.delete(
      'lista_calculos',
      where: 'c_id = ?',
      whereArgs: [id]
    );
  }

  Future close() async {
    Database dbListaCalculos = await db;
    dbListaCalculos.close();
  }
}