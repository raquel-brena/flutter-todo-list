import 'package:flutter/material.dart';
import 'package:mini_projeto_02/widgets/TodoList/TodoList.dart';

class Legenda extends StatelessWidget {
  const Legenda({
    super.key,
    required this.filter,
  });

  final String filter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 14,
        ),
        Row(
          children: [
            const Icon(
              Icons.filter_alt_rounded,
              size: 18,
              color: Colors.black38,
            ),
            Text(
              "Filtrada por: ",
              style: TextStyle(fontSize: 12, color: Colors.black38),
            ),
            Text(
              filter == "" ? "Data de criação" : filter,
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.priority_high,
              size: 18,
              color: Colors.black38,
            ),
            const Text(
              "Prioridade: ",
              style: TextStyle(fontSize: 12, color: Colors.black38),
            ),
            const StatusPrioridadeInfo(
                cor: Colors.green, tamanho: 10, texto: "Baixa"),
            StatusPrioridadeInfo(
                cor: Colors.yellow[800]!, tamanho: 10, texto: "Média"),
            const StatusPrioridadeInfo(
                cor: Colors.red, tamanho: 10, texto: "Alta"),
          ],
        ),
        const SizedBox(
          height: 14,
        ),
      ],
    );
  }
}
