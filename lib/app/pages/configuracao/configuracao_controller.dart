import 'dart:developer';

import 'package:byte_super_app/app/core/exceptions/repository_exception.dart';
import 'package:byte_super_app/app/core/mixins/loader_mixin.dart';
import 'package:byte_super_app/app/core/mixins/messages_mixin.dart';
import 'package:byte_super_app/app/models/configuracao/configuracao_model.dart';
import 'package:byte_super_app/app/repositories/configuracao/configuracao_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfiguracaoController extends GetxController
    with LoaderMixin, MessagesMixin {
  final ConfiguracaoRepository _configRepository;

  final ipInternoEC = TextEditingController();
  final ipExternoEC = TextEditingController();
  final portaEC = TextEditingController();

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();
  late ConfiguracaoModel config;

  ConfiguracaoController({
    required ConfiguracaoRepository configRespository,
  }) : _configRepository = configRespository;

  @override
  void onInit() {
    super.onInit();

    loaderListener(_loading);
    messageListener(_message);
  }

  @override
  void dispose() {
    super.dispose();
    ipInternoEC.dispose();
    ipExternoEC.dispose();
    portaEC.dispose();
  }

  @override
  Future<void> onReady() async {
    super.onReady();

    await getDados();
  }

  Future<void> getDados() async {
    try {
      final result = await _configRepository.findFirst();
      config = result;
      if (config.id != 0) {
        ipInternoEC.text = config.ipInterno;
        ipExternoEC.text = config.ipExterno!;
        portaEC.text = '${config.porta}';
      }
    } catch (e, s) {
      _loading.toggle();
      log('Erro ao buscar registro', error: e, stackTrace: s);

      throw RepositoryException(message: 'Erro ao buscar registro');
    }
  }

  Future<void> updateConfig() async {
    try {
      _loading.toggle();
      config.ipInterno = ipInternoEC.text;
      config.ipExterno = ipExternoEC.text;
      config.porta = int.parse(portaEC.text);
      String url = ipInternoEC.text != ''
          ? 'http://${config.ipInterno}:${config.porta}'
          : 'http://${config.ipExterno}:${config.porta}';

      String value = await _configRepository.testConnection(url);
      if (value == 'OK') {
        await _configRepository.update(config);
        _loading.toggle();

        Get.offAllNamed('/auth/login');
      } else {
        _loading.toggle();
        _message(MessageModel(
          title: 'ERRO',
          message: 'Erro ao sincronizar com servidor',
          type: MessageType.error,
        ));
      }
    } catch (e, s) {
      _loading.toggle();
      _message(MessageModel(
        title: 'Erro',
        message: 'Erro ao atualizar registro',
        type: MessageType.error,
      ));
      log('Erro ao atualizar registro', error: e, stackTrace: s);

      throw RepositoryException(message: 'Erro em atualizar registro');
    }
  }

  Future<void> insertConfig() async {
    try {
      _loading.toggle();
      config.ipInterno = ipInternoEC.text;
      config.ipExterno = ipExternoEC.text;
      config.porta = int.parse(portaEC.text);

      String url = ipInternoEC.text != ''
          ? 'http://${config.ipInterno}:${config.porta}/'
          : 'http://${config.ipExterno}:${config.porta}/';

      String value = await _configRepository.testConnection(url);
      if (value == 'OK') {
        await _configRepository.insert(config);
        _loading.toggle();
        Get.offAllNamed('/auth/login');
      } else {
        _loading.toggle();
        _message(MessageModel(
          title: 'ERRO',
          message: 'Servidor não encontrado ou fora do ar.',
          type: MessageType.error,
        ));
      }

      // _message(MessageModel(
      //   title: 'Aviso',
      //   message: 'Cadastrado com sucesso',
      //   type: MessageType.suss,
      // ));
    } catch (e, s) {
      _loading.toggle();
      log('Erro ao inserir registro', error: e, stackTrace: s);
      _message(MessageModel(
        title: 'ERRO',
        message: 'Servidor não encontrado ou fora do ar.',
        type: MessageType.error,
      ));
      throw RepositoryException(
          message: 'Servidor não encontrado ou fora do ar.');
    }
  }
}
