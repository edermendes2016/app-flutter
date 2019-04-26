
import 'package:app_servicos/modelHelpers/clienteHelper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ClienteHelper helper = ClienteHelper();

  @override
  void initState(){
    super.initState();

    // Servico c = Servico();
    // c.descricao = "Teste Descricao";
    // c.data = "11/08/2019";
    // c.preco = "299";
    // c.clienteId = 1;
    // helper.salvaServico(c);

  //  helper.obterTodos().then((list){
  //    print(list);
  //  });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
