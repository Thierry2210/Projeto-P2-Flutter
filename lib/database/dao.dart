import "package:flutter/material.dart";
import "package:sqflite/sqflite.dart" as sql;
import "../models/filme.dart";
import "dart:async";

List<Filme> _filmesMock = [];

class DAO {
  static Future<void> criarTabelas(sql.Database database) async {
    await database.execute("""
      CREATE TABLE filmes (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        titulo TEXT NOT NULL,
        genero TEXT,
        assistido BOOLEAN,
        imagem_url TEXT
      );
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      "filmesdb.db",
      version: 2,
      onCreate: (sql.Database database, int version) async {
        await criarTabelas(database);
      },
      onUpgrade: (sql.Database database, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          await database.execute("ALTER TABLE filmes ADD COLUMN imagem_url TEXT;");
        }
      }
    );
  }

  static Future<int> incluir(Filme filme) async {
    try {
      final db = await DAO.db();
      return await db.insert("filmes", filme.toMap());
    } catch (e) {
      _filmesMock.add(Filme(
        id: _filmesMock.length + 1,
        titulo: filme.titulo,
        genero: filme.genero,
        assistido: filme.assistido,
        imagemUrl: filme.imagemUrl,
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
      return await db.update("filmes", filme.toMap(), where: "id = ?", whereArgs: [filme.id]);
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