import 'package:flutter/material.dart';
import 'package:mini_projeto_02/model/Tarefa.dart';
import 'package:mini_projeto_02/widgets/TodoList/components/TaskCard.dart';
import 'package:go_router/go_router.dart';

class CardList extends StatelessWidget {
  final List<Tarefa> _listaTarefas;
  final Function(Tarefa) _openTaskDetail;
  final Function(int) _excluirTask;

  const CardList({
    super.key,
    required List<Tarefa> listaTarefas,
    required Function(Tarefa) openTaskDetail,
    required Function(int) excluirTask,
  })  : _listaTarefas = listaTarefas,
        _openTaskDetail = openTaskDetail,
        _excluirTask = excluirTask;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: _listaTarefas.length,
          itemBuilder: (context, index) {
            final tarefa = _listaTarefas.elementAt(index);
            return GestureDetector(
              onTap: () => _openTaskDetail(tarefa),
              child: TaskCard(tarefa: tarefa, excluirTask: _excluirTask),
            );
          }),
    );
  }
}
