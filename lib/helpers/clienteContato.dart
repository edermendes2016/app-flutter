import 'package:sqflite/sqflite.dart';

final String idCol = 'idCol';
final String nomeCol = 'nomeCol';
final String telCol = 'telCol';
final String imgCol = 'imgCol';

class ClienteHelper {}

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
    Map<String, dynamic> map = {
      nomeCol: nome,
      telCol: tel,
      imgCol: img
    };
    if(id != null){
      map[idCol] = id;
    }
    return map;
  }  
}
