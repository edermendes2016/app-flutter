import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String clienteServicoTable = "clienteServicoTable";
final String idCol = 'idCol';
final String nomeClienteCol = 'nomeClienteCol';
final String descricaoCol = 'descricaoCol';
final String imgCol = 'imgCol';
final String precoCol = 'precoCol';
final String horaCol = 'horaCol';
final String dataCol = 'dataCol';

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
          "CREATE TABLE $clienteServicoTable($idCol INTEGER PRIMARY KEY, $nomeClienteCol TEXT, $descricaoCol TEXT, $imgCol TEXT, $horaCol TEXT, $precoCol DECIMAL(10,2), $dataCol TEXT)");
    });
  }

  
  //metodos
  Future<Cliente> salvaCliente(Cliente cliente) async {
    Database dataBase = await db;
    cliente.id = await dataBase.insert(clienteServicoTable, cliente.toMap());
    return cliente;
  }

  Future<List> obterTodos() async {
    Database dataBase = await db;
    List listMap = await dataBase.rawQuery("SELECT * FROM $clienteServicoTable");
    List<Cliente> listCliente = List();
    for (Map c in listMap) {
      listCliente.add(Cliente.fromMap(c));
    }
    return listCliente;
  }

  Future<Cliente> obterClienteUnico(int id) async {
    Database dataBase = await db;
    List<Map> maps = await dataBase.query(clienteServicoTable,
        columns: [idCol, nomeClienteCol, descricaoCol, imgCol, horaCol, dataCol, precoCol],
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
        .delete(clienteServicoTable, where: "$idCol = ?", whereArgs: [id]);
  }

  Future<int> atualizaCliente(Cliente cliente) async {
    Database dataBase = await db;
    return await dataBase.update(clienteServicoTable, cliente.toMap(),
        where: "$idCol = ?", whereArgs: [cliente.id]);
  }

  // Calculos despesas

  calculoDespesaMoto(Cliente cliente) {
    double porcetagem = 100/5;
    double preco = double.parse(cliente.preco);
    return preco * porcetagem;
  }
  calculoDespesaDecimo(Cliente cliente) {
    double porcetagem = 100/10;
    double preco = double.parse(cliente.preco);
    return preco * porcetagem;
  }
  calculoDespesaEquip(Cliente cliente) {
    double porcetagem = 100/5;
    double preco = double.parse(cliente.preco);
    return preco * porcetagem;
  }
  calculoDespesaProlabore(Cliente cliente) {
    double porcetagem = 100/70;
    double preco = double.parse(cliente.preco);
    return (preco - calculoDespesaMoto(cliente) - calculoDespesaEquip(cliente) - calculoDespesaDecimo(cliente)) * porcetagem;
  }


  //Trazer numero de contatos
  Future<int> numeroClientes() async {
    Database dataBase = await db;
    return Sqflite.firstIntValue(
        await dataBase.rawQuery("SELECT COUNT(*) FROM $clienteServicoTable"));
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
  String descricao;
  String img;
  String preco;
  String data;
  String hora;

  Cliente();

  Cliente.fromMap(Map map) {
    id = map[idCol];
    nome = map[nomeClienteCol];
    descricao = map[descricaoCol];
    img = map[imgCol];
    preco = map[precoCol];
    data = map[dataCol];
    hora = map[horaCol];
  }

  Map toMap() {
    Map<String, dynamic> map = {nomeClienteCol: nome, descricaoCol: descricao, imgCol: img, preco: precoCol, data: dataCol, hora: horaCol };
    if (id != null) {
      map[idCol] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Cliente(id: $id, nome: $nome, descricao: $descricao, img: $img, preco: $preco, data: $data, hora: $hora)";
  }
}
