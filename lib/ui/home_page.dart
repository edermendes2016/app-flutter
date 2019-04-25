import 'package:app_servicos/modelHelpers/clienteHelper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ClienteHelper helper = ClienteHelper();

  // @override
  // void initState(){
  //   super.initState();

  //   Cliente c = Cliente();
  //   c.nome = "Teste";
  //   c.tel = "67 9999-9292";
  //   c.img = "./imgs/imgTeste";
  //   helper.salvaCliente(c);

  //  helper.obterTodos().then((list){
  //    print(list);
  //  });
  // }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
