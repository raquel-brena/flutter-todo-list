import 'package:flutter/material.dart';
import 'package:mini_projeto_02/routes/Routes.dart';

void main() {
  runApp(MaterialApp.router(
    routerConfig: routes,
    theme: ThemeData(
      textTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: 24),
        bodyMedium: TextStyle(fontSize: 18)
      )
    ),
  ),);
}

