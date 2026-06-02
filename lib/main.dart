import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'telas/home_screen.dart';

void main() {
  runApp(const MeuAppP2());
}

class MeuAppP2 extends StatelessWidget {
  const MeuAppP2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App P2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Uso de biblioteca do pub.dev (Google Fonts)
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      home: const HomeScreen(titulo: 'Catálogo de Usuários'), // Parâmetro passado
    );
  }
}