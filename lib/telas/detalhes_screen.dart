import 'package:flutter/material.dart';
import '../modelos/filmes.dart';

class DetalhesScreen extends StatelessWidget {
  // REQUISITO: Passagem de Parâmetros entre telas
  final Filme filmeSelecionado;

  const DetalhesScreen({super.key, required this.filmeSelecionado});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detalhes do Filme")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("🎬 Título: ${filmeSelecionado.titulo}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text("🎭 Gênero: ${filmeSelecionado.genero}", style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            Text(
              "Status: ${filmeSelecionado.assistido ? 'Já assistido ✅' : 'Quero assistir ⏳'}",
              style: TextStyle(fontSize: 20, color: filmeSelecionado.assistido ? Colors.green : Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}