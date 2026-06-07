import 'package:flutter/material.dart';
import '../modelos/filmes.dart';
import '../banco/dao.dart';
import '../servicos/filme_card.dart';
import 'detalhes_screen.dart';
import 'sobre_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Filme> _filmes = [];
  final _tituloController = TextEditingController();
  final _generoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _atualizarLista();
  }

  void _atualizarLista() async {
    final lista = await DAO.obterTodos();
    setState(() {
      _filmes = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catálogo de Filmes"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text('Menu P2', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Sobre o App'),
              onTap: () {
                Navigator.pop(context); // Fecha o menu
                // Passagem de parâmetro para a tela 3
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SobreScreen(nomeEquipe: "Seu Nome Aqui")),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tituloController,
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Título"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _generoController,
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Gênero (Ex: Ação)"),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_tituloController.text.isNotEmpty && _generoController.text.isNotEmpty) {
                var novoFilme = Filme(id: 0, titulo: _tituloController.text, genero: _generoController.text, assistido: false);
                await DAO.incluir(novoFilme);
                _tituloController.clear();
                _generoController.clear();
                _atualizarLista();
              }
            },
            child: const Text("Adicionar Filme"),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: _filmes.length,
              itemBuilder: (context, index) {
                final filme = _filmes[index];
                return FilmeCard(
                  filme: filme,
                  onToggleAssistido: () async {
                    filme.assistido = !filme.assistido;
                    await DAO.alterar(filme);
                    _atualizarLista();
                  },
                  onDelete: () async {
                    await DAO.excluir(filme.id);
                    _atualizarLista();
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetalhesScreen(filmeSelecionado: filme)),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}