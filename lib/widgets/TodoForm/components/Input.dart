import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    required TextEditingController controller,
    required this.placeholder,
    this.initialValue,
  }) : _controller = controller;

  final TextEditingController _controller;
  final String placeholder;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    if (initialValue != null) {
      _controller.text = initialValue!;
    }
    return TextField(
      controller: _controller,
      style: const TextStyle(
        fontSize: 16, 
      ),
      decoration: 
      InputDecoration(
        hintText: placeholder,
        hintStyle: const TextStyle(
          fontSize: 15,
          color: Colors.grey,
        ),
      ),
    );
  }
}
