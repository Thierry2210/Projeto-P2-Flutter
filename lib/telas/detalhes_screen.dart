import 'package:flutter/material.dart';

class DetalhesScreen extends StatelessWidget {
  final Map<String, dynamic> usuario; // Recebendo parâmetro

  const DetalhesScreen({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(usuario['name'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${usuario['email']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Telefone: ${usuario['phone']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Website: ${usuario['website']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Empresa: ${usuario['company']['name']}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}