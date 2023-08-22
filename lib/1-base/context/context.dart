import 'dart:developer';
import 'package:controle_estoque_amostras_app/1-base/models/register/register.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

const _nomeBanco = "BK_LAGenPe.db";
const _databaseVersion = 1;

class Context {
  late Database database;
  static final Context _context = Context._internal();
  factory Context() => _context;
  Context._internal();
  Future<String> get pathDatabase async {
    final directory = await getApplicationDocumentsDirectory();
    return "${directory.path}/$_nomeBanco.db";
  }

  Future<Database> initializeDatabase({String? path}) async {
    path ??= await pathDatabase;
    debugPrint(path);
    final database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createDb,
      onUpgrade: _updgradeDb,
    );
    this.database = database;
    return database;
  }

  Future<void> _updgradeDb(Database db, int oldVersion, int newVersion) async {
    try {
      int oldVersionAux = oldVersion;
      while (oldVersionAux < newVersion) {
        switch (oldVersionAux) {
          case 1:
            // await Migration1(db).executaMigrations();
            break;
          default:
            log("Sem migrations", name: "SQLITE");
        }
        oldVersionAux++;
      }
    } catch (_) {}
  }

  Future<void> _createDb(Database db, int newVersion) async {
    final tabelas = [
      Register.scriptSqlite,
    ];
    for (final tabela in tabelas) {
      try {
        await db.execute(tabela);
      } catch (_) {
        log("Erro ao executar $tabela", name: "LOG - Erro Ocorrido");
      }
    }
  }
}
