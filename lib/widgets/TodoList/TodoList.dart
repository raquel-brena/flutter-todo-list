import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_projeto_02/model/Tarefa.dart';
import 'package:mini_projeto_02/model/TaskDetailsArgs.dart';
import 'package:mini_projeto_02/widgets/CustomDialog/CustomDialog.dart';
import 'package:mini_projeto_02/widgets/TodoList/components/Legenda.dart';
import 'package:mini_projeto_02/widgets/TodoList/components/StatusPrioridade.dart';
import 'package:mini_projeto_02/widgets/TodoList/components/SliderCard.dart';
import 'package:mini_projeto_02/widgets/TodoList/components/CardList.dart';

class TodoList extends StatefulWidget {
  final void Function(Tarefa, Tarefa) _editTarefa;
  final TextEditingController _filter;

  const TodoList({
    super.key,
    required List<Tarefa> listaTarefas,
    required TextEditingController filter,
    required void Function(Tarefa, Tarefa) editTarefa,
  })  : _listaTarefas = listaTarefas,
        _editTarefa = editTarefa,
        _filter = filter;

  final List<Tarefa> _listaTarefas;

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Tarefa> _tarefasHoje() {
    return widget._listaTarefas
        .where((tarefa) => tarefa.dataTarefa.day == DateTime.now().day)
        .toList();
  }

  List<Tarefa> _tarefasRestantes() {
    return widget._listaTarefas
        .where((tarefa) => tarefa.dataTarefa.day != DateTime.now().day)
        .toList();
  }

  void _excluirTask(int index) {
    Tarefa tarefa =
        widget._listaTarefas.where((tarefa) => tarefa.id == index).first;
    setState(() {
      widget._listaTarefas.remove(tarefa);
    });
    context.go('/');
  }

  void _openDialogExcluirTask(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: "Excluir tarefa",
          content: const Text("Deseja excluir a tarefa?"),
          onPressed: () => _excluirTask(index),
        );
      },
    );
  }

  _openTaskDetail(Tarefa tarefa) {
    final args = TaskDetailArgs(
        tarefa: tarefa,
        excluirTask: _openDialogExcluirTask,
        editTarefa: widget._editTarefa);

    context.go('/details', extra: args);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tarefasHoje().length > 0
              ? Expanded(
                  flex: 0,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: _tarefasHoje().map((tarefa) {
                        return SliderCard(
                            tarefa: tarefa,
                            openTaskDetail: _openTaskDetail,
                            excluirTask: _openDialogExcluirTask);
                      }).toList(),
                    ),
                  ),
                )
              : Container(),
          widget._listaTarefas.length > 0
              ? Expanded(
                  child: Column(
                    children: [
                      Legenda(filter: widget._filter.text),
                      CardList(
                          listaTarefas: _tarefasRestantes(),
                          openTaskDetail: _openTaskDetail,
                          excluirTask: _openDialogExcluirTask),
                    ],
                  ),
                )
              : const SizedBox(
                  height: 400,
                  child: Center(
                    child: Text("Oops, vazio! Cadastre uma tarefa "),
                  ),
                ),
        ],
      ),
    );
  }
}

class StatusPrioridadeInfo extends StatelessWidget {
  final double tamanho;
  final Color cor;
  final String texto;

  const StatusPrioridadeInfo(
      {Key? key, required this.tamanho, required this.cor, required this.texto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatusPrioridade(tamanho: tamanho, cor: cor),
        const SizedBox(width: 4),
        Text(
          texto,
          style: const TextStyle(fontSize: 12),
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}
