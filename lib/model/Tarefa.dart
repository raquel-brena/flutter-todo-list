class Tarefa {
  Tarefa({
    required this.id, 
    required this.descricao, 
    required this.dataTarefa,
    required this.prioridade,
    required this.comentario,
    });

  int id;
  String descricao;
  DateTime dataTarefa;
  String prioridade;
  String comentario;
  bool concluida = false;
  DateTime dataCriacao = DateTime.now();
}
