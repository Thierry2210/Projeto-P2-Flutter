import 'package:flutter/material.dart';
import '../models/filme.dart';

class DetalhesScreen extends StatelessWidget {
  final Filme filmeSelecionado;

  const DetalhesScreen({super.key, required this.filmeSelecionado});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                filmeSelecionado.titulo,
                style: const TextStyle(
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black87, blurRadius: 6)],
                ),
              ),
              background: Hero(
                tag: 'filme_${filmeSelecionado.id}',
                child: filmeSelecionado.imagemUrl != null && filmeSelecionado.imagemUrl!.isNotEmpty
                    ? Image.network(
                        filmeSelecionado.imagemUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: theme.colorScheme.surfaceContainerHighest,
                          child: const Icon(Icons.broken_image, size: 80, color: Colors.grey),
                        ),
                      )
                    : Container(
                        color: theme.colorScheme.surfaceContainerHighest,
                        child: const Icon(Icons.movie, size: 100, color: Colors.grey),
                      ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.category, color: theme.colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        "Gênero",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                     filmeSelecionado.genero,
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Icon(
                        filmeSelecionado.assistido ? Icons.check_circle : Icons.schedule,
                        color: filmeSelecionado.assistido ? Colors.green : Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Status",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: filmeSelecionado.assistido 
                          ? Colors.green.withOpacity(0.1) 
                          : Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: filmeSelecionado.assistido ? Colors.green : Colors.orange,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          filmeSelecionado.assistido ? 'Já assistido' : 'Quero assistir',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: filmeSelecionado.assistido ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(filmeSelecionado.assistido ? '✅' : '⏳', style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}