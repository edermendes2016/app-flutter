import 'dart:io';

import 'package:app_servicos/modelHelpers/clienteHelper.dart';
import 'package:flutter/material.dart';

class ServicoPage extends StatefulWidget {
  final Cliente servico;
  //{} parametro opcional
  ServicoPage({this.servico});

  @override
  _ServicoPageState createState() => _ServicoPageState();
}

class _ServicoPageState extends State<ServicoPage> {
  Cliente editar;
  bool _textoEditado = false;

  // Controllers
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _dataController = TextEditingController();
  final _horaController = TextEditingController();
  final _precoController = TextEditingController();
  final _prolaboreController = TextEditingController();
  final _motoController = TextEditingController();
  final _equipController = TextEditingController();
  final _decimoController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.servico == null) {
      Cliente();
    } else {
      Cliente.fromMap(widget.servico.toMap());
      _nomeController.text = editar.nome;
      _descricaoController.text = editar.descricao;
      _dataController.text = editar.data;
      _decimoController.text = editar.valorDecimo;
      _motoController.text = editar.valorMoto;
      _equipController.text = editar.varlorEquip;
      _precoController.text = editar.preco;
      _horaController.text = editar.hora;
      _prolaboreController.text = editar.valorProlabore;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editar.nome ?? "Novo Serviço"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {},
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: editar.img != null
                          ? FileImage(File(editar.img))
                          : AssetImage("img/img.jpg")),
                ),
              ),
            ),
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: "Nome"),
              onChanged: (text) {
                _textoEditado = false;
                setState(() {
                  editar.nome = text;
                });
              },
            ),
            TextField(
              controller: _descricaoController,
              decoration: InputDecoration(labelText: "Descrição"),
              onChanged: (text) {
                _textoEditado = false;
                editar.descricao = text;
              },
            ),
            Row(
              children: <Widget>[
                TextField(
                  controller: _dataController,
                  decoration: InputDecoration(labelText: "Data"),
                  onChanged: (text) {
                    _textoEditado = false;
                    editar.data = text;
                  },
                  keyboardType: TextInputType.datetime,
                ),
                TextField(
                  controller: _horaController,
                  decoration: InputDecoration(labelText: "Hora"),
                  onChanged: (text) {
                    _textoEditado = false;
                    editar.hora = text;
                  },
                  keyboardType: TextInputType.number,
                )
              ],
            ),
            TextField(
              controller: _precoController,
              decoration: InputDecoration(labelText: "Preço Serviço"),
              onChanged: (text) {
                _textoEditado = false;
                editar.preco = text;
              },
            ),
            TextField(
              controller: _decimoController,
              decoration: InputDecoration(labelText: "Décimo Terceiro"),
              onChanged: (text) {
                _textoEditado = true;
                editar.valorDecimo = text;
              },
              enabled: false,
            ),
            TextField(
              controller: _motoController,
              decoration: InputDecoration(labelText: "Moto"),
              onChanged: (text) {
                _textoEditado = true;
                editar.valorMoto = text;
              },
              enabled: false,
            ),
            TextField(
              controller: _equipController,
              decoration: InputDecoration(labelText: "Equipamentos"),
              onChanged: (text) {
                _textoEditado = true;
                editar.varlorEquip = text;
              },
              enabled: false,
            ),
            TextField(
              controller: _prolaboreController,
              decoration: InputDecoration(labelText: "Prolabore"),
              onChanged: (text) {
                _textoEditado = true;
                editar.valorProlabore = text;
              },
              enabled: false,
            )
          ],
        ),
      ),
    );
  }
}
