import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final void Function() onPressed;

  const CustomDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.onPressed});

  final String title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        TextButton(
          child: Text("Cancelar"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("Confirmar"),
          onPressed: () {
            onPressed();
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}
