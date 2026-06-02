import 'package:flutter/material.dart';

class SobreScreen extends StatelessWidget {
  final String versaoApp; // Recebendo parâmetro

  const SobreScreen({super.key, required this.versaoApp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre o App')),
      body: Center(
        child: Text(
          'App desenvolvido para a P2\nVersão: $versaoApp',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}