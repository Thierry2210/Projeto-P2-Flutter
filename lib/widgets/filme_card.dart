import 'package:flutter/material.dart';
import '../models/filme.dart';

class FilmeCard extends StatelessWidget {
  final Filme filme;
  final VoidCallback onToggleAssistido;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const FilmeCard({
    super.key,
    required this.filme,
    required this.onToggleAssistido,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            // Imagem ou Placeholder
            Hero(
              tag: 'filme_${filme.id}',
              child: Container(
                width: 100,
                height: 120,
                color: theme.colorScheme.surfaceContainerHighest,
                child: filme.imagemUrl != null && filme.imagemUrl!.isNotEmpty
                    ? Image.network(
                        filme.imagemUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.broken_image,
                          size: 40,
                          color: Colors.grey,
                        ),
                      )
                    : const Icon(
                        Icons.movie_creation_outlined,
                        size: 40,
                        color: Colors.grey,
                      ),
              ),
            ),
            
            // Informações do Filme
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      filme.titulo,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      filme.genero,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          filme.assistido ? Icons.check_circle : Icons.schedule,
                          size: 16,
                          color: filme.assistido ? Colors.green : Colors.orange,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          filme.assistido ? "Assistido" : "Pendente",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: filme.assistido ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Ações (Assistido e Excluir)
            Column(
              children: [
                IconButton(
                  icon: Icon(
                    filme.assistido ? Icons.visibility : Icons.visibility_off,
                    color: filme.assistido ? Colors.green : Colors.grey,
                  ),
                  tooltip: filme.assistido ? "Desmarcar" : "Marcar assistido",
                  onPressed: onToggleAssistido,
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  tooltip: "Excluir filme",
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}