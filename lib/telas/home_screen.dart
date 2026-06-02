import 'package:flutter/material.dart';
import '../servicos/api_service.dart';
import '../servicos/user_card.dart';
import 'detalhes_screen.dart';
import 'sobre_screen.dart';

class HomeScreen extends StatefulWidget {
  final String titulo;
  const HomeScreen({super.key, required this.titulo});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService api = ApiService();
  List<dynamic> users = [];
  bool isLoading = true;
  final int _indiceAtual = 0;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    try {
      final dados = await api.fetchUsers();
      setState(() {
        users = dados;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  void _onTabTapped(int index) {
    if (index == 1) {
      // Navegação para a tela 3 passando parâmetros
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SobreScreen(versaoApp: '1.0.0'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.titulo)),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return UserCard(
                  nome: user['name'],
                  email: user['email'],
                  onTap: () {
                    // Navegação para a tela 2 com passagem de parâmetros
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalhesScreen(usuario: user),
                      ),
                    );
                  },
                );
              },
            ),
      // Uso do componente exigido
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Sobre'),
        ],
      ),
    );
  }
}