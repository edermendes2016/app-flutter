import 'dart:io';

import 'package:app_servicos/modelHelpers/clienteHelper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ClienteHelper helper = ClienteHelper();
  List<Cliente> servicos = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    helper.obterTodos().then((list) {
      setState(() {
        servicos = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Serviços"),
          backgroundColor: Colors.blue,
          centerTitle: true),
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: servicos.length,
        itemBuilder: (context, index) {
          return _servicoCard(context, index);
        },
      ),
    );
  }

  Widget _servicoCard(context, index) {
    return GestureDetector(
      child: Card(
        color: Colors.grey[700],
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: servicos[index].img != null
                          ? FileImage(File(servicos[index].img))
                          : AssetImage("img/img.jpg")),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      servicos[index].nome,
                      style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      servicos[index].data,
                      style: TextStyle(color: Colors.white, fontSize: 17.0),
                    ),
                    Text(
                      servicos[index].preco.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 17.0),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
