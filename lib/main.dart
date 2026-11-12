import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('A próxima sessão é por sua conta.'),
        ),
      ),
    );
  }
}

// criando o filme
class Filme{
  String titulo;
  bool assistido;

  Filme({required this.titulo, this.assistido = false});
  }