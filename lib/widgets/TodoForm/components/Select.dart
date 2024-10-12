import 'package:flutter/material.dart';

class Select extends StatelessWidget {
  const Select({
    super.key,
    required this.controller,
    required this.placeholder,
    required this.options,
    this.initialValue,
  });

  final TextEditingController controller;
  final String placeholder;
  final List<String> options;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {


    return DropdownButtonFormField<String>(
      items: options.map((option) {
  
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      value: initialValue,
      onChanged: (String? value) {
        controller.text = value!;
      },
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
    );
  }
}
