import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_projeto_02/model/Tarefa.dart';
import 'package:mini_projeto_02/widgets/TodoForm/components/Input.dart';
import 'package:mini_projeto_02/widgets/TodoForm/components/Select.dart';

class TodoForm extends StatefulWidget {
  final void Function(String, DateTime, String, String)? addTarefa;
  final void Function(Tarefa, Tarefa)? editTarefa;
  final Tarefa? tarefa;

  TodoForm({
    super.key,
    this.tarefa,
    this.editTarefa,
    this.addTarefa,
  });

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _prioridadeController = TextEditingController();
  final TextEditingController _comentarioController = TextEditingController();
  late DateTime _dataSelecionada;

  void _submitForm() {
    String descricao = _descricaoController.text;
    String prioridade = _prioridadeController.text;
    String comentario = _comentarioController.text;

    if (descricao.isEmpty) {
      return;
    }

    if (prioridade.isEmpty) {
      prioridade = "Baixa";
    }

    if (widget.tarefa != null) {
      Tarefa novaTarefa = Tarefa(
        id: widget.tarefa!.id,
        descricao: descricao,
        comentario: comentario,
        prioridade: prioridade,
        dataTarefa: _dataSelecionada,
      );
      widget.editTarefa!(widget.tarefa!, novaTarefa);
    } else {
      widget.addTarefa!(descricao, _dataSelecionada, prioridade, comentario);
    }
  }

  @override
  @override
  void initState() {
    super.initState();
    _dataSelecionada = widget.tarefa?.dataTarefa ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    void _showDatePicker() {
      showDatePicker(
        context: context,
        initialDate: _dataSelecionada,
        firstDate: DateTime(2024),
        lastDate: DateTime(2025),
      ).then((pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _dataSelecionada = pickedDate;
        });
      });
    }

    return Container(
      child: Column(
        children: [
          Input(
              controller: _descricaoController,
              placeholder: "Inserir descrição",
              initialValue: widget.tarefa?.descricao),
          Select(
            controller: _prioridadeController,
            placeholder: "Inserir prioridade",
            options: ["Baixa", "Média", "Alta"],
            initialValue: widget.tarefa?.prioridade,
          ),
          Input(
            controller: _comentarioController,
            placeholder: "Inserir comentário",
            initialValue: widget.tarefa?.comentario,
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(children: <Widget>[
                Expanded(
                  child: Text(
                    _dataSelecionada == null
                        ? 'Nenhuma data selecionada'
                        : 'Data selecionada: ${DateFormat('dd/MM/y').format(_dataSelecionada)}',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: _showDatePicker,
                  child: const Text(
                    'Selecionar Data',
                  ),
                )
              ]),
            ),
          ),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text("Enviar", style: TextStyle(fontSize: 16)),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
