import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_projeto_02/model/Tarefa.dart';
import 'package:mini_projeto_02/widgets/TodoForm/TodoForm.dart';

class TaskDetail extends StatefulWidget {
  final Function(int) _excluirTask;
  final Function(Tarefa, Tarefa) _editTarefa;
  final Tarefa _tarefa;

  TaskDetail(
      {Key? key,
      required Tarefa tarefa,
      required Function(int) excluirTask,
      required Function(Tarefa, Tarefa) editTarefa})
      : _tarefa = tarefa,
        _excluirTask = excluirTask,
        _editTarefa = editTarefa,
        super(key: key);

  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  void handleEditTarefa(Tarefa tarefaAntiga, Tarefa tarefaNova) {
    widget._tarefa.descricao = tarefaNova.descricao;
    widget._tarefa.comentario = tarefaNova.comentario;
    widget._tarefa.prioridade = tarefaNova.prioridade;
    widget._tarefa.dataTarefa = tarefaNova.dataTarefa;

    setState(() {
      widget._editTarefa(tarefaAntiga, tarefaNova);
    });
  }

  @override
  Widget build(BuildContext context) {
    void handleExcluirTask() {
      widget._excluirTask(widget._tarefa.id);
    }

    void _openTaskForm() {
      showModalBottomSheet(
        context: context,
        builder: (context) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: TodoForm(
            editTarefa: handleEditTarefa,
            tarefa: widget._tarefa,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeData().primaryColor,
        title: const Text(
          "Detalhes da tarefa",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.white,
            ThemeData().primaryColor,
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Actions(
                handleExcluirTask: handleExcluirTask,
                handleopenTaskForm: _openTaskForm),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 430,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(36),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("ID: ${widget._tarefa.id}"),
                    Text("Descrição: ${widget._tarefa.descricao}"),
                    Text("Prioridade: ${widget._tarefa.prioridade}"),
                    Text("Comentário: ${widget._tarefa.comentario}"),
                    Text(
                        "Data para conclusão: ${DateFormat('dd/MM/y').format(widget._tarefa.dataTarefa)}"),
                    Text(
                        "Criada em: ${DateFormat('dd/MM/y').format(widget._tarefa.dataCriacao)}"),
                    const SizedBox(
                      height: 16,
                    ),
                    DateTime.now().isBefore(widget._tarefa.dataTarefa)
                        ? const Text(
                            "Status: Tarefa no prazo",
                            style: const TextStyle(color: Colors.green),
                          )
                        : const Text(
                            "Status: Tarefa fora do prazo",
                            style: TextStyle(color: Colors.red),
                          ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Actions extends StatelessWidget {
  final void Function() _handleExcluirTask;
  final void Function() _handleopenTaskForm;
  const Actions({
    required Function() handleExcluirTask,
    required Function() handleopenTaskForm,
    super.key,
  })  : _handleExcluirTask = handleExcluirTask,
        _handleopenTaskForm = handleopenTaskForm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: () {
              _handleExcluirTask();
            },
            icon: const Icon(
              Icons.restore_from_trash,
              size: 18,
              color: Colors.white,
            ),
            label: Text(
              "Excluir tarefa",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeData().primaryColor.withOpacity(0.8),
              minimumSize: const Size(30, 30),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              _handleopenTaskForm();
            },
            icon: const Icon(
              Icons.edit,
              size: 18,
              color: Colors.black45,
            ),
            label: Text("Editar tarefa"),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(30, 30),
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
          ),
        ],
      ),
    );
  }
}
