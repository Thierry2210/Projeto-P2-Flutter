import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'telas/home_screen.dart';

void main() {
  if (!kIsWeb) {
    sqfliteFfiInit();
  }
  runApp(const P2App());
}

const kIsWeb = identical(0, 0.0);

class P2App extends StatelessWidget {
  const P2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catálogo de Filmes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.poppinsTextTheme(), 
      ),
      home: const HomeScreen(),
    );
  }
}