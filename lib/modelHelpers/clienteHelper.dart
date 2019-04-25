import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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

  Future<Database>initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "appsdb.db");

    return await openDatabase(path,
        version: 1, onCreate: (Database db, int newerVersion) async {
          await db.execute("CREATE TABLE $clienteTable($idCol INTEGER PRIMARY KEY, $nomeCol TEXT, $telCol TEXT, $imgCol TEXT)");
        });
  }
}

class Cliente {
  int id;
  String nome;
  String tel;
  String img;

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
}
