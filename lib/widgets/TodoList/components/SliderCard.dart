import 'package:flutter/material.dart';
import 'package:mini_projeto_02/model/Tarefa.dart';
import 'package:mini_projeto_02/widgets/TodoList/components/TaskCard.dart';

class SliderCard extends StatelessWidget {
  final Function(Tarefa) _openTaskDetail;
  final Function(int) _excluirTask;

  final Tarefa tarefa;

  const SliderCard({
    required this.tarefa,
    required Function(Tarefa) openTaskDetail,
    required Function(int) excluirTask,
    super.key,
  })  : _openTaskDetail = openTaskDetail,
        _excluirTask = excluirTask;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 150, // Definindo uma altura fixa para os cards
      child: GestureDetector(
        onTap: () => _openTaskDetail(tarefa),
        child: TaskCard(tarefa: tarefa, excluirTask: _excluirTask),
      ),
    );
  }
}
