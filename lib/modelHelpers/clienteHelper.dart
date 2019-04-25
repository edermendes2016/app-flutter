import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import './servicoHelper.dart';

final String clienteTable = "clienteTable";
final String idCol = 'idCol';
final String nomeCol = 'nomeCol';
final String telCol = 'telCol';
final String imgCol = 'imgCol';

class ClienteHelper {
  static final ClienteHelper _instance = ClienteHelper.internal();
  factory ClienteHelper() => _instance;
  ClienteHelper.internal();

  //banco de dados
  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "appsdb.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $clienteTable($idCol INTEGER PRIMARY KEY, $nomeCol TEXT, $telCol TEXT, $imgCol TEXT)");
    });
  }

  //metodos
  Future<Cliente> salvaCliente(Cliente cliente) async {
    Database dataBase = await db;
    cliente.id = await dataBase.insert(clienteTable, cliente.toMap());
    return cliente;
  }

  Future<List> obterTodos() async {
    Database dataBase = await db;
    List listMap = await dataBase.rawQuery("SELECT * FROM $clienteTable");
    List<Cliente> listCliente = List();
    for (Map c in listMap) {
      listCliente.add(Cliente.fromMap(c));
    }
    return listCliente;
  }

  Future<Cliente> obterClienteUnico(int id) async {
    Database dataBase = await db;
    List<Map> maps = await dataBase.query(clienteTable,
        columns: [idCol, nomeCol, telCol, imgCol],
        where: "$idCol = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Cliente.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteCliente(int id) async {
    Database dataBase = await db;
    return await dataBase
        .delete(clienteTable, where: "$idCol = ?", whereArgs: [id]);
  }

  Future<int> atualizaCliente(Cliente cliente) async {
    Database dataBase = await db;
    return await dataBase.update(clienteTable, cliente.toMap(),
        where: "$idCol = ?", whereArgs: [cliente.id]);
  }

  //Trazer numero de contatos
  Future<int> numeroClientes() async {
    Database dataBase = await db;
    return Sqflite.firstIntValue(
        await dataBase.rawQuery("SELECT COUNT(*) FROM $clienteTable"));
  }

  Future close() async {
    Database dataBase = await db;
    dataBase.close();
  }
}

// classe do cliente
class Cliente {
  int id;
  String nome;
  String tel;
  String img;

  Cliente();

  Cliente.fromMap(Map map) {
    id = map[idCol];
    nome = map[nomeCol];
    tel = map[telCol];
    img = map[imgCol];
  }

  Map toMap() {
    Map<String, dynamic> map = {nomeCol: nome, telCol: tel, imgCol: img};
    if (id != null) {
      map[idCol] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Cliente(id: $id, nome: $nome, tel: $tel, img: $img)";
  }
}
