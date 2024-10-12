import 'package:flutter/material.dart';

class StatusPrioridade extends StatelessWidget {
  final double tamanho;
  final Color cor;

  const StatusPrioridade({Key? key, required this.tamanho, required this.cor})
      : super(key: key);

  @override
  Widget build(Object context) {
    return Container(
      height: tamanho,
      width: tamanho,
      decoration: BoxDecoration(shape: BoxShape.circle, color: cor),
    );
  }
}
