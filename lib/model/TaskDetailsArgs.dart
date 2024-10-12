import 'package:mini_projeto_02/model/Tarefa.dart';

class TaskDetailArgs {
  final Tarefa tarefa;
  final Function(int) excluirTask;
  final void Function(Tarefa, Tarefa) editTarefa;

  TaskDetailArgs({
    required this.tarefa,
    required this.excluirTask,
    required this.editTarefa,
  });
}
