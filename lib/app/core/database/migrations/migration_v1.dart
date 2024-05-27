import 'package:sqflite/sqflite.dart';

import 'migration.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
     CREATE TABLE CONFIGURACAO (id INTEGER PRIMARY KEY AUTOINCREMENT, 
     IP_INTERNO VARCHAR, IP_EXTERNO VARCHAR, PORTA INTEGER);
     ''');

    batch.execute('''
     CREATE TABLE EMPRESA (id INTEGER PRIMARY KEY AUTOINCREMENT, 
     NOME VARCHAR, IP_EXTERNO INTEGER, PORTA INTEGER);
     ''');

    batch.execute('''
     CREATE TABLE ITEM_NOTA (id INTEGER PRIMARY KEY AUTOINCREMENT, 
     ID_NOTA INTEGER, COD_BARRAS VARCHAR, QTDD FLOAT);
     ''');

    batch.execute('''
     CREATE TABLE NOTA (ID INTEGER, NOME VARCHAR, DATA VARCHAR, CONFERENCIA VARCHAR);
     ''');

    batch.execute('''
    CREATE TABLE PRODUTO_COLETOR (id INTEGER PRIMARY KEY AUTOINCREMENT, COD_BARRAS VARCHAR);
    ''');

    batch.execute('''
     CREATE TABLE COLETOR_DADOS (id INTEGER PRIMARY KEY AUTOINCREMENT, 
     COD_BARRAS VARCHAR, QTDD FLOAT, SINCRONIZADO VARCHAR);
     ''');
  }

  @override
  void update(Batch batch) {}
}
