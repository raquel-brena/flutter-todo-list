import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mini_projeto_02/model/Tarefa.dart';
import 'package:mini_projeto_02/widgets/TodoForm/TodoForm.dart';
import 'package:mini_projeto_02/widgets/TodoForm/components/Select.dart';
import 'package:mini_projeto_02/widgets/TodoList/TodoList.dart';
import 'package:mini_projeto_02/widgets/CustomDialog/CustomDialog.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final List<Tarefa> _listaTarefas = [];
  final TextEditingController _filter = TextEditingController();

  void _addTarefa(String descricao, DateTime dataSelecionada, String prioridade,
      String comentario) {
    setState(() {
      _listaTarefas.add(Tarefa(
          id: Random().nextInt(9999),
          descricao: descricao,
          dataTarefa: dataSelecionada,
          prioridade: prioridade,
          comentario: comentario));
    });
    Navigator.of(context).pop();
  }

  void _editTarefa(Tarefa tarefaAntiga, Tarefa tarefaNova) {
    tarefaNova.id = tarefaAntiga.id;
    tarefaNova.dataCriacao = tarefaAntiga.dataCriacao;

    setState(() {
      _listaTarefas.removeWhere((t) => tarefaAntiga.id == t.id);
      _listaTarefas.add(tarefaNova);
    });

    Navigator.of(context).pop();
  }

  void _openTaskForm() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: TodoForm(addTarefa: _addTarefa),
            ));
  }

  void filtrarTarefas() {
    final prioridadeMap = {
      "Baixa": 1,
      "Média": 2,
      "Alta": 3,
    };

    setState(() {
      if (_filter.text == "Prioridade") {
        _listaTarefas.sort((a, b) => prioridadeMap[a.prioridade]!
            .compareTo(prioridadeMap[b.prioridade]!));
      } else if (_filter.text == "Data de execução") {
        _listaTarefas.sort((a, b) => a.dataTarefa.compareTo(b.dataTarefa));
      } else if (_filter.text == "Data de criação") {
        _listaTarefas.sort((a, b) => a.dataCriacao.compareTo(b.dataCriacao));
      }
    });
  }

  void showDialogFiltrarTarefas() {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: "Filtrar tarefas",
          content: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Selecione um filtro"),
                Select(
                    controller: _filter,
                    placeholder: "Selecione um filtro",
                    options: const [
                      "Prioridade",
                      "Data de execução",
                      "Data de criação"
                    ])
              ],
            ),
          ),
          onPressed: filtrarTarefas,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Minhas Tarefas",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ThemeData().primaryColor,
        actions: [
          IconButton(
            onPressed: _openTaskForm,
            icon: const Icon(
              Icons.add_circle,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                const Title(),
                TodoList(
                    listaTarefas: _listaTarefas,
                    editTarefa: _editTarefa,
                    filter: _filter),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialogFiltrarTarefas();
                },
                icon: const Icon(
                  Icons.filter_alt_rounded,
                  size: 18,
                  color: Colors.black45,
                ),
                label: const Text("Filtro"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(30, 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openTaskForm,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: ThemeData().primaryColor,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.transparent),
      ),
      child: const Text("TODO LIST",
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }
}
