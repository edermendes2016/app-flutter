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
final String prolaboreCol = 'prolaboreCol';
final String motoCol = 'motoCol';
final String equipCol = 'equipCol';
final String decimoCol = 'decimoCol';

class ClienteHelper {
  static final ClienteHelper _instance = ClienteHelper.internal();
  factory ClienteHelper() => _instance;
  ClienteHelper.internal();

  // Cria o Banco de Dados
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
          "CREATE TABLE $clienteServicoTable($idCol INTEGER PRIMARY KEY, $nomeClienteCol TEXT, $descricaoCol TEXT, $imgCol TEXT, $horaCol TEXT, $precoCol TEXT, $dataCol TEXT,$motoCol DOUBLE, $equipCol DOUBLE, $decimoCol DOUBLE, $prolaboreCol DOUBLE)");
    
    });
  }

  // Cálculos despesas
  calculoDespesaMoto(Cliente cliente) {
    
  }

  calculoDespesaDecimo(Cliente cliente) {
    
  }

  calculoDespesaEquip(Cliente cliente) {
    
  }

  calculoDespesaProlabore(Cliente cliente) {
    
  }

  calculoLucro(Cliente cliente) {
    
  }

  transformaStringDouble(String valor){
    double.parse(valor);
  }

// Métodos CRUD
  Future<Cliente> salvaServicoCliente(Cliente cliente) async {
    Database dataBase = await db;
     
    // cliente.valorDecimo = transformaStringDouble(cliente.valorDecimo) - 1;

    cliente.id = await dataBase.insert(clienteServicoTable, cliente.toMap());

    return cliente;
  }

  Future<List> obterTodos() async {
    Database dataBase = await db;
    List listMap =
        await dataBase.rawQuery("SELECT * FROM $clienteServicoTable");
    List<Cliente> listCliente = List();
    for (Map c in listMap) {
      listCliente.add(Cliente.fromMap(c));
    }

    return listCliente;
  }  

  Future<Cliente> obterClienteUnico(int id) async {
    Database dataBase = await db;
    List<Map> maps = await dataBase.query(clienteServicoTable,
        columns: [
          idCol,
          nomeClienteCol,
          descricaoCol,
          imgCol,
          horaCol,
          dataCol,
          precoCol
        ],
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

// Classe do Cliente
class Cliente {
  int id;
  String nome;
  String descricao;
  String img;
  String preco;
  String data;
  String hora;
  String valorProlabore;
  String valorMoto;
  String varlorEquip;
  String valorDecimo;

  Cliente();
  
  Cliente.fromMap(Map map) {
    id = map[idCol];
    nome = map[nomeClienteCol];
    descricao = map[descricaoCol];
    img = map[imgCol];
    preco = map[precoCol];
    data = map[dataCol];
    hora = map[horaCol];
    valorDecimo = map[decimoCol];
    valorMoto= map[motoCol];
    valorProlabore = map[prolaboreCol];
    varlorEquip = map[equipCol];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nomeClienteCol: nome,
      descricaoCol: descricao,
      imgCol: img,
      precoCol: preco,
      dataCol: data,
      horaCol: hora,
      prolaboreCol: valorProlabore,
      motoCol: valorMoto,
      decimoCol: valorDecimo,
      equipCol: varlorEquip  
    };
    if (id != null) {
      map[idCol] = id;
    }
    return map;
  }

  @override
  String toString() {    
    return "Serviço(id: $id, nome: $nome, descricao: $descricao, img: $img, preco: $preco, data: $data, hora: $hora, moto: $valorMoto)";
  }
}
