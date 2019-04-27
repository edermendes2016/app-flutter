import 'package:app_servicos/modelHelpers/clienteHelper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ClienteHelper helper = ClienteHelper();

  @override
  void initState() {
    super.initState();

    // Cliente c = Cliente();
    // c.nome = "Teste Prolabore";
    // c.descricao = "Teste Descricao prolabore";
    // c.data = "11/08/2019";
    // c.img = "img/img.jpg";
    // c.hora = "2";
    // c.preco = 70.00;
   

    // helper.salvaServicoCliente(c);

     helper.obterTodos().then((list){
       print(list);
     });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
