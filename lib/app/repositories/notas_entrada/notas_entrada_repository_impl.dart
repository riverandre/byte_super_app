// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:byte_super_app/app/core/database/sqlite_connection_factory.dart';
import 'package:byte_super_app/app/core/exceptions/repository_exception.dart';
import 'package:dio/dio.dart';

import 'package:byte_super_app/app/core/rest/custom_dio.dart';
import 'package:byte_super_app/app/models/conferencia/nota_entrada_model.dart';

import 'notas_entrada_repository.dart';

class NotasEntradaRepositoryImpl implements NotasEntradaRepository {
  final CustomDio _dio;
  final SqliteConnectionFactory _sqliteConnectionFactory;
  NotasEntradaRepositoryImpl({
    required CustomDio dio,
    required SqliteConnectionFactory sqliteConnectionFactory,
  })  : _dio = dio,
        _sqliteConnectionFactory = sqliteConnectionFactory;

  @override
  Future<void> findNotas(String url) async {
    try {
      Response result = await _dio.get('$url/notasentrada');
      if (result.statusCode != 204) {
        List<NotaEntradaModel> notaList = result.data
            .map<NotaEntradaModel>((e) => NotaEntradaModel.fromMap(e))
            .toList();
        final conn = await _sqliteConnectionFactory.openConnection();
        for (var element in notaList) {
          conn.insert('NOTA', {
            'ID': element.id,
            'CONFERENCIA': element.status,
            'NOME': element.fornecedor,
            'DATA': element.data,
          });
        }
      }
    } on DioException catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);

      throw RepositoryException(message: 'Erro ao buscar notas');
    }
  }

  @override
  Future<void> deleteStatus() async {
    final conn = await _sqliteConnectionFactory.openConnection();
    conn.delete(
      'NOTA',
      where: 'CONFERENCIA <> ?',
      whereArgs: ['S'],
    );
  }

  @override
  Future<int> update(NotaEntradaModel nota) async {
    try {
      final conn = await _sqliteConnectionFactory.openConnection();

      return await conn.update(
        'NOTA',
        nota.toMap(),
        where: 'ID = ?',
        whereArgs: [nota.id],
      );
    } on Exception catch (e, s) {
      log('ERRO ', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao alterar status da nota');
    }
  }

  @override
  Future<List<NotaEntradaModel>> findNotasLocalPendente() async {
    try {
      final conn = await _sqliteConnectionFactory.openConnection();

      final item =
          await conn.query('NOTA', where: 'CONFERENCIA <> ?', whereArgs: ['S']);

      if (item.isNotEmpty) {
        final value = item.map((e) => NotaEntradaModel.fromMap(e)).toList();
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
  Future<List<NotaEntradaModel>> findNotasLocalEnviado() async {
    try {
      final conn = await _sqliteConnectionFactory.openConnection();

      final item =
          await conn.query('NOTA', where: 'CONFERENCIA = ?', whereArgs: ['S']);

      if (item.isNotEmpty) {
        final value = item.map((e) => NotaEntradaModel.fromMap(e)).toList();
        return value;
      } else {
        return [];
      }
    } on Exception catch (e, s) {
      log('ERRO ', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar item da nota');
    }
  }
}
