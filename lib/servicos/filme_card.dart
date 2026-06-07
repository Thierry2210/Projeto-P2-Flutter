import 'package:flutter/material.dart';
import '../modelos/filmes.dart';

class FilmeCard extends StatelessWidget {
  final Filme filme;
  final VoidCallback onToggleAssistido;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  // Recebendo os parâmetros necessários
  const FilmeCard({
    super.key,
    required this.filme,
    required this.onToggleAssistido,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: IconButton(
          icon: Icon(
            filme.assistido ? Icons.visibility : Icons.visibility_off,
            color: filme.assistido ? Colors.green : Colors.grey,
          ),
          onPressed: onToggleAssistido,
        ),
        title: Text(filme.titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(filme.genero),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
        onTap: onTap, // Clica para ir para a tela de detalhes
      ),
    );
  }
}