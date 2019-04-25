final String servicoTable = "servicoTable";
final String idServicoCol = 'idServicoCol';
final String descricaoCol = 'descricaoCol';
final String dataCol = 'dataCol';
final String precoCol = 'precoCol';

class ServicoHelper {}

class Servico {
  int idServico;
  String descricao;
  String data;
  String preco;

  Servico();
  Servico.fromMap(Map map) {
    idServico = map[idServicoCol];
    descricao = map[descricaoCol];
    data = map[dataCol];
    preco = map[precoCol];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      descricao: descricaoCol,
      dataCol: data,
      precoCol: preco
    };
    if (idServico != null) {
      map[idServicoCol] = idServico;
    }
    return map;
  }
}
