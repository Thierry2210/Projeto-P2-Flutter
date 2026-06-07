import "package:flutter/material.dart";
import "package:sqflite/sqflite.dart" as sql;
import "../modelos/filmes.dart";
import "dart:async";

List<Filme> _filmesMock = [];

class DAO {
  static Future<void> criarTabelas(sql.Database database) async {
    await database.execute("""
      CREATE TABLE filmes (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        titulo TEXT NOT NULL,
        genero TEXT,
        assistido BOOLEAN
      );
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      "filmesdb.db",
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await criarTabelas(database);
      },
    );
  }

  static Future<int> incluir(Filme filme) async {
    try {
      final db = await DAO.db();
      final dados = {"titulo": filme.titulo, "genero": filme.genero, "assistido": filme.assistido ? 1 : 0};
      return await db.insert("filmes", dados);
    } catch (e) {
      _filmesMock.add(Filme(
        id: _filmesMock.length + 1,
        titulo: filme.titulo,
        genero: filme.genero,
        assistido: filme.assistido,
      ));
      return _filmesMock.length;
    }
  }

  static Future<List<Filme>> obterTodos() async {
    try {
      final db = await DAO.db();
      List<Map<String, dynamic>> maps = await db.query("filmes", orderBy: "titulo");
      return maps.map((map) => Filme.fromMap(map)).toList();
    } catch (e) {
      return _filmesMock;
    }
  }

  static Future<int> alterar(Filme filme) async {
    try {
      final db = await DAO.db();
      final dados = {"titulo": filme.titulo, "genero": filme.genero, "assistido": filme.assistido ? 1 : 0};
      return await db.update("filmes", dados, where: "id = ?", whereArgs: [filme.id]);
    } catch (e) {
      for (int i = 0; i < _filmesMock.length; i++) {
        if (_filmesMock[i].id == filme.id) {
          _filmesMock[i] = filme;
          return 1;
        }
      }
      return 0;
    }
  }

  static Future<bool> excluir(int id) async {
    try {
      final db = await DAO.db();
      await db.delete("filmes", where: "id = ?", whereArgs: [id]);
      return true;
    } catch (erro) {
      _filmesMock.removeWhere((f) => f.id == id);
      debugPrint("Falha na exclusão: $erro");
      return true;
    }
  } 
}