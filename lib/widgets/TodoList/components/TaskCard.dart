import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_projeto_02/model/Tarefa.dart';
import 'package:mini_projeto_02/widgets/TodoList/components/StatusPrioridade.dart';

class TaskCard extends StatefulWidget {
  final Function(int) _excluirTask;

  const TaskCard({
    super.key,
    required this.tarefa,
    required Function(int) excluirTask,
  }) : _excluirTask = excluirTask;

  final Tarefa tarefa;

  Color _getPrioridadeColor() {
    switch (tarefa.prioridade) {
      case "Baixa":
        return Colors.green;
      case "Média":
        return Colors.yellow[800]!;
      case "Alta":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  void _handleExcluirTask() {
    widget._excluirTask(widget.tarefa.id);
  }

  @override
  Widget build(BuildContext context) {
    final isToday = (DateTime.now().day == (widget.tarefa.dataTarefa.day));
    return Card(
      color: isToday
          ? Colors.black
          : DateTime.now().isBefore(widget.tarefa.dataTarefa)
              ? Colors.white
              : Colors.red[100],
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                widget.tarefa.descricao,
                style: TextStyle(color: isToday ? Colors.white : Colors.black),
                textAlign: TextAlign.center,
              ),
              StatusPrioridade(cor: widget._getPrioridadeColor(), tamanho: 16),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InfoDataTarefa(isToday: isToday, widget: widget),
                ElevatedButton.icon(
                  onPressed: () {
                    _handleExcluirTask();
                  },
                  label: const Icon(
                    Icons.restore_from_trash,
                    size: 18,
                    color: Colors.black45,
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(30, 30),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoDataTarefa extends StatelessWidget {
  const InfoDataTarefa({
    super.key,
    required this.isToday,
    required this.widget,
  });

  final bool isToday;
  final TaskCard widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.calendar_today,
            size: 16, color: isToday ? Colors.white : Colors.black),
        const SizedBox(
          width: 4,
        ),
        isToday
            ? const Text(
                "Hoje",
                style: const TextStyle(color: Colors.white, fontSize: 14),
              )
            : Text(
                DateFormat('dd/MM/y').format(widget.tarefa.dataTarefa),
                style: TextStyle(
                    color: isToday ? Colors.white : Colors.black, fontSize: 14),
              ),
      ],
    );
  }
}
