// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:byte_super_app/app/core/database/sqlite_connection_factory.dart';
import 'package:byte_super_app/app/core/exceptions/repository_exception.dart';
import 'package:byte_super_app/app/core/rest/custom_dio.dart';
import 'package:byte_super_app/app/models/coletor/coletor_dados_model.dart';
import 'package:byte_super_app/app/models/coletor/produto_coletor_model.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import 'coletor_dados_repository.dart';

class ColetorDadosRepositoryImpl implements ColetorDadosRepository {
  final SqliteConnectionFactory _sqliteConnectionFactory;
  final CustomDio _dio;

  ColetorDadosRepositoryImpl({
    required SqliteConnectionFactory sqliteConnectionFactory,
    required CustomDio dio,
  })  : _sqliteConnectionFactory = sqliteConnectionFactory,
        _dio = dio;

  @override
  Future<void> deleteProdColetor() async {
    try {
      final conn = await _sqliteConnectionFactory.openConnection();
      conn.delete('PRODUTO_COLETOR');
    } on Exception catch (e, s) {
      log('ERRO ', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar');
    }
  }

  @override
  Future<String> getAndInsertProdutos(String url) async {
    try {
      Response result = await _dio.get('$url/produto/gtins');
      if (result.statusCode == 200) {
        var produtos = result.data;

        final conn = await _sqliteConnectionFactory.openConnection();
        for (var element in produtos) {
          // await conn.transaction(
          //   (txn) => txn.insert(
          //     'PRODUTO_COLETOR',
          //     {
          //       'COD_BARRAS': element,
          //     },
          //   ),
          // );
          conn.insert('PRODUTO_COLETOR', {
            'COD_BARRAS': element,
          });
        }
        // _sqliteConnectionFactory.closeConnection();
        return 'OK';
      } else {
        return 'ERRO';
      }
    } on DioException catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);

      throw RepositoryException(message: 'Erro ao buscar produtos');
    }
  }

  @override
  Future<ProdutoColetorModel> findProdColetor(String codBarras) async {
    try {
      final conn = await _sqliteConnectionFactory.openConnection();

      final item = await conn.query('PRODUTO_COLETOR',
          where: 'COD_BARRAS = ?', whereArgs: [codBarras]);

      if (item.isNotEmpty) {
        final value = item.map((e) => ProdutoColetorModel.fromMap(e)).first;
        return value;
      } else {
        return ProdutoColetorModel(id: 0, codBarras: '');
      }
    } on Exception catch (e, s) {
      log('ERRO ', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar item do coletor');
    }
  }

  @override
  Future<void> updateColetor(String codBarras, double qtdd) async {
    final conn = await _sqliteConnectionFactory.openConnection();
    final item = await conn.query('COLETOR_DADOS',
        where: 'COD_BARRAS = ?', whereArgs: [codBarras]);
    if (item.isNotEmpty) {
      //  final conn = await _sqliteConnectionFactory.openConnection();
      final retorno = item.map((e) => ColetorDadosModel.fromMap(e)).first;
      await conn.update(
        'COLETOR_DADOS',
        {
          'COD_BARRAS': codBarras,
          'QTDD': qtdd,
          'SINCRONIZADO': 'N',
        },
        where: 'id = ?',
        whereArgs: [retorno.id],
      );
    } else {
      await conn.insert('COLETOR_DADOS', {
        'id': null,
        'COD_BARRAS': codBarras,
        'QTDD': qtdd,
        'SINCRONIZADO': 'N',
      });
    }
  }

  @override
  Future<void> deleteColetor() async {
    try {
      final conn = await _sqliteConnectionFactory.openConnection();
      conn.delete('COLETOR_DADOS');
    } on Exception catch (e, s) {
      log('ERRO ', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar');
    }
  }

  @override
  Future<List<ColetorDadosModel>> findAllColetor() async {
    try {
      final conn = await _sqliteConnectionFactory.openConnection();

      final item = await conn.query(
        'COLETOR_DADOS',
        where: 'SINCRONIZADO = ?',
        whereArgs: ['N'],
      );
      if (item.isNotEmpty) {
        final value = item.map((e) => ColetorDadosModel.fromMap(e)).toList();
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
  Future<void> deleteProdListColetor(ColetorDadosModel prodColetor) async {
    try {
      final conn = await _sqliteConnectionFactory.openConnection();
      conn.delete('COLETOR_DADOS',
          where: 'id = ?', whereArgs: [prodColetor.id]);
    } on Exception catch (e, s) {
      log('ERRO ', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar');
    }
  }

  @override
  Future<double> getQtddProdLsitColetor(String codBarras) async {
    try {
      final conn = await _sqliteConnectionFactory.openConnection();

      final item = await conn.query('COLETOR_DADOS',
          where: 'COD_BARRAS = ?', whereArgs: [codBarras]);

      if (item.isNotEmpty) {
        final value = item.map((e) => ColetorDadosModel.fromMap(e)).first;
        return value.qtdd;
      } else {
        return 0;
      }
    } on Exception catch (e, s) {
      log('ERRO ', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar item da nota');
    }
  }

  @override
  Future<void> restauraDadosEnviados() async {
    final conn = await _sqliteConnectionFactory.openConnection();

    await conn.update(
      'COLETOR_DADOS',
      {
        'SINCRONIZADO': 'N',
      },
      where: 'SINCRONIZADO = ?',
      whereArgs: ['S'],
    );
  }

  @override
  Future<void> deleteColetorEnviados() async {
    try {
      final conn = await _sqliteConnectionFactory.openConnection();
      conn.delete('COLETOR_DADOS', where: 'SINCRONIZADO = ?', whereArgs: ['S']);
    } on Exception catch (e, s) {
      log('ERRO ', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar');
    }
  }

  @override
  Future<String> send(
      String url, List<ColetorDadosModel> listColetor, int userId) async {
    try {
      final dados = <Map<String, dynamic>>[];
      String dataAtual = DateFormat('dd/MM/yyyy').format(DateTime.now());
      for (var element in listColetor) {
        dados.add({
          "ID": element.id,
          "COD_PROD": 1,
          "COD_BARRA": element.codBarras,
          "QUANTIDADE": '${element.qtdd}',
          "COD_USUARIO": userId,
          "DATA": dataAtual,
          "BAIXADO": "X",
          "ENVIADO": false,
        });
      }

      json.encode(dados);

      Response result = await _dio.post('$url/v2/coletordados', data: dados);
      if (result.data['erro'] == true) {
        return 'ERRO';
      } else {
        return 'OK';
      }
    } on Exception catch (e, s) {
      log('ERRO ', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao enviar');
    }
  }

  @override
  Future<String> updateColetorStatusEnviado() async {
    try {
      final conn = await _sqliteConnectionFactory.openConnection();

      await conn.update(
        'COLETOR_DADOS',
        {
          'SINCRONIZADO': 'S',
        },
        where: 'SINCRONIZADO = ?',
        whereArgs: ['N'],
      );
      return 'OK';
    } catch (e, s) {
      log('ERRO ', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro update coletor sincronizado');
    }
  }
}
