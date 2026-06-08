import 'package:flutter/material.dart';
import '../models/filme.dart';
import '../database/dao.dart';
import '../widgets/filme_card.dart';
import 'detalhes_screen.dart';
import 'sobre_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Filme> _filmes = [];
  bool _isLoading = true;

  final _tituloController = TextEditingController();
  final _generoController = TextEditingController();
  final _imagemUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _atualizarLista();
  }

  Future<void> _atualizarLista() async {
    setState(() => _isLoading = true);
    final lista = await DAO.obterTodos();
    setState(() {
      _filmes = lista;
      _isLoading = false;
    });
  }

  void _adicionarFilme() async {
    final titulo = _tituloController.text.trim();
    final genero = _generoController.text.trim();
    final imagemUrl = _imagemUrlController.text.trim();

    if (titulo.isEmpty || genero.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Título e gênero são obrigatórios!"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    var novoFilme = Filme(
      id: 0,
      titulo: titulo,
      genero: genero,
      assistido: false,
      imagemUrl: imagemUrl.isNotEmpty ? imagemUrl : null,
    );

    await DAO.incluir(novoFilme);
    
    _tituloController.clear();
    _generoController.clear();
    _imagemUrlController.clear();
    
    // Esconder o teclado
    FocusScope.of(context).unfocus();
    
    _atualizarLista();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Filme adicionado com sucesso!"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _generoController.dispose();
    _imagemUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Catálogo de Filmes"),
        backgroundColor: theme.colorScheme.inversePrimary,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
              ),
              accountName: const Text(
                'Menu P2',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              accountEmail: const Text('Sistemas Móveis'),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.movie, size: 40, color: Colors.deepPurple),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Sobre o App'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SobreScreen(nomeEquipe: "Matheus, Luiz, Vinícius"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Formulário de Adição
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _tituloController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Título",
                          prefixIcon: Icon(Icons.title),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _generoController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Gênero (Ex: Ação)",
                          prefixIcon: Icon(Icons.category),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _imagemUrlController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "URL da Imagem (Opcional)",
                          prefixIcon: Icon(Icons.image),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: _adicionarFilme,
                      icon: const Icon(Icons.add),
                      label: const Text("Adicionar"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),

          // Lista de Filmes
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filmes.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.movie_filter_outlined,
                              size: 80,
                              color: theme.colorScheme.primary.withOpacity(0.5),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Nenhum filme cadastrado.",
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Adicione seu primeiro filme acima!",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
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
                                MaterialPageRoute(
                                  builder: (context) => DetalhesScreen(filmeSelecionado: filme),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}