import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';

import '../../core/exceptions/repository_exception.dart';

import './auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<String> login(String usuario, String password, url) async {
    try {
      final dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 20),
        ),
      );

      final result = await dio.post('$url/usuario/login', data: {
        'usuario': usuario,
        'senha': password,
      });
      final active = result.data['STATUS'];
      final user = result.data['NOME'];
      final filial = result.data['FILIAL'];
      if (active == null) {
        throw UnauthorizedException();
      } else {
        return filial + "&&" + user;
      }
    } on DioException catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      if (e.response?.statusCode == 401) {
        throw UnauthorizedException();
      }
      throw RepositoryException(message: 'Erro ao realizar login');
    }
  }
}
