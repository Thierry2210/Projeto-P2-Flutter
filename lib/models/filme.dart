class Filme {
  int id;
  String titulo;
  String genero;
  bool assistido;
  String? imagemUrl;

  Filme({
    required this.id, 
    required this.titulo, 
    required this.genero, 
    required this.assistido,
    this.imagemUrl,
  });

  factory Filme.fromMap(Map<String, dynamic> map) {
    return Filme(
      id: map["id"] as int,
      titulo: map["titulo"] as String, 
      genero: map["genero"] as String,
      assistido: map["assistido"] == 1,
      imagemUrl: map["imagem_url"] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "titulo": titulo,
      "genero": genero,
      "assistido": assistido ? 1 : 0,
      "imagem_url": imagemUrl,
    };
  }
}