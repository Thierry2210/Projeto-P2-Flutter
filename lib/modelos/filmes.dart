class Filme {
  int id;
  String titulo;
  String genero;
  bool assistido;

  Filme({
    required this.id, 
    required this.titulo, 
    required this.genero, 
    required this.assistido
  });

  factory Filme.fromMap(Map<String, dynamic> map) {
    return Filme(
      id: map["id"],
      titulo: map["titulo"], 
      genero: map["genero"],
      assistido: map["assistido"] == 1 ? true : false
    );
  }
}