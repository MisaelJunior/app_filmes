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
class TelaListaAssistir extends StatefulWidget {
  const TelaListaAssistir({super.key});

  @override
  State<TelaListaAssistir> createState() => _TelaListaAssistirState();
}

class _TelaListaAssistirState extends State<TelaListaAssistir> {

  final TextEditingController campoNomeFilme = TextEditingController();

  // fun;ao de adicionar o filme na lista
  void adicionarFilme() {
    //salva o valor do campoNomeFilme na variavel; o trim remove os espaços em branco do inicio e do fim da string
    String nomeFilme = campoNomeFilme.text.trim();
    //verifica de o campo nao esta vazio, se nao estiver adiciona o filme na lista e limpa o campo de texto com o clear
    if (nomeFilme.isNotEmpty) {
      setState(() {
        filmes.add(Filme(titulo: nomeFilme));
        campoNomeFilme.clear();
      });
    }
    //se o campo estiver vazio, nao faz nada
    else if (nomeFilme.isEmpty) {
      return;
    }
  }

  @override
  void dispose() {
    // libera a memoria do campoNomeFilme quando a tela for fechada
    campoNomeFilme.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //filtra os filmes nao assistidos
    List<Filme> filmesNaoAssistidos = filmes.where((filme) => !filme.assistido).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Filmes a Assistir')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: campoNomeFilme,
                    decoration: const InputDecoration(
                      labelText: 'Nome do Filme',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: adicionarFilme,
                  child: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              //listview.builder cria a lista de filmes e o itemBuilder é a função que cria cada item da lista
              child: ListView.builder(
                itemCount: filmesNaoAssistidos.length,
                //itembuilder constroi cada item da lista, recebe o contexto e o index do item (tipo um laço for)
                itemBuilder: (context, index) {
                  final filme = filmesNaoAssistidos[index];
                  return ListTile(
                    title: Text(filme.titulo),
                    trailing: Checkbox(
                      value: filme.assistido,
                      onChanged: (_) {
                        setState(() {
                          filme.assistido = true;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
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