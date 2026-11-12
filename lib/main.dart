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
      home: TelaInicio()
    );
  }
}

// criando o filme
class Filme{
  String titulo;
  bool assistido;

  Filme({required this.titulo, this.assistido = false});
}

//lista de filmes vazia onde o usuario vai adicionar seus filmes
List<Filme> filmes = [];

// tela inicial
class TelaInicio extends StatefulWidget {
  const TelaInicio({super.key});

  @override
  State<TelaInicio> createState() => _TelaInicioState();
}

class _TelaInicioState extends State<TelaInicio> {
  @override
  Widget build(BuildContext context) {
    //contadores de filmes assistidos e não assistidos, faz a filtragem pelo bool
    int totalAssistidos = filmes.where((filme) => filme.assistido).length;
    int totalNaoAssistidos = filmes.where((filme) => !filme.assistido).length;

    return Scaffold(
       body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const Text('A proxima sessão é por sua conta!', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            ListTile(
              title: const Text('Filmes a Assistir'),
              subtitle: Text('$totalNaoAssistidos filmes'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () async {
                // navigator.push abre a nova tela e o await espera a tela ser fechada para atualizar a tela inicial com o setState
                await Navigator.push(
                  context,
                  // route mostra qual tela abrir
                  MaterialPageRoute(builder: (_) => const TelaListaAssistir()),
                );
                // atualiza a tela
                setState(() {});
              },
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Filmes Assistidos'),
              subtitle: Text('$totalAssistidos filmes'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () async {
                // navigator.push abre a nova tela e o await espera a tela ser fechada para atualizar a tela inicial com o setState
                await Navigator.push(
                  context,
                  // route mostra qual tela abrir
                  MaterialPageRoute(builder: (_) => const TelaListaAssistidos()),
                );
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }
}

// tela de watchlist
class TelaListaAssistir extends StatelessWidget {
  const TelaListaAssistir({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filmes a Assistir')),
      body: const Center(child: Text('Em construção')),
    );
  }
}

// tela de filmes assistidos
class TelaListaAssistidos extends StatelessWidget {
  const TelaListaAssistidos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filmes Assistidos')),
      body: const Center(child: Text('Em construção')),
    );
  }
}