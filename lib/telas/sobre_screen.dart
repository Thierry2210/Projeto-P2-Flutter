import 'package:flutter/material.dart';

class SobreScreen extends StatelessWidget {
  // REQUISITO: Passagem de Parâmetros entre telas
  final String nomeEquipe;

  const SobreScreen({super.key, required this.nomeEquipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sobre o Projeto")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.school, size: 80, color: Colors.deepPurple),
              const SizedBox(height: 20),
              const Text("Projeto P2 - Sistemas Móveis", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("Equipe: $nomeEquipe", style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 30),
              const Text(
                "Este aplicativo atende a todos os requisitos solicitados: 3 telas, SQLite, Statefulness, Widget separado, Drawer lateral e Fontes do Google.",
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}