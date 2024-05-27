import 'dart:convert';
import 'dart:developer';

import 'package:byte_super_app/app/core/database/sqlite_connection_factory.dart';
import 'package:byte_super_app/app/core/exceptions/repository_exception.dart';
import 'package:byte_super_app/app/core/rest/custom_dio.dart';
import 'package:byte_super_app/app/models/conferencia/item_nota_entrada_model.dart';
import 'package:byte_super_app/app/repositories/item_nota_entrada/item_nota_entrada_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

class ItemNotaEntradaRepositoryImpl implements ItemNotaEntradaRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;
  final CustomDio _dio;

  ItemNotaEntradaRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
    required CustomDio dio,
  })  : _sqliteConnectionFactory = sqliteConnectionFactory,
        _dio = dio;

  @override
  Future<List<ItemNotaEntradaModel>> findRegister(int idNota) async {
    try {
      final conn = await _sqliteConnectionFactory.openConnection();
      final item = await conn
          .query('ITEM_NOTA', where: 'ID_NOTA=?', whereArgs: [idNota]);
      if (item.isNotEmpty) {
        final value = item.map((e) => ItemNotaEntradaModel.fromMap(e)).toList();
        return value;
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('ERRO ', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar item da nota');
    }
  }

  @override
  Future<int> insert(ItemNotaEntradaModel itemNota) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    return conn.insert('ITEM_NOTA', {
      'id': null,
      'ID_NOTA': itemNota.idNota,
      'COD_BARRAS': itemNota.codBarras,
      'QTDD': itemNota.quantidade,
    });
  }

  @override
  Future<void> delete(ItemNotaEntradaModel itemNotaEntrada) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    conn.delete(
      'ITEM_NOTA',
      where: 'id = ?',
      whereArgs: [itemNotaEntrada.id],
    );
  }

  @override
  Future<void> deleteAllItens(int idNota) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    conn.delete(
      'ITEM_NOTA',
      where: 'ID_NOTA = ?',
      whereArgs: [idNota],
    );
  }

  @override
  Future<void> update(ItemNotaEntradaModel itemNotaEntrada) async {
    try {
      final conn = await _sqliteConnectionFactory.openConnection();
      conn.update(
        'ITEM_NOTA',
        itemNotaEntrada.toMap(),
        where: 'id = ?',
        whereArgs: [itemNotaEntrada.id],
      );
    } on DioException catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw RepositoryException(message: 'Erro ao realizar login');
    }
  }

  @override
  Future<String> send(List<ItemNotaEntradaModel> listaItens, String url,
      int idNota, int idUser) async {
    try {
      final itens = listaItens.map((e) {
        String qtd = '${e.quantidade}'.replaceAll('.', ',');
        return {
          "COD_BARRAS": e.codBarras,
          "QTDD": qtd,
        };
      }).toList();

      final dados = <String, dynamic>{"id": idNota, "itens": itens};

      json.encode(dados);

      Response result = await _dio.post('$url/notasentrada', data: dados);
      if (result.data['erro'] == true) {
        return 'ERRO';
      } else {
        return 'OK';
      }
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      // if (e.response?.statusCode == 401) {
      //   throw UnauthorizedException();
      // }
      throw RepositoryException(message: 'Erro ao realizar login');
    }
  }
}
