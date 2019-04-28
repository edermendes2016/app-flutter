import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String contactTable = "contactTable";
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String emailColumn = "emailColumn";
final String phoneColumn = "phoneColumn";
final String imgColumn = "imgColumn";
final String descricaoCol = 'descricaoCol';
final String precoCol = 'precoCol';
final String horaCol = 'horaCol';
final String dataCol = 'dataCol';
final String prolaboreCol = 'prolaboreCol';
final String motoCol = 'motoCol';
final String equipCol = 'equipCol';
final String decimoCol = 'decimoCol';

class ContactHelper {
  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

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
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "contactsnew.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT,"
          "$phoneColumn TEXT, $imgColumn TEXT,$descricaoCol TEXT, $horaCol TEXT, $precoCol TEXT, $dataCol TEXT,$motoCol TEXT, $equipCol TEXT, $decimoCol TEXT, $prolaboreCol TEXT)");
    });
  }

  // Cálculos despesas
  // calculoDespesaMoto(Contact cliente) {
  //   cliente.valorMoto = transformaStringDouble(cliente.preco) * 0.05;
  // }

  // calculoDespesaDecimo(Contact cliente) {
  //   cliente.valorDecimo = transformaStringDouble(cliente.preco) * 0.1;
  // }

  // calculoDespesaEquip(Contact cliente) {
  //   cliente.varlorEquip = transformaStringDouble(cliente.preco) * 0.05;
  // }

  // calculoDespesaProlabore(Contact cliente) {
  //   cliente.valorProlabore = transformaStringDouble(cliente.preco) * 0.7;
  // }

  calculoLucro(Contact cliente) {}

  transformaStringDouble(double valor) {
   return valor.toString();
  }

  Future<Contact> saveContact(Contact contact) async {
    Database dbContact = await db;

    double decimo = double.parse(contact.preco) * 0.1;
    transformaStringDouble(decimo);

    double equip = double.parse(contact.preco) * 0.05;
    transformaStringDouble(equip);

    double moto = double.parse(contact.preco) * 0.05;
    transformaStringDouble(moto);
    
    double prolabore = ((double.parse(contact.preco) - moto - decimo - equip) * 0.7).roundToDouble();
    transformaStringDouble(prolabore);
    
    contact.valorMoto = moto.toString();
    contact.varlorEquip = equip.toString();
    contact.valorDecimo = decimo.toString();
    contact.valorProlabore = prolabore.toString();
    
    contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Contact> getContact(int id) async {
    Database dbContact = await db;
    List<Map> maps = await dbContact.query(contactTable,
        columns: [
          idColumn,
          nameColumn,
          emailColumn,
          phoneColumn,
          imgColumn,
          precoCol,
          prolaboreCol,
          decimoCol,
          descricaoCol,
          motoCol,
          equipCol,
          dataCol,
          dataCol
        ],
        where: "$idColumn = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    return await dbContact
        .delete(contactTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    Database dbContact = await db;
    
    double decimo = double.parse(contact.preco) * 0.1;
    transformaStringDouble(decimo);

    double equip = double.parse(contact.preco) * 0.05;
    transformaStringDouble(equip);

    double moto = double.parse(contact.preco) * 0.05;
    transformaStringDouble(moto);
    
    double prolabore = ((double.parse(contact.preco) - moto - decimo - equip) * 0.7).roundToDouble();
    transformaStringDouble(prolabore);
    
    contact.valorMoto = moto.toString();
    contact.varlorEquip = equip.toString();
    contact.valorDecimo = decimo.toString();
    contact.valorProlabore = prolabore.toString();
    
    return await dbContact.update(contactTable, contact.toMap(),
        where: "$idColumn = ?", whereArgs: [contact.id]);
  }

  Future<List> getAllContacts() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
    List<Contact> listContact = List();
    for (Map m in listMap) {
      listContact.add(Contact.fromMap(m));
    }
    return listContact;
  }

  Future<int> getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(
        await dbContact.rawQuery("SELECT COUNT(*) FROM $contactTable"));
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }
}

class Contact {
  int id;
  String name;
  String email;
  String phone;
  String img;
  String preco;
  String data;
  String hora;
  String valorProlabore;
  String valorMoto;
  String varlorEquip;
  String valorDecimo;
  String descricao;

  Contact();

  Contact.fromMap(Map map) {
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
    descricao = map[descricaoCol];
    preco = map[precoCol];
    data = map[dataCol];
    hora = map[horaCol];
    valorDecimo = map[decimoCol];
    valorMoto = map[motoCol];
    valorProlabore = map[prolaboreCol];
    varlorEquip = map[equipCol];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img,
      descricaoCol: descricao,
      precoCol: preco,
      dataCol: data,
      horaCol: hora,
      prolaboreCol: valorProlabore,
      motoCol: valorMoto,
      decimoCol: valorDecimo,
      equipCol: varlorEquip
    };
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, img: $img)";
  }
}
