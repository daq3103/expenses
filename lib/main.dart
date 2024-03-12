import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/expenses.dart';

void main() {
  runApp(MaterialApp(
    
    theme: 
    ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromRGBO(255, 96, 60, 181),
      ),
      appBarTheme:
          const AppBarTheme(backgroundColor: Color.fromRGBO(255, 96, 60, 181)),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    home: const Scaffold(body: Expenses()),
  ));
}
