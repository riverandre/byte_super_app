// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:byte_super_app/app/models/configuracao/configuracao_model.dart';
import 'package:dio/dio.dart';

import '../../core/database/sqlite_connection_factory.dart';
import '../../core/exceptions/repository_exception.dart';
import 'configuracao_repository.dart';

class ConfiguracaoRepositoryImpl implements ConfiguracaoRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;
  // final CustomDio _dio;

  ConfiguracaoRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
    // required CustomDio dio,
  }) : _sqliteConnectionFactory = sqliteConnectionFactory;
  // _dio = dio;

  @override
  Future<ConfiguracaoModel> findFirst() async {
    try {
      final conn = await _sqliteConnectionFactory.openConnection();
      final configuracao = await conn.query('CONFIGURACAO');
      if (configuracao.isNotEmpty) {
        List<ConfiguracaoModel> listConfig =
            configuracao.map((e) => ConfiguracaoModel.fromMap(e)).toList();
        ConfiguracaoModel configuracaoModel = listConfig.first;
        return configuracaoModel;
      } else {
        return ConfiguracaoModel(id: 0, ipInterno: '', porta: 0);
      }
    } catch (e, s) {
      log('ERRO ', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar configuração');
    }
  }

  @override
  Future<int> insert(ConfiguracaoModel configuracao) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    return await conn.insert('CONFIGURACAO', {
      'id': null,
      'IP_INTERNO': configuracao.ipInterno,
      'IP_EXTERNO': configuracao.ipExterno,
      'PORTA': configuracao.porta,
    });
  }

  @override
  Future<void> update(ConfiguracaoModel configuracao) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    await conn.update(
      'CONFIGURACAO',
      {
        'IP_INTERNO': configuracao.ipInterno,
        'IP_EXTERNO': configuracao.ipExterno,
        'PORTA': configuracao.porta,
      },
      where: 'id = ?',
      whereArgs: [configuracao.id],
    );
  }

  @override
  Future<String> testConnection(String url) async {
    try {
      final dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 20),
        ),
      );
      final result = await dio.get('$url/testserver');

      // final result = await _dio.get('/testserver');

      if (result.statusCode == 200) {
        return 'OK';
      } else {
        return '';
      }
    } catch (e, s) {
      log('ERRO ', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar configuração');
    }
  }
}
