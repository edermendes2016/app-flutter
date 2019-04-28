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

    helper.obterTodos().then((list){
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
        backgroundColor: Colors.purpleAccent,
        centerTitle: true
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
        backgroundColor: Colors.purpleAccent[500],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: servicos.length,
        itemBuilder: (context, index){},
      ),
    );
  }
}
